% This file contains all the input data needed for the code to run. The first 
% part of the input is used to define the geometry of the structure. The 
% second part of the input is used to define tha material propoerties of the 
% structure.
%
%
% Written by Dr. Turaj Ashuri. CompSim V1.0, 1 July, 2017.
% ========================================================
%
% Defining the geometry of the structure.
% =======================================                                                                     

% Length of the slender beam structure
BeamLngth = 135;

% Nondimensional section of the structure that airfoil data and structural
% properties will be definded
BeamFract=[0.0000 0.0195 0.0520 0.0845 0.1170 0.1495 0.1821 0.2146 ...
0.2471 0.2959 0.3935 0.4910 0.5886 0.6861 0.7837 0.8813 0.9300 ...
0.9544 0.9788 1.0000];

% The name of the files that contains the structure X,Y coordinates at 
% locations defined by "BeamFract" 
AirFolCordName=['Cylinder1.dat';'Cylinder1.dat';'Cylinder1.dat'; ...
'Cylinder2.dat';'Cylinder2.dat';'XDU00W401.dat';'XDU00W401.dat'; ...
'XDU97W300.dat';'XDU97W300.dat';'XDU97W300.dat';'DU91W2250.dat'; ...
'XDU93W210.dat';'XDU93W210.dat';'XDU93W210.dat';'NACA64618.dat'; ...
'NACA64618.dat';'NACA64618.dat';'NACA64618.dat';'NACA64618.dat'; ...
'NACA64618.dat'];

% Structural chord length at locations defined by "BeamFract"
StrcChrd = [7.6000;7.6000;7.6000;8.2222;9.3778;10.0000;9.6496;8.8185; ...
7.8293;6.7545;5.8948;5.3298;4.9281;4.5603;4.0953;3.4030;2.9320; ...
2.5563;2.0385;1.5750];

% Structural twist (deg) at locations defined by "BeamFract"
StrcTwst = [14.7607;14.7607;14.7607;14.7607;14.7607;14.7607;13.6996; ...
11.2294;8.3966;5.7566;4.6826;4.0444;3.5898;3.0691;2.5520;1.9825; ...
1.5412;1.1555;0.6021;0.0808];

% Pitch axis of the structure at locations defined by "BeamFract"
PichAxis=[0.5 0.5 0.5 0.46 0.42 0.39 0.375 0.375 0.375 0.375 0.375 ...
0.375 0.375 0.375 0.375 0.375 0.375 0.375 0.375 0.375];

% Location of the first and second shear web along the chord
Web1Loc=0.15;
Web2Loc=0.50;

% Defining the material properties of the structure.
% ==================================================    

% Thickness of the spart at locations defined by "BeamFract"
SparTick = [0;0;0.1440;0.1414;0.1362;0.1320;0.1296;0.1273;0.1251; ...
0.1218;0.1157;0.1105;0.1061;0.1028;0.1007;0.1000;0.1000; ...
0.1000;0.1000;0.1000];

% Thickness of the web at locations defined by "BeamFract"
WebTick = [0;0;0.1450;0.1540;0.1587;0.1600;0.1600;0.1600;0.1599; ...
0.1597;0.1593;0.1585;0.1574;0.1560;0.1542;0.1520;0.1485;0.1457; ...
0.1426;0.1400];

% Thickness of the shell at locations defined by "BeamFract"
ShllTick = [0.1900;0.1898;0.1890;0.1841;0.1759;0.1710;0.1701;0.1693; ...
0.1687;0.1680;0.1670;0.1665;0.1662;0.1655;0.1642;0.1620;0.1559; ...
0.1506;0.1448;0.1400];      

% Modulus of elasticity of the shell in Ex and Ey direction
ShllModulElstX=17E9;
ShllModulElstY=17E9;

% Modulus of the elasticity of the spar in Ex and Ey direction
SparModulElstX=32E9;   
SparModulElstY=32E9;   

% Modulus of the elasticity of the web in Ex and Ey direction
WebModulElstX=17E9;
WebModulElstY=17E9;

% Density of the Shell
ShllRho=510;        

% Density of the shear Web
WebRho=510; 

% Density of the Spar
SparRho=690; 