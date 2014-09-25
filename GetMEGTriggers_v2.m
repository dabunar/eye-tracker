function qt = GetMEGTriggers(MiniBlock,n,run,triggers,ref,count)        

for i = 1:length(triggers)  % mes triggers je les defini dans "MatchTitles GetMEGTriggers(MiniBlock,n,run,[10 11],3,count);
    addtriggers1 = triggers + ones(1,length(triggers))*1024;  % nimm deine 2 triggers (10 und 11) und eine matrix mit nur 1 und multipliziere diese mit der Zahl
    addtriggers2 = triggers + ones(1,length(triggers))*32768; % wenn der Proband zulange gedrück hat wird er diese Zahl angeben,deshalb soll er nach diesen Zahlen suchen. 
    addtriggers3 = triggers + ones(1,length(triggers))*33792; % weil wir nicht die antworten jetzt wollen sondern die triggers. the last line is when participant pressed both buttons at the same time
end
triggersmod = [triggers addtriggers1 addtriggers2 addtriggers3];



% for all Blocks, check if any of the triggers are available and if so tell
% me the line and colomn

for i = 1:length(triggersmod)  % der soll die 8 möglichkeuiten durchgehen die man gedrück haben könnte
    
    if ref == 1 
        [x{i},y{i}] = find(MiniBlock{n,run}.PrePar{1,count(1)}(:,2)== triggersmod(i));  % x indices de lignes des 11 et y c lindice des colones des 11, qui sont tjr 1
    elseif ref == 2
        [x{i},y{i}] = find(MiniBlock{n,run}.PasPar{1,count(2)}(:,2)== triggersmod(i));  % find the index for each trigger (left,right buttonpress/errors)
    elseif ref == 3
        [x{i},y{i}] = find(MiniBlock{n,run}.FutPar{1,count(3)}(:,2)== triggersmod(i));  % and put it into a vector
    elseif ref == 4
        [x{i},y{i}] = find(MiniBlock{n,run}.PreW{1,count(4)}(:,2)== triggersmod(i));
    elseif ref == 5
        [x{i},y{i}] = find(MiniBlock{n,run}.PreE{1,count(5)}(:,2)== triggersmod(i));
    end
end
  
a1 = [x{1}; x{3}; x{5}; x{7}];      % a1 = time and a2= space   8 times you run the Trials
a2 = [x{2}; x{4}; x{6}; x{8}];      % 
a = [[a1;a2] [ones(length(a1),1)*triggers(1);ones(length(a2),1)*triggers(2)]]; % put them all together and then sort them
a = sortrows(a);

for i = 1:length(a)
    if mod(a(i,2),2) == 0  % if mod (number divided by 2) = 0  then nothing is integer number/ nothing remaining
        qt{i} = 'TIME';
    else
        qt{i} = 'SPACE';
    end
end


