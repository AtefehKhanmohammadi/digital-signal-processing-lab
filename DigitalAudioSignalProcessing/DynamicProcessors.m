%% *Dynamic Processors*
%% Clear the workspace and the command window
close all;
clear;
clc;

%% Dynamic Interval of The Signal
% It is the ratio of the maximum amplitude of the signal to the maximum
% amplitude of the signal. It is a dimensionless quantity. It also can be
% shown in dB.
%%
%% Diagram of Dynamic Processor
% * It consists of a level detector and gain processor.
% * The level detector measures the level of the input signal and the gain
% processor adjusts the gain of the signal according to the level detector.
% * The gain processor can be a compressor or an expander.
% * The compressor reduces the gain of the signal and the expander increases
% the gain of the signal.
% * The compressor is used to reduce the dynamic range of the signal and the
% expander is used to increase the dynamic range of the signal.
imshow('./images/DynamicProcessor.png');
%% Level Detector
% The level detector measures the level of the input signal.
% The level detector have 3 different types:
% # Peak detector
% # Envelope detector
% # RMS detector
%
% The related equations are as below:
%
% $$Peak Detector: y(n) = |x(n)|$$
%
% $$Envelope Detector: y(n) = \lambda y(n-1) + (1-\lambda)|x(n)|$$
%
% $$RMS Detector: y(n) = \lambda y(n-1) + (1-\lambda)|x(n)|^2$$
%

%% Dynamic Processors
% Dynamic processors have 4 different types:
% # Compressor
% # Limiter
% # Expander
% # Noise Gate
%
% They are all used to control the dynamic range of the signal.
% Compressor and Limitter are used to reduce the dynamic range of the signal
% and Expander and Noise Gate are used to increase the dynamic range of the
% signal.
% All of them have three main parameters:
% # Attack Time Constant
% # Threshold
% # Ratio
%
% *Attack Time Constant*
%
% It is the time that the gain processor takes to change the gain of the
% signal. It is a value between 0 and 1. If it is 0, the gain processor
% changes the gain of the signal immediately. If it is 1, the gain
% processor does not change the gain of the signal.
%
% *Threshold*
%
% It is the level that the gain processor starts to change the gain of the
% signal. It can be expressed in $W$ or $dB$.
%
% *Ratio*
%
% It is the ratio of the change in the input level to the change in the
% output level. It is a dimensionless quantity. For compresssor if the
% value of the ratio is 1, the gain processor does not change the gain of
% the signal. If the value of the ratio is 0, the gain processor does not
% let the signal pass. For expander if the value of the ratio is 1, the
% gain processor does not change the gain of the signal. If the value of
% is infinity, the gain processor does not let the signal pass.

%% Compressors and Limiters
% Compressor is used to reduce the dynamic range of the signal.
% It won't let the signal pass if the level of the signal is higher than
% the threshold. If the level of the signal is higher than the threshold,
% it will reduce the gain of the signal according to the ratio.
%
% The related equations are as below:
%
% $$ G(n) = \begin{cases} (\frac{c_n}{c_0})^{\rho-1} & \text{if } c_n > c_0 \\
% 1 & \text{if } c_n \leq c_0 \end{cases} $$
%
% which $c_n$ is the level of the signal and $c_0$ is the threshold. $\rho$
% is the ratio. $G(n)$ is the gain processor which is multiplied by the
% input signal.
%
% If the ratio is 1, the gain processor does not change the gain of the
% signal. If the ratio is 0, the gain processor does not let the signal
% pass.
%
% If $\rho$ is very close to zero the gain processor is called limiter.
% Limiter is used to limit the level of the signal.
%
% The difference between compressor and limiter is shown in the following
% figure:
imshow('./images/CompressorLimiter.webp');
%% Expanders and Noise Gates
% Expander is used to increase the dynamic range of the signal.
% It won't let the signal pass if the level of the signal is lower than
% the threshold. If the level of the signal is lower than the threshold,
% it will decrease the gain of the signal according to the ratio.
%
% The related equations are as below:
%
% $$ G(n) = \begin{cases} (\frac{c_0}{c_n})^{\rho-1} & \text{if } c_n < c_0 \\
% 1 & \text{if } c_n \geq c_0 \end{cases} $$
%
% which $c_n$ is the level of the signal and $c_0$ is the threshold. $\rho$
% is the ratio. $G(n)$ is the gain processor which is multiplied by the
% input signal.
%
% If the ratio is 1, the gain processor does not change the gain of the
% signal. If the ratio is infinity, the gain processor does not let the
% signal pass.
%
% If $\rho$ is very close to zero the gain processor is called noise gate.
% Noise gate is used to remove the noise of the signal.
%
% The difference between expander and noise gate is shown in the following
% figure:
imshow('./images/ExpanderAndNoiseGate.jpeg');
%% movmean
%% expander compressor limitter and ...
