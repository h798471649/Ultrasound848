%% US Master Code
% Help Information

%% Start
clear; close all; clc;

%% Load Data
cd ./data/
[M, NumbSamples, NumbElements, NumbLines, ...
    ElementSpacing, BeamSpacing, ...
    fs, c, Focus, t0] = loadData();

F_bf = 2.5; % cm
bw = 0.55; 
x = 0.6; % compressive value

ReceiveAperture = F_bf/2;
ReceiveDepth = 3; % cm

%% Other Constants
cd ..

F_bf = 2.5; % cm
bw = 0.55; 
x = 0.6; % compressive value

ReceiveAperture = F_bf/2;
ReceiveDepth = 3; % cm



%% Time and Space Intervals
dt = 1/fs; % s
dx = c*dt; % cm 

%% Other
FocalIndex = Focus./dx; % index

%% Spatial Location
[BeamLocations, ElementLocations, SampleLocations, SampleIndices] = SpatialLocator(BeamSpacing, NumbLines, ElementSpacing, NumbElements, dx, NumbSamples,t0);

%% Final
Delay = zeros(1,20);
disp(size(M(:,:,21)));
Vq = interp2(M(:,:,21),1:192,FocalIndex);

[X,Y] = meshgrid(BeamLocations,ElementLocations); % Can cut down element locations
D = Y-X; % Columns are associated with the beamlocation and the rows are associated with which element

Distance = sqrt(D.^2 + Focus.^2);
DistanceDifference = Distance - 3;
DistanceIndex = DistanceDifference./dx;
TimeDelay = DistanceDifference./c./100;

%% Visualization
figure
hold on
plot(BeamLocations,zeros(1,length(BeamLocations)),'k*')
plot(ElementLocations,1/10*ones(1,length(ElementLocations)),'b*')
plot(zeros(1,length(SampleLocations)),SampleLocations,'r.')
plot([-2 2],[3 3], 'g-')
axis([-2 2 0 8])


