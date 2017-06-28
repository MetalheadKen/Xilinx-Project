% Get control points for each new image recapture:
im = imread([filenames{1}, '.bmp']);

if exist('XY_im','var')<1 
    base = uint8(255*ones(900, 1200, 3));
    cross = uint8(255*ones(9, 9, 3));
    cross(:, 5, :) = 0;
    cross(5, :, :) = 0;
    xp=50:183:1148;
    yp=50:200:850;
    for y=yp
        base(y:y+8,50:58,:) = cross;
        base(y:y+8,1148:1156,:) = cross;
    end
    for x=xp
        base(50:58,x:x+8,:) = cross;
        base(850:858,x:x+8,:) = cross;
    end
    [XY_im,XY_base] = cpselect(im, base, 'Wait', true);
end

d = fdesign.lowpass('N,Fc',8,0.25);
% Design FIR equiripple filter
lp_1d = design(d);
lp_2d = lp_1d.Numerator' * lp_1d.Numerator;
% Normalize 2d low-pass filter:
lp_2d = lp_2d / sum(sum(lp_2d));

% The section below visualizes the control points:
% cntrl = uint8(zeros(1080, 1920, 3));
% N_ctrl_pts = size(XY_im,1);
% for i=1:N_ctrl_pts
%     y = int32(XY_im(i,2));
%     x = int32(XY_im(i,1));
%     cntrl( y:y+2, x:x+2, 2:3) = 255;
% end;
% figure(3); imshow(cntrl);

transform = cp2tform(XY_im, XY_base, 'polynomial',3);


Nimages = size(filenames,1);
for i=1:Nimages
    im = imread([filenames{i}, '.bmp']);
    im_transf = imtransform(im, transform, 'XData', [-49,1250], 'YData', [-49,950]);
    % im_cropped = im_transf(1:900, 1:1200,:);
    % figure(2); imshow(im_transf);
    [rows, cols, planes] = size(im_transf);
    vvect = (im_transf(:, 1, :) +  im_transf(:, end, :))./2;
    hvect = (im_transf(1, :, :) +  im_transf(end, :, :))./2;
    ycc = double(rgb2ycbcr( im_transf ));
    ycc_v = rgb2ycbcr(vvect); y_vvect = double( ycc_v(:,1,1) );
    ycc_h = rgb2ycbcr(hvect); y_hvect = double( ycc_h(1,:,1) );
    y_matrix = sqrt(y_vvect * y_hvect); y_ave = mean(mean(y_matrix));
    % figure(1); imshow(uint8(y_matrix));
    y_matrix = y_ave ./ y_matrix;

    % Smooth the matrix:
    y_matrix = filter2(lp_2d, y_matrix);

    ycc(:,:,1) = ycc(:,:,1) .* y_matrix.^2;
    rgb = ycbcr2rgb(uint8(ycc)); 
    % figure(3); imshow(rgb);
    imwrite(rgb, [filenames{i}, '_dewarp_deshade.bmp']);
end