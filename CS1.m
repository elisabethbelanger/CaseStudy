%% ESE 351: Case Study 1
% * Names:                  Morgan Davies, Ouyang Du, & Elisabeth Belanger
% * Date:                   Created 2/27/2022

%% (1) Audio presets

% use the function 'presets' to get the preset gain values
% input -> 0 - unity, 1 - bass, 2 - treble
% output -> [g1, g2, g3, g4, g5]
%
% g1: 0 - 60
% g2: 60 - 680
% g3: 680 - 3320
% g4: 3320 - 12680
% g5: 12680+

%% (2A) Giant Steps 

[xv,xvfs] = audioread('Giant Steps Bass Cut.wav'); 

% Bass Boost:
[g1, g2, g3, g4, g5] = presets(1);
giant_bass = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
% soundsc(giant_bass, xvfs)
% pause((length(xv)-1)*(1/xvfs)+2)
% soundsc(xv(:,1), xvfs)

% Treble Boost:
[g1, g2, g3, g4, g5] = presets(2);
giant_treble = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);

soundsc(giant_treble, xvfs)
pause((length(xv)-1)*(1/xvfs)+2)
soundsc(xv(:,1), xvfs)

% Unity
[g1, g2, g3, g4, g5] = presets(0);
giant_unity = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
%soundsc(giant_unity, xvfs)

t = (0:length(xv)-1)*(1/xvfs);
figure()
plot(t, xv(:, 1));
title('Giant - Original');

figure()
plot(t, giant_bass);
title('Giant - Bass Boost');

figure()
plot(t, giant_treble);
title('Giant - Treble Boost');

figure()
plot(t, giant_unity);
title('Giant - Unity');


%% (2B) Space Station 

[xv,xvfs] = audioread('Space Station - Treble Cut.wav'); 

% Bass Boost:
[g1, g2, g3, g4, g5] = presets(1);
% space_bass = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
% soundsc(space_bass, xvfs)
% pause((length(xv)-1)*(1/xvfs)+2)
% soundsc(xv(:,1), xvfs)

% Treble Boost:
[g1, g2, g3, g4, g5] = presets(2);
% space_treble = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
% soundsc(space_treble, xvfs)
% pause((length(xv)-1)*(1/xvfs)+2)
% soundsc(xv(:,1), xvfs)

% Unity
[g1, g2, g3, g4, g5] = presets(0);
space_unity = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
%soundsc(space_unity, xvfs)
%pause((length(xv)-1)*(1/xvfs)+2)
%soundsc(xv(:,1), xvfs)

t = (0:length(xv)-1)*(1/xvfs);

figure()
plot(t, xv(:, 1)), ylim([-2, 2]);
title('Space - Original');

figure()
plot(t, space_bass);
title('Space - Bass Boost');

figure()
plot(t, space_treble);
title('Space - Treble Boost');

figure()
plot(t, space_unity);
title('Space - Unity');
%% (3) Blue in Green

[xv,xvfs] = audioread('Blue in Green with Siren.wav'); 
blue_green_filtered = equilizer(xv(:, 1), xvfs, 1, 0, 0, 0, 0);

t = (0:length(xv)-1)*(1/xvfs);

figure()
plot(t, xv(:, 1));
title('Blue in Green - Original');

figure()
plot(t, blue_green_filtered);
title('Blue in Green - Filtered');

figure, spectrogram(blue_green_filtered,1024,200,1024,xvfs), title('filtered')
figure, spectrogram(xv(:,1),1024,200,1024,xvfs), title('original')

soundsc(blue_green_filtered, xvfs)
pause((length(xv)-1)*(1/xvfs)+2)
soundsc(xv, xvfs)

%% (4) Enhance a signal

[xv,xvfs1] = audioread('birds_trobaugh.wav');
song_ts = equilizer(xv, xvfs1, 0, 0, 5, 100, 0);

t = (0:length(xv)-1)*(1/xvfs1);

figure()
plot(t, xv(:, 1));
title('Birds & Dr. Trobaugh - Original');

figure()
plot(t, song_ts);
title('Birds - Filtered');

figure, spectrogram(song_ts,1024,200,1024,xvfs1), title('filtered')
figure, spectrogram(xv(:,1),1024,200,1024,xvfs1), title('original')

soundsc(song_ts, xvfs1)
pause((length(xv)-1)*(1/xvfs1)+2)
%soundsc(xv, xvfs1)


%% Part 2: (2A) Frequency responses
% Low-pass TF
% lp_tf = tf([1],[1 1/tao]);

% High-pass TF
% hp_tf = tf([1 0],[1 1/tao])

% High pass

fc4_h=12680;
tao4_h = 1/(2*pi*fc4_h);
figure(), freqs([1 0],[1 1/tao4_h]), title('High Pass - f =',fc4_h*2*pi);
[H_HP, W] = freqs([1 0],[1 1/tao4_h]);

%------------------------------------------------------------------------

% Low pass
fc1 = 120;
tao1 = 1/(2*pi*fc1);

figure(), freqs([1],[1 1/tao1], W), title('Low Pass - f =', fc1*pi*2);
[H_LP, W] = freqs([1],[1 1/tao1], W);

%-----------------------------------------------------------------------
%%% bandpass-1 60-680hz
fc1_1=60*2;
fc1_2 = 680*2;
tao1_1 = 1/(2*pi*fc1_1);
tao1_2 = 1/(2*pi*fc1_2);
% Low pass
figure()
freqs(1,[1 1/tao1_2]), title('Low Pass - f =', fc1_2*pi*2);
[H1_1, W] = freqs(1,[1 1/tao1_2], W);% title('Low Pass - f =', fc2*pi*2);

% High pass
figure()
freqs([1 0],[1 1/tao1_1], W), title('High Pass - f =', fc1_1*pi*2);
[H1_2, W] = freqs([1 0],[1 1/tao1_1], W);% title('High Pass - f =', fc1*pi*2);

% Band pass
H_BP1 = H1_1.*H1_2;

figure()
subplot(2, 1, 1)
set(gca, 'XScale', 'log')
plot(W, abs(H_BP1)), title('BP1 Magnitude'), set(gca, 'XScale', 'log');
subplot(2, 1, 2)
plot(W, 180*angle(H_BP1)/pi), title('BP1 Phase'), set(gca, 'XScale', 'log');
%---------------------------------------------------------------------------
%%% bandpass-2 680-3320hz
fc2_1=680*1.3;
fc2_2 = 3320*1.5;
tao2_1 = 1/(2*pi*fc2_1);
tao2_2 = 1/(2*pi*fc2_2);

% Low pass
figure(), freqs([1],[1 1/tao2_2], W), title('Low Pass - f =', fc2_2*2*pi);
[H2_1, W] = freqs([1],[1 1/tao2_2], W);

% High pass
figure(), freqs([1 0],[1 1/tao2_1], W), title('High Pass - f =', fc2_1*2*pi);
[H2_2, W] = freqs([1 0],[1 1/tao2_1], W);

% Band pass
H_BP2 = H2_1.*H2_2;

figure()
subplot(2, 1, 1)
set(gca, 'XScale', 'log')
plot(W, abs(H_BP2)), title('BP2 Magnitude'), set(gca, 'XScale', 'log');
subplot(2, 1, 2)
plot(W, 180*angle(H_BP2)/pi), title('BP2 Phase'), set(gca, 'XScale', 'log');
%--------------------------------------------------------------------------
%%% bandpass-3 
fc3_1=3320*1.52;
fc3_2 = 12680;
tao3_1 = 1/(2*pi*fc3_1);
tao3_2 = 1/(2*pi*fc3_2);

% Low pass
figure(), freqs([1],[1 1/tao3_2], W), title('Low Pass - f =', fc3_2*2*pi);
[H3_1, W] = freqs([1],[1 1/tao3_2], W);
% High pass
figure(), freqs([1 0],[1 1/tao3_1]), title('High Pass - f =', fc3_1*2*pi);
[H3_2, W] = freqs([1 0],[1 1/tao3_1], W);
% Band pass 
H_BP3 = H3_1.*H3_2;

figure()
subplot(2, 1, 1);

set(gca, 'XScale', 'log')
plot(W, abs(H_BP3)), title('BP3 Magnitude'), set(gca, 'XScale', 'log');
subplot(2, 1, 2)
plot(W, 180*angle(H_BP3)/pi), title('BP3 Phase'), set(gca, 'XScale', 'log');

%% Part 2: (2B) Frequency responses of Equilizer settings

%unity
unity_response =  0.76*H_BP1/max(H_BP1)+ 0.55*H_BP2/max(H_BP2) + 0.42*H_BP3/max(H_BP3) + H_LP/max(H_LP) + H_HP/max(H_HP);
figure()
subplot(2, 1, 1);
hold on
set(gca, 'XScale', 'log')
plot(W, abs(unity_response), 'k'), title('Magnitude'), set(gca, 'XScale', 'log');
plot(W, abs(0.75*H_BP1/max(H_BP1))), set(gca, 'XScale', 'log');
plot(W, abs(0.6*H_BP2/max(H_BP2))),  set(gca, 'XScale', 'log');
plot(W, abs(0.45*H_BP3/max(H_BP3))), set(gca, 'XScale', 'log');
plot(W, abs(H_LP/max(H_LP))), set(gca, 'XScale', 'log');
plot(W, abs(H_HP/max(H_HP))), title('Magnitude'), set(gca, 'XScale', 'log');
legend('Unity Response','BP1', 'BP2', 'BP3', 'LP', 'HP', 'Location', 'SouthWest')
hold off
subplot(2, 1, 2)
plot(W, 180*angle(unity_response)/pi), title('Unity Phase'), set(gca, 'XScale', 'log');


%% Part 2: (2C) Band Filters - Time Domain Response with LSIM

% Low-pass TF
% lp_tf = tf([1],[1 1/tao]);

% High-pass TF
% hp_tf = tf([1 0],[1 1/tao])
impulse = [0, 1, zeros(1, 999)];

% High pass
fc4_h=12680;
tao4_h = 1/(2*pi*fc4_h);
t4 = 0:5*tao4_h/1000:5*tao4_h;

y_HP = lsim([1 0],[1 1/tao4_h], impulse, t4);
figure(), plot(t4, y_HP), title('High Pass Impulse Response - fc = 12680 Hz');
%
%------------------------------------------------------------------------

% Low pass
fc1 = 120;
tao1 = 1/(2*pi*fc1);

t_lp = 0:5*tao1/1000:5*tao1;
y_lp = lsim([1],[1 1/tao1], impulse, t_lp);
figure(), plot(t_lp, y_lp), title('Low Pass Impulse Response - fc = 120 Hz');


%-----------------------------------------------------------------------
%%% bandpass-1 60-680hz
fc1_1=60*2;
fc1_2 = 680*2;
tao1_1 = 1/(2*pi*fc1_1);
tao1_2 = 1/(2*pi*fc1_2);
% Low pass
t_bp1= 0:5*(tao1_2+tao1_1)/1000:5*(tao1_2+tao1_1);
y_bp1_2 = lsim([1],[1 1/tao1_2], impulse, t_bp1);

% High pass
y_bp1_1 = lsim([1 0],[1 1/tao1_1],y_bp1_2 , t_bp1);
figure(), plot(t_bp1, y_bp1_1), title('BP1');
%%
%---------------------------------------------------------------------------
%%% bandpass-2 680-3320hz
fc2_1=680*1.3;
fc2_2 = 3320*1.5;
tao2_1 = 1/(2*pi*fc2_1);
tao2_2 = 1/(2*pi*fc2_2);

% Low pass
t_bp2= 0:5*(tao2_2+tao2_1)/1000:5*(tao2_2+tao2_1);
y_bp2_2 = lsim([1],[1 1/tao2_2], impulse, t_bp2);

% High pass
y_bp2_1 = lsim([1 0],[1 1/tao2_1], y_bp2_2, t_bp2);
figure(), plot(t_bp2, y_bp2_1), title('BP2');


%--------------------------------------------------------------------------
%%% bandpass-3 
fc3_1=3320*1.52;
fc3_2 = 12680;
tao3_1 = 1/(2*pi*fc3_1);
tao3_2 = 1/(2*pi*fc3_2);

% Low pass
t_bp3= 0:5*(tao3_2+tao3_1)/1000:5*(tao3_2+tao3_1);
y_bp3_2 = lsim([1],[1 1/tao3_2], impulse, t_bp3);

% High pass
y_bp3_1 = lsim([1 0],[1 1/tao3_1], y_bp3_2, t_bp3);
figure(), plot(t_bp3, y_bp3_1), title('BP3');

%--------------------------------------------------------------------------
%% Part 2: (2D) Equilizer Bands - Time Domain Response with LSIM

% Low pass
fc1 = 120;
tao1 = 1/(2*pi*fc1);

t_lp = 0:0.01*tao1/1000:0.01*tao1;
y_lp = lsim([1],[1 1/tao1], impulse, t_lp);

%---------------------------------------------------------------------------------
% High pass
fc4_h=12680;
tao4_h = 1/(2*pi*fc4_h);

y_HP = lsim([1 0],[1 1/tao4_h], impulse, t_lp);
%-----------------------------------------------------------------------
%%% bandpass-1 60-680hz
fc1_1=60*2;
fc1_2 = 680*2;
tao1_1 = 1/(2*pi*fc1_1);
tao1_2 = 1/(2*pi*fc1_2);
% Low pass

y_bp1_2 = lsim([1],[1 1/tao1_2], impulse, t_lp);

% High pass
y_bp1_1 = lsim([1 0],[1 1/tao1_1],y_bp1_2 , t_lp);

%
%---------------------------------------------------------------------------
%%% bandpass-2 680-3320hz
fc2_1=680*1.3;
fc2_2 = 3320*1.5;
tao2_1 = 1/(2*pi*fc2_1);
tao2_2 = 1/(2*pi*fc2_2);

% Low pass

y_bp2_2 = lsim([1],[1 1/tao2_2], impulse, t_lp);

% High pass
y_bp2_1 = lsim([1 0],[1 1/tao1], y_bp2_2, t_lp);



%--------------------------------------------------------------------------
%%% bandpass-3 
fc3_1=3320*1.52;
fc3_2 = 12680;
tao3_1 = 1/(2*pi*fc3_1);
tao3_2 = 1/(2*pi*fc3_2);

% Low pass

y_bp3_2 = lsim([1],[1 1/tao3_2], impulse, t_lp);

% High pass
y_bp3_1 = lsim([1 0],[1 1/tao3_1], y_bp3_2, t_lp);


% Unity:
y_Unity = 0.76*y_bp1_1+ 0.55*y_bp2_1 + 0.42*y_bp3_1 + 1*y_HP + 1*y_lp;
figure(), plot(t_lp, y_Unity), title('Unity');
% Treble Boost:
y_Treble = 0.76*y_bp1_1+ 0.55*y_bp2_1 + 10*y_bp3_1 + 10*y_HP + y_lp;
figure(), plot(t_lp, y_Treble), title('Treble');
% Bass Boost:
y_Bass = 10*y_bp1_1+ 0.55*y_bp2_1 + 0.42*y_bp3_1 + y_HP + 10*y_lp;
figure(), plot(t_lp, y_Bass), title('Bass');





