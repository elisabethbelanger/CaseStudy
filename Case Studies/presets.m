%% Function to output gain values for audio presets
% * Input: integer 'value' corresponding to desired preset; 0 - unity, 1 - bass, 2-
% treble
% * Output: 5 integer gain factors for each filter to create desired preset
%
function [g1, g2, g3, g4, g5]= presets(value)

% 0 - unity, 1 - bass, 2 - treble
if value == 0
    g1 = 1; % 0 - 60
    g2 = 0.76; % 60 - 680
    g3 = 0.55; % 680 - 3320
    g4 = 0.42; % 3320 - 12680
    g5 = 1; % 12680+
elseif value ==1
    g1 = 10; % 0 - 60
    g2 = 10; % 60 - 680
    g3 = 0.55; % 680 - 3320
    g4 = 0.42; % 3320 - 12680
    g5 = 1; % 12680+
elseif value ==2
    g1 = 1; % 0 - 60
    g2 = 0.76; % 60 - 680
    g3 = 0.55; % 680 - 3320
    g4 = 10; % 3320 - 12680
    g5 = 10; % 12680+
    
end
end