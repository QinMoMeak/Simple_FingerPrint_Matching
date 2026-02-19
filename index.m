for i = 1:8:1240
    i
    for for_times = 1 :10
        for_times
        clear S,r;
        parfor l =1:12
            
            [S(l,:),r(l,:)] = Copy_of_match(i,4,1);
            
            % S2 = Copy_of_match(i,4,1)
            % S3 = Copy_of_match(i,4,1)
            %   S4 = Copy_of_match(i,4,1);
            for j = -3:1
                S(l,:) = round(S(l,:),-j);
                % S2 = round(S2,-j);
                % S3 = round(S3,-j);
                %       S4 = round(S4,-j);
            end
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        if isequal(S(1,:),S(2,:)) == 1
            S1_  = S(1,:);
            r1_ = r(1,:);
        elseif isequal(S(2,:),S(3,:)) == 1
            S1_ = S(2,:);
            r1_ = r(2,:);
        else
            S1_ = S(3,:);
            r1_ = r(3,:);
        end
      
        if isequal(S(4,:),S(5,:)) == 1
            S2_ = S(4,:);
            r2_ = r(4,:);
        elseif isequal(S(5,:),S(6,:)) == 1
            S2_ = S(5,:);
            r2_ = r(5,:);
        else
            S2_ = S(6,:);
            r2_ = r(6,:);
        end
        S1 = reshape(dec2bin(S1_,9),[1,length(S1_)*9]);
        S2 = reshape(dec2bin(S2_,9),[1,length(S2_)*9]);
        fileID = fopen('database\result_1-155.csv','a');
        
        if length(S1)~=length(S2)
            Error = 1;
        else
            Error = sum(S1_~=S2_)/length(S2_);
        end
        fprintf(fileID,'%03d_%04d,%s,%s,%s,%s,%d,%d,%.4f,%.4f,\47%s,\47%s\n ', i,for_times,replace(num2str(r1_),'  ',' '),replace(num2str(S1_),'  ',' '),replace(num2str(r2_),'  ',' '),replace(num2str(S2_),'  ',' '),length(S2),sum(S1~=S2),Error,1-Error,S1,S2);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        if isequal(S(7,:),S(8,:))
            S1_  = S(7,:);
            r1_ = r(7,:);
        elseif isequal(S(8,:),S(9,:))
            S1_ = S(8,:);
            r1_ = r(8,:);
        else
            S1_ = S(9,:);
            r1_ = r(9,:);
        end
      
        if isequal(S(10,:),S(11,:))
            S2_ = S(10,:);
            r2_ = r(10,:);
        elseif isequal(S(11,:),S(12,:))
            S2_ = S(11,:);
            r2_ = r(11,:);
        else
            S2_ = S(12,:);
            r2_ = r(12,:);
        end
        S1 = reshape(dec2bin(S1_,9),[1,length(S1_)*9]);
        S2 = reshape(dec2bin(S2_,9),[1,length(S2_)*9]);
       % fileID = fopen('database\result_1-10.csv','a');
        
        if length(S1)~=length(S2)
            Error = 1;
        else
            Error = sum(S1_~=S2_)/length(S2_);
        end
        fprintf(fileID,'%03d_%04d,%s,%s,%s,%s,%d,%d,%.4f,%.4f,\47%s,\47%s\n ', (i+7)/8,for_times,replace(num2str(r1_),'  ',' '),replace(num2str(S1_),'  ',' '),replace(num2str(r2_),'  ',' '),replace(num2str(S2_),'  ',' '),length(S2),sum(S1~=S2),Error,1-Error,S1,S2);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        
        fclose(fileID);
    end
end
% 列名称
%title={'NO','Train_set','Test_set','Str_len','Diff_len','Error_rate','Similarity'};

%生成表格，按列生成
% VariableNames 参数用于设置列头
%result_table=table(data(:,1),data(:,2),data(:,3),data(:,4),data(:,5),data(:,6),data(:,7),'VariableNames',title)

% 保存数据
%writetable(result_table, '2.csv');
% fileID = fopen('exp.txt','a');
% fprintf(fileID,'%.4f\n ',isequal(S1_,S2_));
% fclose(fileID);