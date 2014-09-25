function baselinedQ = BaselinedQ(MatrixQ, beginsample, endsample)


for i= 1:size(MatrixQ,1)  % de 1 de nombre de ligne/essais)
    baselinedQ(i,:) = MatrixQ(i,:) - ones(1,size(MatrixQ,2))*mean(MatrixQ(i,beginsample:endsample))   ;% baseline
end 
    
 % size(MatrixQ sind die 264 trials und die 1 ist die erste spalte)
 % nimm jetzt für alle individuellen Linien alle Spalten  und mach da 1
 % rein mal den mittelwert von den 500samples bevore onset of the Question.
 