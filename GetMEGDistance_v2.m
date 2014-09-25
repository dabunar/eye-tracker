function dist = GetMEGDistance_v2(MiniBlock,n,run,triggers,ref,count)        

% either triggers =[16:35] and then length= 20 x3. PB: for different Refs
for i = 1:length(triggers)  % mes triggers je les defini dans MatchTitles
    addtriggers1 = triggers + ones(1,length(triggers))*1024;  % left 
    addtriggers2 = triggers + ones(1,length(triggers))*32768;  % right
    addtriggers3 = triggers + ones(1,length(triggers))*33792;  % both
end

triggersmod = [triggers addtriggers1 addtriggers2 addtriggers3];



for i = 1:length(triggersmod) % 80 = 16(ex. distancemod1 )x5
    
  if ref == 1 
   [c{i},d{i}] = find(MiniBlock{n,run}.PrePar{1,count(1)}(:,2)== triggersmod(i));  % c indices de lignes des Distances et d c lindice des colones , qui sont tjr 1
    
  elseif ref == 2
   [c{i},d{i}] = find(MiniBlock{n,run}.PasPar{1,count(2)}(:,2)== triggersmod(i));  % find in each Ref the triggers (left,right buttonpress/errors)
  
        
  elseif ref == 3
    [c{i},d{i}] = find(MiniBlock{n,run}.FutPar{1,count(3)}(:,2)== triggersmod(i));
  
  
  elseif ref == 4
    [c{i},d{i}] = find(MiniBlock{n,run}.PreW{1,count(4)}(:,2)== triggersmod(i));
  
  
  elseif ref == 5
     [c{i},d{i}] = find(MiniBlock{n,run}.PreE{1,count(5)}(:,2)== triggersmod(i));
   
  
  end
end




% 4trigger [16 17 18 19] also 4 x b

b1 = [c{1}; c{5}; c{9}; c{13}];      % 
b2 = [c{2}; c{6}; c{10}; c{12}];
b3=  [c{3}; c{7}; c{11}; c{15}];
b4 = [c{4}; c{8}; c{12}; c{16}];

% la liste des index des triggers et les triggers eux mm
b = [[b1;b2;b3;b4] [ones(length(b1),1)*triggers(1);ones(length(b2),1)*triggers(2);...
    ones(length(b3),1)*triggers(3); ones(length(b4),1)*triggers(4)]];
b = sortrows(b);


% compute the paired and unpaired numbers to devide in close (paired) and far (unpaired)

sorttriggers = sort(triggers);



% for i = 1:length(b)     
%     if (b(i,2) == sorttriggers(1)) % if mod (number divided by 2) = 0  then nothing is integer number/ nothing remaining
%         dist{i} = 'TimeClose';
%     elseif  b(i,2) == sorttriggers(2)
%         dist{i} = 'TimeFar';
%     elseif (b(i,2) == sorttriggers(3)) % if mod (number divided by 2) = 0  then nothing is integer number/ nothing remaining
%         dist{i} = 'SpaceClose';
%     elseif  b(i,2) == sorttriggers(4)
%         dist{i} = 'SpaceFar';
%     end




for i = 1:length(b)     
    if (b(i,2) == sorttriggers(1)) % if mod (number divided by 2) = 0  then nothing is integer number/ nothing remaining
        dist{i} = 'Close';
    elseif  b(i,2) == sorttriggers(2)
        dist{i} = 'Far';
    elseif (b(i,2) == sorttriggers(3)) % if mod (number divided by 2) = 0  then nothing is integer number/ nothing remaining
        dist{i} = 'Close';
    elseif  b(i,2) == sorttriggers(4)
        dist{i} = 'Far';
    end

end
