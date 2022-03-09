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
%soundsc(giant_bass, xvfs)

% Treble Boost:
[g1, g2, g3, g4, g5] = presets(2);
giant_treble = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
%soundsc(giant_treble, xvfs)

% Unity
[g1, g2, g3, g4, g5] = presets(0);
giant_unity = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
%soundsc(giant_unity, xvfs)

t = (0:length(xv)-1)*(1/xvfs);

%figure()
%plot(t, xv(:, 1));
%title('Giant - Original');

%figure()
%plot(t, gaint_bass);
%title('Giant - Bass Boost');

%figure()
%plot(t, giant_treble);
%title('Giant - Treble Boost');

%figure()
%plot(t, giant_unity);
%title('Giant - Unity');


%% (2B) Space Station 

[xv,xvfs] = audioread('Space Station - Treble Cut.wav'); 

% Bass Boost:
[g1, g2, g3, g4, g5] = presets(1);
space_bass = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
% soundsc(space_bass, xvfs)
% pause((length(xv)-1)*(1/xvfs)+2)
% soundsc(xv(:,1), xvfs)

% Treble Boost:
[g1, g2, g3, g4, g5] = presets(2);
space_treble = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
soundsc(space_treble, xvfs)
pause((length(xv)-1)*(1/xvfs)+2)
soundsc(xv(:,1), xvfs)

% Unity
[g1, g2, g3, g4, g5] = presets(0);
% space_unity = equilizer(xv(:, 1), xvfs, g1, g2, g3, g4, g5);
% soundsc(space_unity, xvfs)
% pause((length(xv)-1)*(1/xvfs)+2)
% soundsc(xv(:,1), xvfs)

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
blue_green_filtered = equilizer(xv(:, 1), xvfs, 10, 0, 0, 0, 0);

t = (0:length(xv)-1)*(1/xvfs);

% figure()
% plot(t, xv(:, 1));
% title('Blue in Green - Original');
% 
% figure()
% plot(t, blue_green_filtered);
% title('Blue in Green - Original');
% 
% figure, spectrogram(blue_green_filtered,1024,200,1024,xvfs), title('filtered')
% figure, spectrogram(xv(:,1),1024,200,1024,xvfs), title('original')
% 
% soundsc(blue_green_filtered, xvfs)
% pause((length(xv)-1)*(1/xvfs)+2)
% soundsc(xv, xvfs)

%% (4) Enhance a signal

[xv,xvfs] = audioread('')
song_ts = equilizer(xv(:, 1), xvfs, 10, 1, 1, 1, 1);

t = (0:length(xv)-1)*(1/xvfs);

figure()
plot(t, xv(:, 1));
title('HIMYM - Original');

figure()
plot(t, song_ts);
title('HIMYM - Filtered');

figure, spectrogram(song_ts,1024,200,1024,xvfs), title('filtered')
figure, spectrogram(xv(:,1),1024,200,1024,xvfs), title('original')

soundsc(song_ts, xvfs)
pause((length(xv)-1)*(1/xvfs)+2)
soundsc(xv, xvfs)


%% Part 2: (2A) Frequency responses
% Low-pass TF
% lp_tf = tf([1],[1 1/tao]);

% High-pass TF
% hp_tf = tf([1 0],[1 1/tao]);

fc1 = 60;
tao1 = 1/(2*pi*fc1);

% Low pass
figure(), freqs([1],[1 1/tao1]), title('Low Pass - f =', fc1*pi*2);

%-----------------------------------------------------------------------
%%
fc2 = 680;

% Low pass
figure()
freqs(1,[1 1/tao2]), title('Low Pass - f =', fc2*pi*2);
[H1, W1] = freqs(1,[1 1/tao2]);% title('Low Pass - f =', fc2*pi*2);

% High pass
figure()
freqs([1 0],[1 1/tao1], W1), title('High Pass - f =', fc1*pi*2);
[H2, W2] = freqs([1 0],[1 1/tao1], W1);% title('High Pass - f =', fc1*pi*2);

% Band pass
H = H1.*H2;

figure()
subplot(2, 1, 1)
set(gca, 'XScale', 'log')
plot(W2, abs(H)), title('BP1 Magnitude'), set(gca, 'XScale', 'log');
subplot(2, 1, 2)
plot(W2, 180*angle(H)/pi), title('BP1 Phase'), set(gca, 'XScale', 'log');
%---------------------
%%
fc3 = 3320;
tao3 = 1/(2*pi*fc3);

% Low pass
figure(), freqs([1],[1 1/tao3]), title('Low Pass - f =', fc3*2*pi);
[H1, W1] = freqs([1],[1 1/tao3]);

% High pass
figure(), freqs([1 0],[1 1/tao2]), title('High Pass - f =', fc2*2*pi);
[H2, W1] = freqs([1 0],[1 1/tao2], W1);

% Band pass
H = H1.*H2;

figure()
subplot(2, 1, 1)
set(gca, 'XScale', 'log')
plot(W2, abs(H)), title('BP2 Magnitude'), set(gca, 'XScale', 'log');
subplot(2, 1, 2)
plot(W2, 180*angle(H)/pi), title('BP2 Phase'), set(gca, 'XScale', 'log');

%%
%----------------------
fc4 = 12680;
tao4 = 1/(2*pi*fc4);

% Low pass
figure(), freqs([1],[1 1/tao4]), title('Low Pass - f =', fc4*2*pi);
[H1, W1] = freqs([1],[1 1/tao4]);
% High pass
figure(), freqs([1 0],[1 1/tao3]), title('High Pass - f =', fc3*2*pi);
[H2, W1] = freqs([1 0],[1 1/tao3], W1);
% Band pass 
H = H1.*H2;

figure()
subplot(2, 1, 1)
set(gca, 'XScale', 'log')
plot(W2, abs(H)), title('BP2 Magnitude'), set(gca, 'XScale', 'log');
subplot(2, 1, 2)
plot(W2, 180*angle(H)/pi), title('BP2 Phase'), set(gca, 'XScale', 'log');


%------------------

% High pass
x5 = filter([1, -1], [(1+(1/fs)/tao4), -1], xv);
figure(), freqs([1 0],[1 1/tao4]), title('High Pass - f =',fc4*2*pi);


%% LSIM
% t = 0:0.001:15;
% W = 0:(size(t, 2)-1);
% 
% % h = 1/fs;
% % t = 0:h:5;
% % B = 1;
% % A = [1 + L*C/h^2 + R*C/h, -R*C/h -2*L*C/h^2, L*C/h^2];
% %s = jw 
% 
% y=lsim(1/(L*C),[1, R/L, 1/(L*C)], cos(pi*W(i).*t), t);
% figure()
% plot(W, 20*log(abs(y)))


