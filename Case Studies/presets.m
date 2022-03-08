function [g1, g2, g3, g4, g5]= presets(value)

% 0 - unity, 1 - bass, 2 - treble
if value == 0
g1 = 1; % 0 - 60
g2 = 1; % 60 - 680
g3 = 1; % 680 - 3320
g4 = 1; % 3320 - 12680
g5 = 1; % 12680+ 
elseif value ==1
g1 = 5; % 0 - 60
g2 = 1; % 60 - 680
g3 = 1; % 680 - 3320
g4 = 1; % 3320 - 12680
g5 = 1; % 12680+
elseif value ==2
g1 = 1; % 0 - 60
g2 = 1; % 60 - 680
g3 = 1; % 680 - 3320
g4 = 5; % 3320 - 12680
g5 = 5; % 12680+

end

end