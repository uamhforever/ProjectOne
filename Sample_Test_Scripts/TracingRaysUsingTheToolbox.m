%% Step 1. Define your optical system. This can be done using the GUI of the toolbox. 
% Then you can also just open an already saved optical systems by giving 
% its full file name. The path shall be changed to the actual folder path
% in your PC.
doubleGaussFullFileName = 'D:\MatLightTracer_GitHub\Sample_Optical_Systems\Double Gauss 28 degree field.mat';
prismFullFileName = 'C:\Users\li\Desktop\MatLightTracer_Toolbox\MatLightTracer_GitHub\Sample_Optical_Systems\Prisms using coordinate breaks.mat';

optSystem = OpticalSystem(doubleGaussFullFileName);

%% Step 2. Define your initial rays. This can be done by two methods
%   2.1. By defining the all parameters of your initial rays and putting
%   them in ScalarRayBundle struct. 
%       Single ray generating functions
        pos = [0,0,0;1*10^-3,0,-1*10^-3;0,0,0];
        dir = [0,0,0;0,0,0;1,1,1];
        wav = [0.55*10^-6];
        directlyCreatedRayBundle = ScalarRayBundle( pos,dir,wav);
        

%   2.2. Using the field index, wavelength index and the number of pupil
%   points. This seems more simple method to obtain bundle of initial rays.
%   You can also use predefined functions such as getChiefRay() and 
%   getMariginalRay() to get specific initial rays.
%       Single ray generating functions
        fieldIndex = 1;
        wavelengthIndex = 1;
        chiefRay = getChiefRay(optSystem,fieldIndex,wavelengthIndex);
        mariginalRay = getMariginalRay(optSystem,fieldIndex,wavelengthIndex);

%       Ray bundle generating functions
        fieldIndices = 1;
        wavelengthIndices = 1;
        nRay1=31;
        nRay2=31;
        pupilSamplingType = 'Cartesian'; % Can also be 'Tangential','Sagital','Cross','Polar','Random'
        initialRayBundle = getInitialRayBundle(optSystem,wavelengthIndices,...
        fieldIndices, nRay1,nRay2,pupilSamplingType);

    %% Step 3. Tracer the rays though the optical system using rayTracer

    % As the user is not interested in everthing which comes out from the
    % ray tracer, the ray tracer function accepts an option struct which
    % has flags about what to compute and what not to during the ray
    % tracer. The ray trace option struct has the following fields
    %  ConsiderPolarization,ConsiderSurfaceAperture,RecordIntermediateResults,...
    %  ComputeGeometricalPathLength,ComputeOpticalPathLength,ComputeGroupPathLength,...
    %  ComputeRefractiveIndex,ComputeRefractiveIndexFirstDerivative,...
    %  ComputeRefractiveIndexSecondDerivative,ComputeGroupIndex
    % By defualt ConsiderSurfaceAperture,ComputeGeometricalPathLength and 
    % ComputeRefractiveIndex are set to true and all others are flase.
    [ options ] = RayTraceOptionStruct( );

rayTracerResult = rayTracer(optSystem, initialRayBundle,options);

%% Step 4. Access the ray trace results
% The ray trace result is struct with everything computed during the ray
% trace. So the results could be individually accessed. Since the result is 
% a high dimensional matrix including results for all surfaces, all field points,
% all wavelengths and all rays accessing the results directly from the 
% rayTraceResult struct could be bit confusing. Inorder to simplify the
% result accessing there are bunch of functions written which accept the
% surface indices, wavelength  and field indices and return the required
% values in lower dimensions which is more easy to understand.

surfaceRayIntersectionPoint = getAllSurfaceRayIntersectionPoint(rayTracerResult);
geometricalPathLength = getAllSurfaceGeometricalPathLength(rayTracerResult);



