% This is the main code of CompSim that all the computaions take place. In
% this code, different structural properties are computed and presented as
% figures to the user.
%
% Written by Dr. Turaj Ashuri. CompSim V1.0, 1 June, 2017.
% ========================================================


% Finding the number of structural stations defined by the user
[NoAirFol,NoStr]=size(AirFolCordName);

% Length of the leading edge and trailing edge with respect to pitch axis
LEStrcChrd=StrcChrd.*(PichAxis)';
TEStrcChrd=(StrcChrd-LEStrcChrd);

% Looping through different cross sections of the structure
for AirFol=1:NoAirFol
    
    % Changing current directory to the directory that X and Y coordinates
    % are
    cd('AirfoilCoordinates');
    
    % Scaning the x-y coordinate files
    InFile=AirFolCordName(AirFol,:);
    FID = fopen(InFile,'r');
    Text = textscan (FID, '%s', 'delimiter', '\n');
    fclose(FID);
    N_LINES=length(Text {1});
    clear Coordinates;
      
    % Saving the airfoil coordinates in the X and Y matrix and multiplying
    % them by their related chord
    for I=2:N_LINES
        Coordinates (I-1,:)=str2num(Text {1}{I} (1:end));
        X=Coordinates(:,1)*StrcChrd(AirFol);
        Y=Coordinates(:,2)*StrcChrd(AirFol);
        XPlot = Coordinates(:,1)*StrcChrd(AirFol);
        YPlot = Coordinates(:,2)*StrcChrd(AirFol);
        ZPlot = BeamLngth*BeamFract(AirFol); 
    end
    
    % Calculating some geometrical properties of the points of the airfoil
    for I=1:N_LINES-2
        LinLngth(I)=sqrt((Y(I+1)-Y(I))^2+(X(I+1)-X(I))^2);
        SinBeta(I)=((Y(I+1)-Y(I))/LinLngth(I))';
        CosBeta(I)=((X(I+1)-X(I))/LinLngth(I))';
        MidYShll(I)=(Y(I+1)+Y(I))/2;
        MidXShll(I)=(X(I+1)+X(I))/2;
    end
    
    % Caclculating the first area moment of inertia of the shell
    MxShll=sum(ShllTick(AirFol)*LinLngth.*MidYShll);
    MyShll=sum(ShllTick(AirFol)*LinLngth.*MidXShll);
    
    % Calculating the centroid of the shell
    YbarShll=MxShll/sum(ShllTick(AirFol)*LinLngth);
    XbarShll=MyShll/sum(ShllTick(AirFol)*LinLngth);
    
    % Calculating the perimeter of the shell and its area
    ShllPerimeter=sum(LinLngth);
    ShllArea(AirFol)=ShllPerimeter*ShllTick(AirFol);
      
    % Calculating second moment of inertia of shell around its centroid
    YCenShll=MidYShll-YbarShll;
    IxxPShll=1/12*ShllTick(AirFol)*LinLngth.^3.*SinBeta.*SinBeta+ShllTick(AirFol)*LinLngth.*YCenShll.*YCenShll;
    IxxPShll=sum(IxxPShll);
    
    % Finding the minimum value of X and its index
    [XPosLe,XIndxLe]=min(X);
    
    % The position of the web 1 with respect to a real chord
    Web1Pos=Web1Loc*StrcChrd(AirFol);
    
    % The position of the web 2 with respect to a real chord
    Web2Pos=Web2Loc*StrcChrd(AirFol);
    
    % The width of the spar
    SparXWidth=abs(Web1Pos-Web2Pos);
    
    % Y value of the upper Web 1
    UprWeb1=interp1(X(1:XIndxLe),Y(1:XIndxLe),Web1Pos);
    MidUprWeb1=UprWeb1/2;
    
    % Y value of the lower Web 1
    LwrWeb1=interp1(X(XIndxLe:end),Y(XIndxLe:end),Web1Pos);
    MidLwrWeb1=LwrWeb1/2;
    
    % Calculating the first moment of inertia of the first web
    Web1Lngth=UprWeb1+abs(LwrWeb1);
    YbarWeb1=(UprWeb1+LwrWeb1)/2;
    MxWeb1=WebTick(AirFol)*Web1Lngth*YbarWeb1;
    MyWeb1=WebTick(AirFol)*Web1Lngth*Web1Pos/2;
    
    % Calculating second moment of inertia of Web 1
    IxxPWeb1=1/12*WebTick(AirFol)*UprWeb1^3+WebTick(AirFol)*UprWeb1*((YbarWeb1-MidUprWeb1)^2)+1/12*WebTick(AirFol)*LwrWeb1^3+WebTick(AirFol)*LwrWeb1*((YbarWeb1-MidLwrWeb1)^2);
    
    % Y value of the upper Web 2
    UprWeb2=interp1(X(1:XIndxLe),Y(1:XIndxLe),Web2Pos);
    MidUprWeb2=UprWeb2/2;
    
    % Y value of the lower Web 2
    LwrWeb2=interp1(X(XIndxLe:end),Y(XIndxLe:end),Web2Pos);
    MidLwrWeb2=LwrWeb2/2;
    
    % Calculating the first moment of inertia of the second web
    Web2Lngth=UprWeb2+abs(LwrWeb2);
    YbarWeb2=(UprWeb2+LwrWeb2)/2;
    MxWeb2=sum(WebTick(AirFol)*Web2Lngth*YbarWeb2);
    MyWeb2=sum(WebTick(AirFol)*Web2Lngth*Web2Pos/2);
    
    % Calculating second moment of inertia of Web 2 in flapwise direction
    IxxPWeb2=1/12*WebTick(AirFol)*UprWeb2^3+WebTick(AirFol)*UprWeb2*((YbarWeb2-MidUprWeb2)^2)+1/12*WebTick(AirFol)*LwrWeb2^3+WebTick(AirFol)*LwrWeb2*((YbarWeb2-MidLwrWeb2)^2);
    
    % Calculating the first moment of inertia of the upper Spar
    UprSparLngth=sqrt((SparXWidth)^2+(UprWeb1-UprWeb2)^2);
    XbarUprSpar=(Web1Pos+Web2Pos)/2;
    YbarUprSpar=(UprWeb1+UprWeb2)/2;
    MxUprSpar=SparTick(AirFol)*UprSparLngth*YbarUprSpar;
    MyUprSpar=SparTick(AirFol)*UprSparLngth*XbarUprSpar;
    
    % Calculating the second moment of inertia of the upper Spar
    UprSparSinAlpha=abs(UprWeb1-UprWeb2)/UprSparLngth;
    IxxPUprSpar=1/12*UprSparLngth*SparTick(AirFol)^3*(UprSparSinAlpha)^2;
    
    % Calculating the first moment of inertia of the lower Spar
    LwrSparLngth=sqrt((SparXWidth)^2+(LwrWeb1-LwrWeb2)^2);
    XbarLwrSpar=XbarUprSpar;
    YbarLwrSpar=(LwrWeb1+LwrWeb2)/2;
    MxLwrSpar=SparTick(AirFol)*LwrSparLngth*YbarLwrSpar;
    MyLwrSpar=SparTick(AirFol)*LwrSparLngth*XbarLwrSpar;
    
    % Calculating the second moment of inertia of the lower Spar
    LwrSparSinAlpha=abs(LwrWeb1-LwrWeb2)/LwrSparLngth;
    IxxPLwrSpar=1/12*LwrSparLngth*SparTick(AirFol)^3*(LwrSparSinAlpha)^2;
    
    % Area and modulus of elasticity of the total section
    EATtalX=ShllModulElstX*ShllArea(AirFol)+WebModulElstX*Web1Lngth*WebTick(AirFol)+WebModulElstX*Web2Lngth*WebTick(AirFol)+SparModulElstX*UprSparLngth*SparTick(AirFol)+SparModulElstX*LwrSparLngth*SparTick(AirFol);
    
    EATtalY=ShllModulElstY*ShllArea(AirFol)+WebModulElstY*Web1Lngth*WebTick(AirFol)+WebModulElstY*Web2Lngth*WebTick(AirFol)+SparModulElstY*UprSparLngth*SparTick(AirFol)+SparModulElstY*LwrSparLngth*SparTick(AirFol);
    
    % Distance to neutral axis 
    XbarTtal=(1/EATtalX)*(ShllModulElstX*MyShll+WebModulElstX*MyWeb1+WebModulElstX*MyWeb2+SparModulElstX*MyUprSpar+SparModulElstX*MyLwrSpar);
    YbarTtal=(1/EATtalY)*(ShllModulElstY*MxShll+WebModulElstY*MxWeb1+WebModulElstY*MxWeb2+SparModulElstY*MxUprSpar+SparModulElstY*MxLwrSpar);
    
    % The moment arm from the neutral axis in flap direction
    ChrdMaxStrsArm(AirFol)=max(XbarTtal,abs(StrcChrd(AirFol)-XbarTtal));
    
    % The moment arm from the neutral axis in edge direction
    MaxY=max(Y);
    MinY=min(Y);
    CmbrMaxStrsArm(AirFol)=max((MaxY-YbarTtal),abs(YbarTtal-MinY));
    
    
    % The transforemed second moment of Inertia of each section using
    % parallel axis theory
    IxxPShllT=IxxPShll+ShllArea(AirFol)*(YbarShll-YbarTtal)^2;
    IxxPWeb1T=IxxPWeb1+Web1Lngth*WebTick(AirFol)*(YbarWeb1-YbarTtal)^2;
    IxxPWeb2T=IxxPWeb2+Web2Lngth*WebTick(AirFol)*(YbarWeb2-YbarTtal)^2;
    IxxPUprSparT=IxxPUprSpar+UprSparLngth*SparTick(AirFol)*(YbarUprSpar-YbarTtal)^2;
    IxxPLwrSparT=IxxPLwrSpar+LwrSparLngth*SparTick(AirFol)*(YbarLwrSpar-YbarTtal)^2;
     
    % Calculating second moment of inertia of shell around its centroid
    XCenShll=MidXShll-XbarShll;
    IyyPShll=1/12*ShllTick(AirFol)*LinLngth.^3.*CosBeta.*CosBeta+ShllTick(AirFol)*LinLngth.*XCenShll.*XCenShll;
    IyyPShll=sum(IyyPShll);
    
    % Calculating second moment of inertia of Web 1
    IyyPWeb1=1/12*Web1Lngth*WebTick(AirFol)^3;
    
    % Calculating second moment of inertia of Web 2
    IyyPWeb2=1/12*Web2Lngth*WebTick(AirFol)^3;
    
    % Calculating the second moment of inertia of the upper Spar
    UprSparCosAlpha=abs(Web1Pos-Web2Pos)/UprSparLngth;
    IyyPUprSpar=1/12*SparTick(AirFol)*UprSparLngth^3*(UprSparCosAlpha)^2;
    
    % Calculating the second moment of inertia of the Lower Spar
    LwrSparCosAlpha=abs(Web1Pos-Web2Pos)/LwrSparLngth;
    IyyPLwrSpar=1/12*SparTick(AirFol)*LwrSparLngth^3*(LwrSparCosAlpha)^2;
    
    % The transforemed second moment of Inertia of each section using
    % parallel axis theory
    IyyPShllT=IyyPShll+ShllArea(AirFol)*(XbarShll-XbarTtal)^2;
    IyyPWeb1T=IyyPWeb1+Web1Lngth*WebTick(AirFol)*(Web1Pos-XbarTtal)^2;
    IyyPWeb2T=IyyPWeb2+Web2Lngth*WebTick(AirFol)*(Web2Pos-XbarTtal)^2;
    IyyPUprSparT=IyyPUprSpar+UprSparLngth*SparTick(AirFol)*(XbarUprSpar-XbarTtal)^2;
    IyyPLwrSparT=IyyPLwrSpar+LwrSparLngth*SparTick(AirFol)*(XbarLwrSpar-XbarTtal)^2;
      
    % Calculating second moment of inertia of shell around its centroid
    IxyPShll=1/12*ShllTick(AirFol)*LinLngth.^3.*SinBeta.*CosBeta+ShllTick(AirFol)*LinLngth.*XCenShll.*YCenShll;
    IxyPShll=sum(IxyPShll);
    
    % Calculating product moment of inertia of Web 1
    IxyPWeb1=0;
    
    % Calculating product moment of inertia of Web 2
    IxyPWeb2=0;
    
    % Calculating product moment of inertia of the upper Spar
    IxyPUprSpar=1/12*SparTick(AirFol)*UprSparLngth^3*(UprSparCosAlpha)*(UprSparSinAlpha);
    
    % Calculating the product moment of inertia of the lower Spar
    IxyPLwrSpar=1/12*SparTick(AirFol)*LwrSparLngth^3*(UprSparCosAlpha)*(UprSparSinAlpha);
    
    % The transforemed second moment of inertia of each section using
    % parallel axis theory
    IxyPShllT=IxyPShll+ShllArea(AirFol)*(XbarShll-XbarTtal)*(YbarShll-YbarTtal);
    IxyPWeb1T=IxyPWeb1+Web1Lngth*WebTick(AirFol)*(Web1Pos-XbarTtal)*(YbarWeb1-YbarTtal);
    IxyPWeb2T=IxyPWeb2+Web2Lngth*WebTick(AirFol)*(Web2Pos-XbarTtal)*(YbarWeb1-YbarTtal);
    IxyPUprSparT=IxyPUprSpar+UprSparLngth*SparTick(AirFol)*(XbarUprSpar-XbarTtal)*(YbarWeb1-YbarTtal);
    IxyPLwrSparT=IxyPLwrSpar+LwrSparLngth*SparTick(AirFol)*(XbarLwrSpar-XbarTtal)*(YbarWeb1-YbarTtal);
    
  
    % Area moment of interia of shell
    IxxShll(AirFol)=((IxxPShllT+IyyPShllT)/2)+((IxxPShllT-IyyPShllT)/2)*cosd(2*StrcTwst(AirFol))-IxyPShllT*sind(2*StrcTwst(AirFol));
    IyyShll(AirFol)=((IxxPShllT+IyyPShllT)/2)-((IxxPShllT-IyyPShllT)/2)*cosd(2*StrcTwst(AirFol))+IxyPShllT*sind(2*StrcTwst(AirFol));
    
    % Area moment of interia of web1
    IxxWeb1(AirFol)=((IxxPWeb1T+IyyPWeb1T)/2)+((IxxPWeb1T-IyyPWeb1T)/2)*cosd(2*StrcTwst(AirFol))-IxyPWeb1T*sind(2*StrcTwst(AirFol));
    IyyWeb1(AirFol)=((IxxPWeb1T+IyyPWeb1T)/2)-((IxxPWeb1T-IyyPWeb1T)/2)*cosd(2*StrcTwst(AirFol))+IxyPWeb1T*sind(2*StrcTwst(AirFol));
    
    % Area moment of interia of web2
    IxxWeb2(AirFol)=((IxxPWeb2T+IyyPWeb2T)/2)+((IxxPWeb2T-IyyPWeb2T)/2)*cosd(2*StrcTwst(AirFol))-IxyPWeb2T*sind(2*StrcTwst(AirFol));
    IyyWeb2(AirFol)=((IxxPWeb2T+IyyPWeb2T)/2)-((IxxPWeb2T-IyyPWeb2T)/2)*cosd(2*StrcTwst(AirFol))+IxyPWeb2T*sind(2*StrcTwst(AirFol));
    
    % Area moment of interia of upper spar
    IxxUprSpar(AirFol)=((IxxPUprSparT+IyyPUprSparT)/2)+((IxxPUprSparT-IyyPUprSparT)/2)*cosd(2*StrcTwst(AirFol))-IxyPUprSparT*sind(2*StrcTwst(AirFol));
    IyyUprSpar(AirFol)=((IxxPUprSparT+IyyPUprSparT)/2)-((IxxPUprSparT-IyyPUprSparT)/2)*cosd(2*StrcTwst(AirFol))+IxyPUprSparT*sind(2*StrcTwst(AirFol));
    
    % Area moment of interia of Lower Spar
    IxxLwrSpar(AirFol)=((IxxPLwrSparT+IyyPLwrSparT)/2)+((IxxPLwrSparT-IyyPLwrSparT)/2)*cosd(2*StrcTwst(AirFol))-IxyPLwrSparT*sind(2*StrcTwst(AirFol));
    IyyLwrSpar(AirFol)=((IxxPLwrSparT+IyyPLwrSparT)/2)-((IxxPLwrSparT-IyyPLwrSparT)/2)*cosd(2*StrcTwst(AirFol))+IxyPLwrSparT*sind(2*StrcTwst(AirFol));
    
    % Flapwise second moment of inertia
    Ixx=IxxShll+IxxWeb1+IxxWeb2+IxxUprSpar+IxxLwrSpar;
        
    % Edgewise second moment of inertia
    Iyy=IyyShll+IyyWeb1+IyyWeb2+IyyUprSpar+IyyLwrSpar;
    
    % Flapwise stifness distribution
    BeamFlpStff(AirFol)=ShllModulElstY*IxxShll(AirFol)+WebModulElstY*(IxxWeb1(AirFol)+IxxWeb2(AirFol))+SparModulElstY*(IxxUprSpar(AirFol)+IxxLwrSpar(AirFol));
        
    % Edgewise stifness distribution
    BeamEdgStff(AirFol)=ShllModulElstX*(IyyShll(AirFol))+WebModulElstX*(IyyWeb1(AirFol)+IyyWeb2(AirFol))+SparModulElstX*(IyyUprSpar(AirFol)+IyyLwrSpar(AirFol));
    
    % Calculating the area of Web 1 and 2
    Web1Area(AirFol)=Web1Lngth*WebTick(AirFol);
    Web2Area(AirFol)=Web2Lngth*WebTick(AirFol);
    
    % Calculating the area of upper and lower spar
    UprSparArea(AirFol)=UprSparLngth*SparTick(AirFol);
    LwrSparArea(AirFol)=LwrSparLngth*SparTick(AirFol);
    
    % Calculating the sectional densities
    BeamMassDen(AirFol)=ShllRho*ShllArea(AirFol)+WebRho*(Web1Area(AirFol)+Web2Area(AirFol))+SparRho*(UprSparArea(AirFol)+LwrSparArea(AirFol));
    
    % Changing to parent directory
    cd('..');
    
    % Plotting the cross section of the structure
    PlotCrsSec
    
    hold on
    
end
hold off

% Plot stifnesses
PlotStifnses

% Second mass moment of inertia with respect to the root of the structure
NoSect=length(BeamFract);
for I=1:(NoSect-1)
    SecLngthFract(I,:)=BeamFract(I+1)-BeamFract(I);
    SecBeamMass(I,:)=BeamLngth*SecLngthFract(I)*BeamMassDen(I);
    BSecMassMomInrt(I,:)=0.5*SecBeamMass(I)*((SecLngthFract(I)/2)*BeamLngth)^2+SecBeamMass(I)*(((BeamFract(I+1)+BeamFract(I)/2)*BeamLngth))^2;
end

% Total Mass of the structure
BeamMass=sum(SecBeamMass);

% Plot mass distribution
PlotMasDistrbtn

% Estimate of the mass moment of inertia
BeamMassMomInrt=sum(BSecMassMomInrt);

% BStrProp Array which contains srtructural properties
BeamStrProp=[(BeamFract);(StrcTwst)'; (StrcChrd)';(BeamMassDen);(BeamFlpStff);(BeamEdgStff)];

% Display message
disp('Computing structural properties completed sucessfully.')

