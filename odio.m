[y,fs]=audioread('D:\MATLAB\MATLAB Production Server\R2015a\Matlab stuff\helloo.mp3');
[leng,wid]=size(y);
mini=min(y);
z=y-mini;
maxi=max(z);
q=maxi/2^7;
audio=fix(z/q);
wavchar=dec2bin(audio);
for i=1:1:leng
    for j=1:1:8
        wavbinary(i,j)=str2num(wavchar(i,j));
    end
end
wavbinary;

%image
 subplot(3,1,1);
pic=imread('D:/grape.jpg');
imshow(pic);
[row col pan]=size(pic);
w=pic(:,:,1);
   a0=zeros(row,64);
for i=1:1:row
    for j=1:1:64
      a0(i,j)= w(i,j);
    end
end
a0;%pixel values
a=reshape(a0,row*8,8);
B1=zeros(row*64,8);
for i=1:1:row
for j=1:1:8
 for k=8:-1:1
     if i>1
          B1(j+8*(i-1),k)=mod(a(i,j),2);
        a(i,j)=(a(i,j)-B1(j+8*(i-1),k))/2; 
     else
         B1(j,k)=mod(a(i,j),2);
        a(i,j)=(a(i,j)-B1(j,k))/2;
        
     end
 end
end
end
B1;%their binary
for i=1:1:row*8
      for j=1:1:8
          
     B1((j+(8*(i-1))),8)=wavbinary(i,j);
      
      end
  end
  D=zeros(row*8,8);
  D=B1;
  D;
  %lsb changing
  
  d=zeros(1,row*64);
  temp=zeros(1,row*64);
  add=0;
   for i=1:1:row*64
  for j=8:-1:1
  add=add+(D(i,j)*2^(8-j));
  end
 temp(1,i)=add;
 add=0;
   end
    temp; %convert back to decimal
     dummy=zeros(row*8,8);
    for i=1:1:row*8
        for j=1:1:8
            if i==1
            dummy(i,j)=temp(1,j);
            elseif i>1
             dummy(i,j)=temp(1,j+8*(i-1));
            end
        end
    end
    dummy;
    dummy0=reshape(dummy,row,64);%fitting into array of leng*8 size
    for j=1:1:row
    for i=1:1:64
         pic(j,i,1)=dummy0(j,i);
    end
    end
    subplot(3,1,2);
    imshow(pic); %modified pic
    
     %retrieving begins
     r2=pic(:,:,1);
a2=zeros(row,64);
for i=1:1:row
    for j=1:1:64
      a3(i,j)= r2(i,j);
    end
end
a3;
a2=reshape(a3,row*8,8);
%pixel values
B2=zeros(row*64,8);
for i=1:1:row*8
for j=1:1:8
 for k=8:-1:1
     if i==1
         B2(j,k)=mod(a2(i,j),2);
        a2(i,j)=(a2(i,j)-B2(j,k))/2;
     elseif i>1
          B2(8*(i-1)+j,k)=mod(a2(i,j),2);
        a2(i,j)=(a2(i,j)-B2(8*(i-1)+j,k))/2; 
     end
 end
end
end
B2;%binary values of pixels
d2=zeros(1,row*64);
for i=1:1:row*64
   
    d2(1,i)=B2(i,8);
    
end
d2;%ordering
dummy1=zeros(row*8,8);
    for i=1:1:row*8
        for j=1:1:8
            if i==1
            dummy1(i,j)=d2(1,j);
            elseif i>1
             dummy1(i,j)=d2(1,j+8*(i-1));
            end
        end
    end
    dummy1;%fitting
    su=0;
     for i=1:1:row*8
        for k=8:-1:1
            su=su+(dummy1(i,k)*2^(8-k));
        end
        audiodec(i,1)=su;
        su=0;
    end
    audiodec; %convert back to decimal
audio1=audiodec*q;
z1=audio1+mini;
sound(z1,fs)

  