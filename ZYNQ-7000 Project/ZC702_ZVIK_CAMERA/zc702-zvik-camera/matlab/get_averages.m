% filenames={'DAY_dewarp_deshade'; 'CWF_dewarp_deshade'; 'U30_dewarp_deshade'; 'INC_dewarp_deshade'; };

N = 24;
Nimages = size(filenames,1);

im = imread([filenames{1},'.bmp']);

[rows, cols, planes] = size(im);
figure(1); 
imshow( im );
x = zeros(N,1);
y = zeros(N,1);
ave = zeros(N,3,4);
for box = 1:N
    [x(box),y(box)]=ginput(1);   
    x = max(1,min(cols,round(x)));
    y = max(1,min(rows,round(y)));
    ave(box,1,1) = mean(mean(im(y(box):y(box)+63, x(box):x(box)+63,1)));
    ave(box,2,1) = mean(mean(im(y(box):y(box)+63, x(box):x(box)+63,2)));
    ave(box,3,1) = mean(mean(im(y(box):y(box)+63, x(box):x(box)+63,3)));
    rectangle('Position',[x(box),y(box),64,64],'EdgeColor','g', 'FaceColor', ave(box,:,1)/255);
    text( x(box)+2, y(box)+10, num2str(ave(box,1,1)), 'Color', 'r');
    text( x(box)+2, y(box)+30, num2str(ave(box,2,1)), 'Color', 'g');
    text( x(box)+2, y(box)+50, num2str(ave(box,3,1)), 'Color', 'b');
end


for i=1:Nimages
    im = imread([filenames{i},'.bmp']);
    % figure(i); imshow( im );
    for box = 1:N
        ave(box,1,i) = mean(mean(im(y(box):y(box)+63, x(box):x(box)+63,1)));
        ave(box,2,i) = mean(mean(im(y(box):y(box)+63, x(box):x(box)+63,2)));
        ave(box,3,i) = mean(mean(im(y(box):y(box)+63, x(box):x(box)+63,3)));
        rectangle('Position',[x(box),y(box),64,64],'EdgeColor','g', 'FaceColor', ave(box,:,i)/255);
        text( x(box)+2, y(box)+10, num2str(ave(box,1,i)), 'Color', 'r');
        text( x(box)+2, y(box)+30, num2str(ave(box,2,i)), 'Color', 'g');
        text( x(box)+2, y(box)+50, num2str(ave(box,3,i)), 'Color', 'b');
    end
    im_s = imresize( im, 0.125);
    imwrite(im_s, [filenames{i},'_s.png']);
end

% save colorpatch_averages_under_exposed.mat ave; 
save colorpatch_averages.mat ave; 
