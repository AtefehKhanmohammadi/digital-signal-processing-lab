%% *Digital Filters*
%% Clear the workspace
close all;
clear;
clc;
%% Why do we need filters?
% STFT is a powerful tool for analyzing non-stationary signals. However, it
% is not always the best tool for the job. STFT has two main drawbacks:
% # The choice of the window length is not obvious. If the window is too
% short, the resolution in the frequency domain is poor(It won't detect any
% special pattern). If the window is too long, the resolution in the time
% domain is poor(It won't distinguish between different events in time).
% # The STFT has the term complex exponential in it. This terms is a priodic
% function and time unlimited. However, in real life signals, we are interested
% in the signal only for a finite time interval. This property of STFT causes
% the spectrum of time limited signals to be unbounded in a wide range of
% frequencies.
%
% This two drawbacks leads to the need of a new tool for analyzing
% non-stationary signals. We should use different window lengths for
% different parts of the signal. We should also use a time limited basis
% function instead of the complex exponential. This is where the wavelet
% transform comes in.
%
%% Replacement of frequency domain
% According to the second drawback of STFT, we need to use a time limited
% basis function instead of the complex exponential. This means that the new
% basis function is not periodic which means that we can't use the
% frequency domain to analyze the signal(Because the frequency domain is
% based on the complex exponential and periodicity).
% We should analyze what interesting features are captured by the complex
% exponential. The complex exponential is a basis function for the
% frequency domain. If thee signal is periodic with the frequency of
% $f_0$, then the complex exponential will have a peak at $f_0$. the second
% harmonic will have a peak at $2f_0$ and so on. The relations between
% different harmonics is the concept that we should capture in the new
% basis function.
%
% Warping the time axis is the key to capture the relations between
% different harmonics. The new basis function should be a time limited
% function that is warped in time. For example if we replace $t$ with
% $2t$ in the original signal $x(t)$, then the second harmoinc will be
% captured in the new signal.
%
% We claim that the main characteristic of harmonic frequencies can be drawn
% from a more general concept that we call "scale". The interesting part is that
% unlike frequency that is defined only for periodic signals, scale is equally
% applicable to nonperiodic signals. This proves that we have found a new
% concept, i.e., scale, to replace frequency.
% Using scale as a variable, the new transform, which will be based on
% time-limited basis function, can be meaningfully applied to both
% time-unlimited and time-limited signals.
%
%% One-dimensional Continuous Wavelet Transform
% The one-dimensional continuous wavelet transform (CWT) of a signal $x(t)$
% is defined as:
%
% $$W_{\Psi, X}(a,b)=\frac{1}{\sqrt{|a|}}\int_{-\infty}^{\infty}x(t)\Psi^*\left(\frac{t-b}{a}\right)dt,a\neq0$$
%
% where $a$ is the scale parameter, $b$ is the translation parameter, and
% $\Psi^*(t)$ is the complex conjugate of the mother wavelet $\Psi(t)$.
%
% A closer look at the definition of the mother wavelet tells that this function
% must be limited in duration and therefore looks like a decaying small wave.
% This is why we call this transform the wavelet transform.
%
% The synthesis equation is:
%
% $$x(t)=\frac{C^{-1}_{\Psi}}{a^2}\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}W_{\Psi, X}(a,b)\Psi\left(\frac{t-b}{a}\right)dadb$$
%
% where $C^{-1}_{\Psi}$ is a constant whose value depends on the exact choice
% of the mother wavelet $\Psi(t)$.
%
% Every choice of the mother wavelet gives a particular CWT, and as a result, we
% are dealing with infinite number of transformations under the same name CWT.
%
%% Mother wavelets
% the mexican hat wavelet is a good choice for the mother wavelet. It is
% defined as:
%
% $$\Psi(t)=\frac{2}{\sqrt{3a}\pi^{1/4}}\left(1-\frac{t^2}{a^2}\right)e^{-t^2/2a^2}$$
%
% The mexican hat wavelet is also known as the Ricker wavelet.
%
% The waveform of the mexican hat wavelet is shown below:
t = -2:0.01:2;
a = 0.5;
Psi = (2 / (sqrt(3 * a) * pi ^ (1/4))) * (1 - (t .^ 2 / a ^ 2)) ...
    .* exp(-t .^ 2 / (2 * a ^ 2));
figure('Name', 'Mexican Hat Wavelet');
plot(t, Psi, 'LineWidth', 1.5);
title('Mexican Hat Wavelet');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% There are many other mother wavelets. The most important ones are:
% # Morlet wavelet
% # Haar wavelet
% # Daubechies wavelet
% # Symlet wavelet
% # Coiflet wavelet
% # Meyer wavelet
% # Gaussian wavelet
% # Mexican hat wavelet
% # Shannon wavelet
%
% Daubechies wavelets are the most popular wavelets. They are orthogonal
% wavelets. Orthogonal wavelets are used in image compression.
% They are indicated by dbX, where X is the number of vanishing moments.
% The number of vanishing moments is the number of derivatives of the
% wavelet function that are zero at the origin.
% The more complex the signal, the more vanishing moments are needed to
% capture its features.
%
% To choose the best wavelet for a specific application, we should consider
% the following factors:
% # complex mother wavelets are needed for complex signals
% # the mother wavelet that resembles the general shape of the signal to be
% analyzed would be a more suitable choice.
%
%% One-dimensional Discrete Wavelet Transform
% A closer look at the CWT revealsthat thistransformation requiresthe
% calculations based on all continuous shifts and all continuous scales.
% This obviously makes the computational complexity of the CWT and the ICWT
% unsuitable for many practically important applications.
% This leads us to the discrete version of this transform.
% We define sampled versions of the scale and translation parameters as:
%
% $$a_{jk}=a_0^j,k=0,1,...,M-1,j=0,1,...,N-1$$
%
% $$b_jk=ka_0^jT,k=0,1,...,M-1,j=0,1,...,N-1$$
%
% where $T$ is the sampling time and $a_0$ is a positive nonzero constant.
%
% Also we define mother wavelet as:
%
% $$\Psi_{jk}(t)=\frac{1}{\sqrt{a_{jk}}}\Psi\left(\frac{t-b_{jk}}{a_{jk}}\right)=a_0^{-j/2}\Psi(a_0^{-j}t-kT)$$
%
% Then the coefficients of the discrete wavelet transform (DWT) are defined as:
%
% $$W_{\Psi, X}(j,k)=\int_{-\infty}^{\infty}x(t)\Psi_{jk}^*\left(t\right)dt$$
%
% This makes the DWT somewhat different from the DFT that accepts only discrete
% signals as its input. The synthesis equation is:
%
% $$x(t)=c\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}W_{\Psi, X}(j,k)\Psi_{jk}(t)$$
%
% where $c$ is a constant that depends on the exact choice of the mother wavelet.
%
% The interesting thing about this equation is the fact that we can reconstruct
% the continuous signal directly from a set of discrete coefficients.
%
%% Minimal set of basis functions
% A relevant question at this point is how to choose the number of basis
% functions for a given signal.
% A frame is a set of basis functions that can be used to decompose a signal.
% This set can be minimal or nonminimal, i.e., if the number of basis functions
% in the frame is minimal and any other frame would need the same
% number or more basis functions, the frame is called a basis.
%
% Consider the energy of the signal $x(t)$:
%
% $$E_x=\int_{-\infty}^{\infty}|x(t)|^2dt$$
%
% It can be proved that there exist some bounded positive values A and B such that:
%
% $$A\int_{-\infty}^{\infty}|x(t)|^2dt\leq\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}|W_{\Psi, X}(j,k)|^2\leq B\int_{-\infty}^{\infty}|x(t)|^2dt$$
%
% This relation intuitively means that the energy of the wavelet coefficients for a frame
% is bounded on both upper and lower sides by the true energy of the signal.
% In the case of a basis (i.e., a minimal frame), the values A and B in the
% aforementioned inequality become the same, i.e., $A = B$.
% This means that for a basis we have
%
% $$\sum_{j=0}^{N-1}\sum_{k=0}^{M-1}|W_{\Psi, X}(j,k)|^2=E_x$$
% This indicates the energy of the coefficients is exactly the same as the energy of the
% signal.
% This is a very important property of the wavelet transform.
% The next important question to ask here is: "What are the properties of the
% functions that allow the function sets to form a basis?" The most popular
% basis sets are the orthogonal ones, i.e., the function
% sets whose members are orthogonal to each other.
%
%% Discrete Wavelet Transform on Discrete Signals
% We need to focus on calculating DWT from discrete signals. At this point,
% we assume that the discrete signal, if sampled from a continuous
% signal, has been sampled according to the Nyquist rate (or faster).
% This guarantees that all information of the continuous signal is preserved in
% the discrete signal.
%
% The question here is how to form such basis sets systematically. The method
% described next, called Mallat pyramidal algorithm or quadrature mirror filter (QMF),
% allows systematic creation of an unlimited number of orthogonal basis sets for DWT.
%
% The interesting feature of this method is the fact that the method relies
% only on the choice of a digital low-pass filter $h(n)$, and once this filter
% is chosen, the entire algorithm is rather mechanical and straightforward.
%
% Assuming a digital filter $h(n)$, we form another filter $g(n)$ as follows:
%
% $$g(n)=h(2N-1-n),n=0,1,...,2N-1$$
% It can be proved that once $h(n)$ is a low-pass filter, $g(n)$ is a high-pass filter.
%
% The schematic diagram of the Mallat pyramidal algorithm is shown below:
figure('Name', 'Mallat Pyramidal Algorithm');
imshow('./images/DWT_QMF_Algorithm.png');
%%%
% The first step in transformation is filtering the signal once with the
% low-pass filter $h(n)$ and once with the high-pass filter $g(n)$.
% Then the filtered versions of the signal are downsampled by a factor of 2.
% This means that every other samples of the signal are preserved and the
% remaining samples are discarded.
%
% We can also ask another relevant question about downsampling: "How would
% downsampling fit into the general ideas of the DWT?"
% Without getting into the mathematical details of the process, one can see
% that downsampling somehow creates the description of the signal at a
% different scale and resolution.
% Now we should consider the mother wavelet of QMF algorithm.
% The mother wavelet of the QMF algorithm is defined as:
%
% $$\Psi(n)=\sum_{k=0}^{2N-1}g(k)\Phi(2n-k)$$
%
% where
%
% $$\Phi(n)=\sum_{k=0}^{2N-1}h(k)\Phi(2n-k)$$
%
% The function $\Phi(n)$ is called the scaling function.
% The scaling function is a low-pass filter that is used to reconstruct the
% signal from the wavelet coefficients.
% The scaling function is also called the *father wavelet*.
%
% It can be shown that all popular wavelets are derived from the QMF algorithm.
%
% Now we should ask another question: "How many decomposition levels are needed
% for a suitable transform?" An intuitive criterion to choose the level of the
% decomposition would be continuing decomposition until the highest known
% frequencies in the signal of interest are extracted and identified.
%
% Now we define inverse DWT algorithm. The inverse DWT algorithm is shown below:
figure('Name', 'Inverse DWT Algorithm');
imshow('./images/IDWT_QMF_Algorithm.png');
%%%
% The inverse DWT algorithm is the reverse of the forward DWT algorithm.
%
% The filters $h(n)$ and $g(n)$ are called the analysis filters.
% The filters $h_1(n)$ and $g_1(n)$ are called the synthesis filters.
% $h_1(n)$ and $g_1(n)$ can be derived from $h(n)$ and $g(n)$:
%
% $$h_1(n)=(-1)^(1-n)h(1-n)&&
%
% and
%
% $$g_1(n)=h(2N-1-n)$$
%
% An interesting feature of the DWT and IDWT is the possibility of
% reconstructing the signal only based on a few of the levels (scales)
% of decomposition.
% For example, if we want to extract only the main trend
% of the signal and ignore the medium and fast variations, we can easily
% decompose the signal to several levels using DWT, but use only the first
% (or first few) low-pass components to reconstruct the signal using IDWT.
% This allows bypassing the medium- and high-frequency components.
% Similarly, if the objective is to extract only the fast variations of signal,
% in the reconstruction phase, we can easily set the coefficients of the low
% frequency (high scales) to zero while calculating the IDWT.
%
%% |wnoise| function
% The |wnoise| function is used to add white noise to a signal.
% The syntax of this function is:
%
% $$[x, noisy_x]=wnoise(fun, n, sqrtsnr, seed)$$
%
% * |x|: The original signal
% * |noisy_x|: The noisy signal
% * |fun|: The function that generates the signal
% * |n|: The nummber of iterations(power of 2 $log_2(numberOfSamples)$)
% * |sqrtsnr|: The square root of the signal to noise ratio
% * |seed|: The seed of the random number generator
%
N = 8;
loc = linspace(0, 1, 2 ^ N);
sqrtsnr = 10;
[x, noisy_x] = wnoise('heavy sine', N, sqrtsnr);
figure('Name', 'Heavy Sine Signal vs Heavy Sine Signal with White Noise');
subplot(211);
plot(loc, x, 'LineWidth', 1.5);
title('Heavy Sine Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;
subplot(212);
plot(loc, noisy_x, 'LineWidth', 1.5);
title('Heavy Sine Signal with White Noise');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |wnoise| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wnoise.html |wnoise|>
% documentation.
%
%% |wavedec| function
% The |wavedec| function is used to decompose a signal using DWT.
% It implements Multilevel 1-D wavelet transform.
%
% The syntax of this function is:
%
% $$[waveletCoefficients, waveletLevels] = wavedec(x, numberOfLevels, waveletName)$$
%
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |x|: The original signal
% * |numberOfLevels|: The number of levels of decomposition
% * |waveletName|: The name of the wavelet
%
[waveletCoefficients, waveletLevels] = wavedec(x, 2, 'db2');
figure('Name', 'Wavelet Coefficients');
stem(waveletCoefficients, 'LineWidth', 1.5);
title('Wavelet Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;

%%%
% The |wavedec| function returns the wavelet coefficients of the signal
% decomposed to the specified number of levels using the specified wavelet.
%
% For more information about the |wavedec| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/wavedec.html |wavedec|>
% documentation.
%
%% |detcoef| function
% The |detcoef| function is used to extract the wavelet coefficients of a
% specific level or levels of decomposition.
%
% The syntax of this function is:
%
% $$DetCoef = detcoef(waveletCoefficients, waveletLevels, levels_to_extract)$$
%
% * |DetCoef|: The wavelet coefficients of the specified level or levels
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |levels_to_extract|: The levels to extract
%
DetCoef = detcoef(waveletCoefficients, waveletLevels, [1 2]);
figure('Name', 'Wavelet Coefficients of Level 1 and 2');
subplot(211);
stem(DetCoef{1}, 'LineWidth', 1.5);
title('Wavelet Coefficients of Level 1 and 2');
xlabel('Time');
ylabel('Amplitude');
grid on;
subplot(212);
stem(DetCoef{2}, 'LineWidth', 1.5);
title('Wavelet Coefficients of Level 1 and 2');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |detcoef| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/detcoef.html |detcoef|>
% documentation.
%% |appcoef| function
% The |appcoef| function is used to extract the approximation coefficients
% from the wavelet coefficients.
%
% The syntax of this function is:
%
% $$approx = appcoef(waveletCoefficients, waveletLevels, waveletName)$$
%
% * |approx|: The approximation coefficients
% * |waveletCoefficients|: The wavelet coefficients(1-D vector concatenated from all levels)
% * |waveletLevels|: The number of levels of decomposition
% * |waveletName|: The name of the wavelet
%
approx = appcoef(waveletCoefficients, waveletLevels, 'db2');
figure('Name', 'Approximation Coefficients');
plot(approx, 'LineWidth', 1.5);
title('Approximation Coefficients');
xlabel('Time');
ylabel('Amplitude');
grid on;
%%%
% For more information about the |appcoef| function, refer to the
% <https://www.mathworks.com/help/wavelet/ref/appcoef.html |appcoef|>
% documentation.
%