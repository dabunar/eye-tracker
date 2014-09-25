
function matrix = TheMatrix(run_struct)

% kreiere eine matrix in der du alle infos hast für deine dimensionen
% (SPACE vs TIME) : Spalte1= Ref nummer, Spalte2: block_num, Spalte3= trial_num, Spalte4=
% Dimension, Spalte5= Dummycode, Spalte6= deine PS data, Spatle7=Länge von
% deinen einzelnen Vektoren. Speichern mit SujName_RunNumber_Matrix
% Am Ende kannst du dann die dummycodes dafür benutzen um die vergleiche zu
% machen.

count=1;  % count the indexes for the 8 steps 
count2=0;
count3=0;


for block_num = 1:33
        
    trial_num = [1 2 3 4 5 6 7 8]';
    

    
    % create a colomn with the Refnumbers, Blocknumbers and Trialnumbers
    
    matrix(count:count+7,3) = run_struct(block_num).Ref(1)  % count 1 bis 1+7, da mach mir die Ref reind ie gerade dran ist
    matrix(count:count+7,1) = block_num  % schreibe 8x die Blocknummer auf
    matrix(count:count+7,2) = trial_num  % mach mir den vector 1-8 auf die 8 positionen

    
    for DimQuestion = 1:8 % loops across questions/ dimensions Space Time
        if ~isfield(run_struct(block_num).block(DimQuestion), 'Question')
            continue
        end
        % Colonne pour les Dimensions
            count2=count2+1
            if strcmpi(char(run_struct(block_num).block(DimQuestion).Question),'SPACE')   % 1 = SPace and 2 = Time
                matrix(count2,4) = 1
            else
                matrix(count2,4) = 2
            end
            
        
         
         % Colonne pour les Dummy Codes
         % create a colomn with the Dummycode for the Dimensions
                                % Space Space = 1
                                % Space Time = 2
                                % Time Tme = 3
                                % Time Space = 4

           if DimQuestion == 1   % pour le premier dimension question on met 99 
                matrix(count2,5)=99     % pour le premier dimension de chaque trial pk il n'avait pas de dimension avant.
            else
                if matrix(count2,4)== matrix(count2-1,4) & matrix(count2-1,4)== 1  % wenn count2 derselbe ist wie count2-1 und er ne 1 ist (also space) dann mach als Dummy ne 1
                    matrix(count2,5)= 1
                elseif matrix(count2,4)== matrix(count2-1,4) & matrix(count2-1,4)== 2 % wenn gleich ist und wenn zeit ist =3
                     matrix(count2,5)= 3
                elseif matrix(count2,4)~= matrix(count2-1,4) & matrix(count2-1,4)== 1 % wenn die ungleich sind und der erste space ist
                     matrix(count2,5)= 2
                elseif matrix(count2,4)~= matrix(count2-1,4) & matrix(count2-1,4)== 2  % wenn die ungleich sind und der erste zeit ist =4
                     matrix(count2,5)= 4
                end
           end 
            
           
                    
      % Colonne pour Distance effect (1=close, 2=far)
         count3=count3+1
         if strcmpi(char(run_struct(block_num).block(DimQuestion).trial(2).type),'Close')  
                matrix(count3,6) = 1
            else
                matrix(count3,6) = 2
         end
          
   
    end % end loops across question
        
    count = count+8 % count index est 1 pour le premier et apres c'est updated pour la prochaine ref

    
end



