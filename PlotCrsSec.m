% This file plots the cross section of the structure as a function of its 
% length.
%
% Written by Dr. Turaj Ashuri. CompSim V1.0, 5 June, 2017.
% ========================================================

% Plotting the cross sections.
a = size(XPlot);

for k = 1:a
    ZPlot(k) = BeamFract(AirFol)*BeamLngth;
end
           
axis equal

figure(1)
xi=linspace(min(XPlot),max(XPlot),50);
yi=linspace(min(YPlot),max(YPlot),50);
[XI YI]=meshgrid(xi,yi);
ZI = griddata(XPlot,YPlot,ZPlot,XI,YI);
mesh(XI,YI,ZI);
		

  
   
