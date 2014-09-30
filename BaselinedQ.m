function baselinedQ = BaselinedQ(MatrixQ, beginsample, endsample)


for i= 1:size(MatrixQ,1)  % de 1 de nombre de ligne/essais)
     baselinedQ(i,:) = MatrixQ(i,:)./ mean(MatrixQ(i,beginsample:endsample)); % normalization. er nimmt den Mittelwert von deiner periode  und dann teile MatrixQ durch den Mittelwert über dieses Zeitfenster.

     baselinedQ(i,:) = (baselinedQ(i,:) - ones(1,size(baselinedQ,2))*mean(baselinedQ(i,beginsample:endsample)));% baseline


end 
    
 % size(MatrixQ sind die 264 trials und die 1 ist die erste spalte)
 % nimm jetzt für alle individuellen Linien alle Spalten  und mach da 1
 % rein mal den mittelwert von den 500samples bevore onset of the Question.
 
 
%  SpaceSpaceDim = find(matrices.matrix(:,5)==1);    % find the indexes for question : Space Space
%  
%  TimeSpaceDim = find(matrices.matrix(:,5)==4);    % find the indexes for question : Time Space
%  
%  TimeTimeDim = find(matrices.matrix(:,5)==2);    % find the indexes for question : TimeTime
%  
%  SpaceTimeDim = find(matrices.matrix(:,5)==3);    % find the indexes for question : SpaceTime
%  
%  for i= 1:size(MatrixQ,1)  % de 1 de nombre de ligne/essais)
%     baselinedQ(i,:) = SpaceSpaceDim(i,:) - ones(1,size(MatrixQ,2))*mean(MatrixQ(i,beginsample:endsample))   ;% baseline
% end 