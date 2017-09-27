% This is the Run Script of CompSim V1.0. This run script is used to control
% the secuqnce of which the code makes the function calls, and executes the
% program. 
% 
% Details on the mathematical formulation used to compute the structual 
% propoerties can be found in:
% http://www.sciencedirect.com/science/article/pii/S2352711017300109
%
% To cite the numerical model, and the computational code please use:
%
% Ashuri, Turaj, and Jie Zhang. "CompSim: Cross sectional modeling of 
% geometrical complex and inhomogeneous slender structures." 
% SoftwareX 6 (2017): 155-160.
% 
% Written by Dr. Turaj Ashuri. CompSim V1.0, 29 May, 2017.
% ========================================================

% Cleaning the screen
clc;

% Closing the figures
clf;

% Reading input data
ReadInputData

% Computing the structural properties
CalcStrcPrprts 

% Writing output data to a text file
WriteOutputFile


