% FINGERPRINT MATCHING SCORE
%
% Usage:  [ S ] = match( M1, M2, display_flag );
%
% Argument:   M1 -  First Minutiae
%             M2 -  Second Minutiae
%             display_flag
%
% Returns:    S - Similarity Measure

% Vahid. K. Alilou
% Department of Computer Engineering
% The University of Semnan
%
% July 2013

function [ result,result_r,T ] = Copy_of_match( Index,Number,display_flag )
load('db.mat');
T_index=[];
for index = 1 : Number
    r = randperm(7,5)+Index;
    result_r = r;
    if nargin==2; display_flag=0; end
    M1 = ff{Index};
    M2 = ff{r(1)};
    M3 = ff{r(2)};
    M4 = ff{r(3)};
    M5 = ff{r(4)};
    M6 = ff{r(5)};
    M1=M1(M1(:,3)<5,:);
    M2=M2(M2(:,3)<5,:);
    M3=M3(M3(:,3)<5,:);
    M4=M4(M4(:,3)<5,:);
    M5=M5(M5(:,3)<5,:);
    M6=M6(M6(:,3)<5,:);
    
    count1=size(M1,1); count2=size(M2,1);
    count3=size(M3,1); count4=size(M4,1);
    count5=size(M5,1); count6=size(M6,1);
    bi2=0; bj2=0; ba2=0; % Best i,j,alpha
    bi3=0; bj3=0; ba3=0; % Best i,j,alpha
    bi4=0; bj4=0; ba4=0; % Best i,j,alpha
    bi5=0; bj5=0; ba5=0; % Best i,j,alpha
    bi6=0; bj6=0; ba6=0; % Best i,j,alpha
    S2=0;S3=0;S4=0;S5=0;S6=0;% Best Similarity Score
    
 
    for i=1:count1
        T1=transform(M1,i);
        for j=1:count2
            if M1(i,3)==M2(j,3)
                T2=transform(M2,j);
                for a=-10:10                      %Alpha2
                    T22=transform2(T2,a*pi/180);
                    [sm,sm2]=score(T1,T22);
                    if S2<sm
                        S2=sm;
                        bi2=i; bj2=j; ba2=a;T22_=sm2;
                    end
                end
                
                
            end
        end
        for j=1:count3
            if M1(i,3)==M3(j,3)
                T3=transform(M3,j);
                for a=-5:5                      %Alpha3
                    T33=transform2(T3,a*pi/180);
                    [sm,sm3]=score(T1,T33);
                    if S3<sm
                        S3=sm;
                        bi3=i; bj3=j; ba3=a;T33_=sm3;
                    end
                end
            end
        end
        
        
        for j=1:count4
            if M1(i,3)==M4(j,3)
                T4=transform(M4,j);
                for a=-10:10                     %Alpha4
                    T44=transform2(T4,a*pi/180);
                    [sm,sm4]=score(T1,T44);
                    if S4<sm
                        S4=sm;
                        bi4=i; bj4=j; ba4=a;T44_=sm4;
                    end
                end
            end
        end
        
        
        for j=1:count5
            if M1(i,3)==M5(j,3)
                T5=transform(M5,j);
                for a=-5:5                      %Alpha5
                    T55=transform2(T5,a*pi/180);
                    [sm,sm5]=score(T1,T55);
                    if S5<sm
                        S5=sm;
                        bi5=i; bj5=j; ba5=a;T55_=sm5;
                    end
                end
            end
        end
        
        for j=1:count6
            if M1(i,3)==M6(j,3)
                T6=transform(M6,j);
                for a=-5:5                      %Alpha6
                    T66=transform2(T6,a*pi/180);
                    [sm,sm6]=score(T1,T66);
                    if S6<sm
                        S6=sm;
                        bi6=i; bj6=j; ba6=a;T66_=sm6;
                    end
                end
            end
        end
    end
    
    T_index=[T_index;T22_;T33_;T44_;T55_;T66_];
end
I = 0;
for i = 1 :count1
    flag = 1;
    for j =1:Number*5
        if T_index(j,i)==0
            flag = 0;
            break;
        end
    end
    %if T22_(i)~=0 && T33_(i)~=0 && T44_(i)~=0 &&T55_(i)~=0 &&T66_(i)~=0
    if flag == 1
        I = I + 1;
        Dist_index(I,1) = i;
        Dist_index(I,2) = T22_(i);
        Dist_index(I,3) = T33_(i);
        Dist_index(I,4) = T44_(i);
        Dist_index(I,5) = T55_(i);
        Dist_index(I,6) = T66_(i);
    end
end

if display_flag==1
    
    T12=transform(M1,bi2);
    T13=transform(M1,bi3);
    T14=transform(M1,bi4);
    T15=transform(M1,bi5);
    T16=transform(M1,bi6);
   
    
    T2=transform(M2,bj2);
    T22=transform2(T2,ba2*pi/180);
    T3=transform(M3,bj3);
    T33=transform2(T3,ba3*pi/180);
    T4=transform(M4,bj4);
    T44=transform2(T4,ba4*pi/180);
    T5=transform(M5,bj5);
    T55=transform2(T5,ba5*pi/180);
    T6=transform(M6,bj6);
    T66=transform2(T6,ba6*pi/180);
    
   
    %I;
    for  i = 1 : I
        Dist(i,1) = T12(Dist_index(i,1),1);
        Dist(i,2) = T12(Dist_index(i,1),2);
        Dist(i,3) = T22(Dist_index(i,2),1);
        Dist(i,4) = T22(Dist_index(i,2),2);
        
        Dist(i,5) = T13(Dist_index(i,1),1);
        Dist(i,6) = T13(Dist_index(i,1),2);
        Dist(i,7) = T33(Dist_index(i,3),1);
        Dist(i,8) = T33(Dist_index(i,3),2);
        
        Dist(i,9)  = T14(Dist_index(i,1),1);
        Dist(i,10) = T14(Dist_index(i,1),2);
        Dist(i,11) = T44(Dist_index(i,4),1);
        Dist(i,12) = T44(Dist_index(i,4),2);
        
        Dist(i,13)  = T15(Dist_index(i,1),1);
        Dist(i,14) = T15(Dist_index(i,1),2);
        Dist(i,15) = T55(Dist_index(i,5),1);
        Dist(i,16) = T55(Dist_index(i,5),2);
        
        Dist(i,17)  = T16(Dist_index(i,1),1);
        Dist(i,18) = T16(Dist_index(i,1),2);
        Dist(i,19) = T66(Dist_index(i,6),1);
        Dist(i,20) = T66(Dist_index(i,6),2);
        
        if i ~= 1
            Dist(i,21) = sqrt((Dist(i,3)-Dist(1,3))^2+(Dist(i,4)-Dist(1,4))^2);
            Dist(i,22) = sqrt((Dist(i,7)-Dist(1,7))^2+(Dist(i,8)-Dist(1,8))^2);
            Dist(i,23) = sqrt((Dist(i,11)-Dist(1,11))^2+(Dist(i,12)-Dist(1,12))^2);
            Dist(i,24) = sqrt((Dist(i,15)-Dist(1,15))^2+(Dist(i,16)-Dist(1,16))^2);
            Dist(i,25) = sqrt((Dist(i,19)-Dist(1,19))^2+(Dist(i,20)-Dist(1,20))^2);
            Dist(i,26) = sqrt((Dist(i,1)-Dist(1,1))^2+(Dist(i,2)-Dist(1,2))^2);
     
        end
    
    end
    
    %Dist;
    %sortrows(Dist(:,21:25),1);
    %disp([' |  Dist1  |  Dist2  |  Dist3  |  Dist4  |']);
    % Dist;
    T = Dist(:,22:26)
    
    [m,n] = size(T);
    %disp(T(2:m,:));
    for i = 2 : m
        max = 0;
        min = 512;
        for j = 1 : n
            if T(i,j) > max
                max = T(i,j);
                max_index = j;
            end
            if T(i,j) < min
                min = T(i,j);
                min_index = j;
            end
        end
        max = 0;
        min = 512;
        for j = 1 : n
            if T(i,j) > max && j~=max_index
                max = T(i,j);
            end
            if T(i,j) < min && j~=min_index
                min = T(i,j);
            end
        end
        result(i-1)=0;
        
        for j = 1:n
            result(i-1) =  result(i-1)+T(i,j);
        end
        %result(i-1,1) = (min+max)/2;
        %result(i-1,2) = max;
        result(i-1) =  (result(i-1) -max -min)/(n-2);
    end
    %result;
    
    %plot_data(T12,1);
    % plot_data(T22,2);
    
    %plot_data(T13,3);
    %plot_data(T33,4);
    
    %plot_data(T14,1);
    %plot_data(T44,2);
    %{
    S = 1;
    Dis_S=[S2,S3,S4,S5,S6];
    S2;
    S3;
    S4;
    S5;
    S6;
    %}
end
end