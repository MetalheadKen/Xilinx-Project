function [CCM, im_mapped] = anneal( imS, T, S, CCM_init, Tc_start, Tc_end, Black_level)
% Simulated annealing approximation to find 9 correction coefficients, and
% 3 offsets, which, if used in the Color-Correction Matrix core, map the
% RGB colors provided in input matrix RGB such that the Chrominance
% histogram of the mapped colors match input CC_hist_target as closely as
% possible by minimizing the sum of squares between mapped histogram and
% target histogram.

    Tc = Tc_start;      Ccooling = 0.99995;
    To = Tc_start*10;   Ocooling = 0.99995;
    CCM =  CCM_init(:,1:3);
    OFFS = CCM_init(:,4) - Black_level';
    n = size(S,1);
    [rows, cols, planes] = size(imS);
    imS_lin = double(reshape(imS, [rows*cols, 3]));

    err_best = pow2(30);
    figure(2); 
    subplot(1,2,1); image(imS);  title('Original Source'); 
    subplot(1,2,2); image(imS);  title('Corrected Source'); 
    stTc = ['To=', num2str(To,'%6.5f')];
    stTo = ['Tc=', num2str(Tc,'%6.4f')];
    stEr = ['Error=', num2str(10000,'%6d')];
    hTc = uicontrol('Style','text','String', stTc ,'Position',[300 2 70 20]);
    hTo = uicontrol('Style','text','String', stTo ,'Position',[380 2 70 20]);
    hEr = uicontrol('Style','text','String', stEr ,'Position',[460 2 120 20]);
    tic;

    T_YCC = rgb2ycbcr(T); 
    S_YCC = rgb2ycbcr(S); 
    T_RGB = T./(sum(T_YCC(:,1))/sum(S_YCC(:,1)));
    T_HSV = rgb2hsv(T_RGB); 
        
    while (Tc>Tc_end) 
        S_mapped = S * CCM' + double(repmat(OFFS',[n,1]));
        % S_mapped = S * CCM + repmat(OFFS',[n,1]);
        % S_mapped_YCC = rgb2ycbcr(S_mapped);
        % S_mapped_HSV = rgb2hsv(S_mapped);
        % err =     sum(sum(abs(T_HSV(:,1)-S_mapped_HSV(:,1))));
        % err = err+sum(sum(abs(T_HSV(:,2)-S_mapped_HSV(:,2))))/5;
        % err = err+sum(sum(abs(T_HSV(:,3)-S_mapped_HSV(:,3))))/250;
        % err = sum(sum(abs(T_YCC(:,2:3)-S_mapped_YCC(:,2:3))));
        % err = sum(sum((T_RGB-S_mapped).^2));
        err = sum(sum((T-S_mapped).^2));
        
        if (err<err_best)
            err_best = err;
            CCM_best = CCM;
            OFFS_best = OFFS;
            figure(2);
            im_mapped =  uint8(min(255,max(0,reshape( imS_lin * CCM' + repmat(OFFS',[rows*cols,1]) , [rows, cols, 3]))));
            subplot(1,2,2); image(im_mapped); title('Corrected Source');  
            stEr = ['Error=', num2str(err,'%6.4f')];
            set(hEr,'String',stEr);            
            title('Current Best Approximation'); colormap(hot(256));
        end
        
        delta_c = Tc*randn(3);
        delta_o = To*randn(3,1);
        CCM  = max(-3.99, min(3.99, CCM_best+ delta_c));
        OFFS = max(-128, min(127, OFFS_best+ delta_o));
        % CCM  = CCM ./ sqrt(sum(sum(CCM.^2)))*3;  % normalize the matrix
        % CCM  = CCM ./ sum(sum(CCM))*3;  % normalize the matrix
        % OFFS = OFFS - mean(OFFS);
        

        Tc = Tc * Ccooling;
        To = To * Ocooling;            
        stTc = ['To=', num2str(To,'%6.4f')];
        stTo = ['Tc=', num2str(Tc,'%6.5f')];
        set(hTc,'String',stTc);
        set(hTo,'String',stTo);
        drawnow;        
    end

    CCM = [CCM_best, OFFS_best];
    S_mapped;
    err_best;
    toc
end