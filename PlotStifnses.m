% This file plots the flapwise and edgewise cross section of the structure 
% as a function of its length.
%
% Written by Dr. Turaj Ashuri. CompSim V1.0, 7 June, 2017.
% ========================================================
%
% Plotting the flapwise and edgewise stifness distribution of the structure.
figure
subplot(211)
plot([BeamLngth*BeamFract],BeamFlpStff, '-*b')
ylabel('Flapwise sifness distribution')
subplot(212)
plot([BeamLngth*BeamFract],BeamEdgStff, '-+c')
ylabel('Edgewise sifness distribution')
xlabel('Beam length')


   
