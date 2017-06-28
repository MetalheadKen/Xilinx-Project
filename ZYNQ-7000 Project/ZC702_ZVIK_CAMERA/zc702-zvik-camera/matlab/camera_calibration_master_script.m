% This application calculates Color Correction values for the ZVIK demo
% 
% Before running this script, collect images with the ZVIK with the camera 
% by pointing to the 24 colorpatch XRite Color-checker chart, in a 
% light-box. Please make sure that the Color-Correction Matrix
% is set to 'Bypass', auto-exposure is turned on, and the camera and the 
% target are in identical positions throughout capturing images
% corresponding to the different illuminations.

% Enter the names of input files below, without the .bmp extention,
filenames={'DAY'; 'CWF'; 'U30'; 'INC'; };

% Select the index of color-patches which need to be included in the 
% CCM coefficient calculation process. Color patches are indexed from 
% left to right, top to bottom: E.g.:range = [1:24, 21, 21, 21, 22, 22, 22];
range = [1:24, 21, 21, 21, 22, 22, 22];

% Below are the target gamma corrected RGB values corresponding to the 24
% patches, as documented XRite.
Target_sRGB = [[ 115,  82,  68 ]; [ 194, 150, 130 ]; [  98, 122, 157 ]; ...  % 1 -3
               [  87, 108,  67 ]; [ 133, 128, 177 ]; [ 103, 189, 170 ]; ...  % 4 -6
               [ 214, 126,  44 ]; [  80,  91, 166 ]; [ 193,  90,  99 ]; ...  % 7 -9
               [  94,  60, 108 ]; [ 157, 188,  64 ]; [ 224, 163,  46 ]; ...  % 10-12
               [  56,  61, 150 ]; [  70, 148,  73 ]; [ 175,  54,  60 ]; ...  % 13-15 Blue, Green, Red
               [ 231, 199,  31 ]; [ 187,  86, 149 ]; [   8, 133, 161 ]; ...  % 16-18 Yellow, Magenta, Cyan
               [ 243, 243, 243 ]; [ 200, 200, 200 ]; [ 160, 160, 160 ]; ...  % 19-21 Whites
               [ 122, 122, 121 ]; [  85,  85,  85 ]; [  52,  52,  52 ]];

% De-warp and De-shade input images:
input_registration; 

Nimages = size(filenames,1);
filenames_orig = filenames;
for i=1:Nimages
    filenames{i}=[filenames{i},'_dewarp_deshade'];
end

% Calculate color-patch averages:
get_averages; 

% Calculate non-gamma-corrected RGB values:
scale = exp(2.2*log(255))/255.5;
Target =  exp(2.2*log(Target_sRGB))./scale;

CCM_init =  [eye(3), zeros(3,1)];
CCM = cell(Nimages,1);
im  = cell(2*Nimages,1);
for i=1:Nimages
    im{i}= imread( [filenames{i},'_s.png']);
    s =  ['  Finding best correction for ',filenames{i},' to Greta MacBeth targets'];
    disp('--------------------------------------------------------------------------');
    disp(s);
    disp('--------------------------------------------------------------------------');
    [CCM{i}, im{i+Nimages}] = anneal( im{i}, Target(range,:), ave(range,:,i), CCM_init, 0.05, 0.01, ave(24,:,i));
    figure(1); subplot(2,2,i); imshow(im{i+Nimages});
    s=filenames_orig{i};
    imwrite(im{i+Nimages}, [filenames{i},'_sres.png']);
    title([s, ' corrected']);    
    ccm = CCM{i}; offs = ccm(:,4); ccm = ccm(:,1:3);
    S_mapped = min(255,max(0, ave(:,:,i) * ccm + repmat(offs',[24,1])));
end;

save ccm_coeffs_offsets.mat CCM;

disp(' ');
disp('Optimized Camera Color Correction Matrix results:');
format short g;
for i=1:Nimages
   ccm=CCM{i};
   s=filenames_orig{i};
   disp(['Coefficient matrix and offset vector for image ',s]);    
   for k=1:3
       fprintf('          %-7f,  %-7f,  %-7f,           %-7f\n',ccm(k,1:3),ccm(k,4));
   end
end
% The code below prints out the calculated Color Coeffients and 
% offsets formatted such that they can be entered into the ZVIK SDK
% project:

disp(' ');
disp('Quantized, fix-point coefficients for the Xilinx CCM IP core:');
for i=1:Nimages
   ccm=CCM{i};
   offs = ccm(:,4); ccm = ccm(:,1:3);
   BGR2CbYCr = round(ccm*32768);
   OFFS = round(offs)';
   s=filenames_orig{i};
   disp(['Coefficient matrix and offset vector for image ',s]);    
   for k=1:3
       fprintf('          %-6d,  %-6d,  %-6d,           %-5d\n',BGR2CbYCr(k,:),OFFS(k));
   end
end