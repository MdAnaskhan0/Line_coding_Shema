bits = input('prompt');
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));
lastbit = 1;
% Create a UI figure
figure('Name', 'Encoding Schemes', 'Color', 'white', 'Position', [200 100 900 500]);
dlg_title= ' Welcome ';
prompt = ' Select Encoding Scheme: ';
encoding_options = {'Unipolar', 'Polar (NRZ-L, NRZ-L, RZ, Manchester, Differential Manchester)', 'Bipolar (AMI, Pseudoternary)', 'Multilevel'};
[encodingSchemeIndex,~] = listdlg('PromptString',prompt,'SelectionMode','single','ListString',encoding_options,'Name',dlg_title);
switch encodingSchemeIndex
case 1
% Unipolar
for i = 1:length(bits)
if bits(i) == 0
x((i-1)*n+1:i*n) = 0;
else
x((i-1)*n+1:i*n) = lastbit;
%lastbit = lastbit; % Transition the voltage for bit value 1
end
end
% Create axes for the plot
subplot(1, 1, 1);
plot(t, x, 'LineWidth', 3, 'Color', 'blue');
axis([0 T -1.5 1.5]);
title('Unipolar ');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = 1;
result = zeros(1, length(bits));
% Unipolar - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == 0
result(counter) = 0;
else
result(counter) = 1;
end
end
end
disp('Decode Result - Unipolar :');
disp(result);
case 2
% Polar (NRZ-L)
x = zeros(1,length(t));
lastbit = 1;
for i=1:length(bits)
if bits(i)==0
x((i-1)*n+1:i*n) = lastbit;
else
x((i-1)*n+1:i*n) = -lastbit;
%lastbit = lastbit; % Toggle the lastbit value for next bit
end
end
% Create axes for the plot
subplot(3, 2, 1);
plot(t, x, 'LineWidth', 3, 'Color', 'red');
axis([0 T -1.5 1.5]);
title('Polar (NRZ-L)');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = -1; % Start with negative voltage for the first bit
result = zeros(1, length(bits));
% Polar (NRZ-L) - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == lastbit
result(counter) = 1;
else
result(counter) = 0;
end
end
end
disp('Decode Result - Polar (NRZ-L):');
disp(result);
%Polar(NRZ-I)
x = zeros(1,length(t));
lastbit = 1;
for i=1:length(bits)
if bits(i)==0
x((i-1)*n+1:i*n) = lastbit ;
else
x((i-1)*n+1:i*n) = -lastbit ;
end
lastbit = x((i-1)*n+1);
end
subplot(3, 2, 2);
plot(t, x, 'Linewidth', 3);
axis([0 T -1.5 1.5]);
title('Polar (NRZ-I)');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = 1;
result = zeros(1, length(bits));
% Polar (NRZ-I) - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == lastbit;
result(counter) = 0;
else
result(counter) = 1;
end
lastbit = x(i);
end
end
disp('Decode Result - Polar (NRZ-I):');
disp(result);
% Polar (RZ)
x = zeros(1, length(t));
lastbit = 1;
for i = 1:length(bits)
if bits(i) == 0
x((i-1)*n+1:i*n-(n/2)) = -lastbit;
x(i*n-(n/2)+1:i*n) = 0;
else
x((i-1)*n+1:i*n-(n/2)) = 1;
x(i*n-(n/2)+1:i*n) = 0;
end
end
% Create axes for the plot
subplot(3, 2, 3);
plot(t, x, 'LineWidth', 3, 'Color', 'green');
axis([0 T -1.5 1.5]);
title('Polar (RZ)');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = -1; % Start with negative voltage for the first bit
result = zeros(1, length(bits));
% Polar (RZ) - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == lastbit
result(counter) = 0;
else
result(counter) = 1;
end
end
end
disp('Decode Result - Polar (RZ):');
disp(result);
% Polar (Manchester)
x = zeros(1, length(t));
lastbit = 1;
for i = 1:length(bits)
if bits(i) == 0
x((i-1)*n+1:i*n-(n/2)) = 1;
x(i*n-(n/2)+1:i*n) = -1;
else
x((i-1)*n+1:i*n-(n/2)) = -1;
x(i*n-(n/2)+1:i*n) = 1;
end
lastbit = -lastbit;
end
% Create axes for the plot
subplot(3, 2, 4);
plot(t, x, 'LineWidth', 3, 'Color', 'magenta');
axis([0 T -1.5 1.5]);
title('Polar (Manchester)');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = 1;
result = zeros(1, length(bits));
% Polar (Manchester) - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == lastbit
result(counter) = 0;
else
result(counter) = 1;
end
end
end
disp('Decode Result - Polar (Manchester):');
disp(result);
% Differential Manchester
x = zeros(1,length(t));
lastbit = 1;
for i=1:length(bits)
if bits(i)==0
x((i-1)*n+1:i*n-(n/2)) = -1;
x(i*n-(n/2)+1:i*n) = 1;
else
x((i-1)*n+1:i*n-(n/2)) = 1;
x(i*n-(n/2)+1:i*n) = -1;
end
lastbit = -lastbit;
end
% Create axes for the plot
subplot(3, 2, 5);
plot(t, x, 'LineWidth', 3, 'Color', 'blue');
axis([0 T -1.5 1.5]);
title('Differential Manchester');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = 1;
result = zeros(1, length(bits));
% Differential Manchester - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == lastbit
result(counter) = 1;
else
result(counter) = 0;
end
end
end
disp('Decode Result - Differential Manchester:');
disp(result);
case 3
% Bipolar (AMI)
x = zeros(1,length(t));
lastbit = 1;
voltage = 1;
for i=1:length(bits)
if bits(i)==0
x((i-1)*n+1:i*n) = 0;
else
x((i-1)*n+1:i*n) = lastbit * voltage;
lastbit = -lastbit;
end
end
% Create axes for the plot
subplot(2, 1, 1);
plot(t, x, 'LineWidth', 3, 'Color', 'cyan');
axis([0 T -1.5 1.5]);
title('Bipolar (AMI)');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = 1;
result = zeros(1, length(bits));
% Bipolar (AMI) - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == 0
result(counter) = 0;
else
result(counter) = 1;
end
end
end
disp('Decode Result - Bipolar (AMI):');
disp(result);
% Bipolar (Pseudoternary)
x = zeros(1,length(t));
lastbit = -1;
voltage = 1;
for i=1:length(bits)
if bits(i)==1
x((i-1)*n+1:i*n) = 0; % Zero voltage for bit 1
else
x((i-1)*n+1:i*n) = lastbit * voltage; % Alternating voltage for bit 0
lastbit = -lastbit;
end
end
% Create axes for the plot
subplot(2, 1, 2);
plot(t, x, 'LineWidth', 3, 'Color', 'blue');
axis([0 T -1.5 1.5]);
title('Bipolar (Pseudoternary)');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = 1;
result = zeros(1, length(bits));
% Bipolar (Pseudoternary) - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == 0
result(counter) = 1;
else
result(counter) = 0;
end
end
end
disp('Decode Result - Bipolar (Pseudoternary):');
disp(result);
case 4
% Define the multilevel signaling levels
levels = [-2 -1 0 1 2];
x = zeros(1,length(t));
lastbit = levels(1); % Initialize the lastbit with the first level
for i = 1:length(bits)
if bits(i) == 0
x((i-1)*n+1:i*n) = lastbit;
else
% Cycle through the levels
lastbit = levels(mod(i-1, length(levels)) + 1);
x((i-1)*n+1:i*n) = lastbit;
end
end
subplot(2, 1, 1);
plot(t, x, 'Linewidth', 3, 'Color', 'red');
axis([0 T -2.5 2.5]);
title('Multilevel Line Coding');
xlabel('Time');
ylabel('Amplitude');
counter = 0;
lastbit = levels(1); % Reset the lastbit to the first level
result = zeros(1, length(bits));
% Multilevel Line Coding - Decode
for i = 1:length(t)
if t(i) > counter
counter = counter + 1;
if x(i) == lastbit
result(counter) = 0;
else
result(counter) = 1;
end
lastbit = x(i);
end
end
disp('Decode Result - Multilevel Line Coding:');
disp(result);
end
