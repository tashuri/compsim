% This file plots the mass distribution of the structure as a function of its 
% length.
%
% Written by Dr. Turaj Ashuri. CompSim V1.0, 8 June, 2017.
% ========================================================
%
% Plotting the mass distribution of the structure.
figure
plot([BeamLngth*BeamFract],BeamMassDen, '-ro')
xlabel('Beam length')
ylabel('Mass distribution')