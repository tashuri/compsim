% This file prints some useful structural properties of the structure. The user
% can modify this file to generate any inputs of interest.
%
% Written by Dr. Turaj Ashuri. CompSim V1.0, 10 June, 2017.
% ========================================================
%
% Print the structural properties to the file
FID = fopen('OutputData.dat','w');
fprintf(FID,['Span location, ', 'Twist, ', 'Chord, ','Mass per unit length, ', 'Flap-stifness, ', 'Edge-stifness \n']);
fprintf(FID,'============================================================================\n');
fprintf(FID,'%7.5f  %8.3f   %8.3f   %8.3E  %8.4E    %8.4E \n', BeamStrProp);
fprintf(FID,'============================================================================\n');
fprintf(FID,'%s \n',['Mass of the total structure is = '    num2str(BeamMass)]);
fclose(FID);

% Display message
disp('Writing output data completed sucessfully.')
