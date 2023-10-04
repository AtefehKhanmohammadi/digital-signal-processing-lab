%% *Basics of Signal Processing - Basic Signals*
%% Clear the workspace
close all;
clear;
clc;

%% Dirac Delta Function
% The continuous-time dirac delta function is defined as follows:
%
% $$\delta(t) = \begin{cases} 0, & t \neq 0 \\ \infty, & t = 0 \end{cases}$$
%
% The discrete-time dirac delta function is defined as follows:
%
% $$\delta[n] = \begin{cases} 0, & n \neq 0 \\ 1, & n = 0 \end{cases}$$
%
% * The dirac delta function is also known as the unit impulse function.
% * It is a function that is zero everywhere except at the origin, where it is
% infinite.
% * The dirac delta function is used to model a unit impulse in
% signal processing.
% * The dirac delta function is also used to model a
% single sample in discrete-time signal processing.
% * The dirac delta function is used to represent the impulse response of
% an LTI system.
% We can define continuous-time dirac delta function as follows:
fs = 1e4;
t = -10:1 / fs:10;
N = length(t);
delta = zeros(N, 1);
delta(t == 0) = fs;
figure('Name', 'Continuous-Time Dirac Delta Function');
plot(t, delta, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-Time Dirac Delta Function');
grid on;

%%%
% We can define discrete-time dirac delta function as follows:
n = -10:10;
N = length(n);
delta = zeros(N, 1);
delta(n == 0) = 1;
figure('Name', 'Discrete-Time Dirac Delta Function');
stem(n, delta, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-Time Dirac Delta Function');
grid on;
