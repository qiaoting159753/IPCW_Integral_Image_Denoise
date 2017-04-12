
for patchSize = 0:4
    patchSize = 5 + patchSize * 4;
    for windowSize = 0:4
        windowSize = 5 + windowSize * 4;
        for h = 1:5
            h = 0.3 + 0.1 * h;
                
            image1 = imread('images/alleyNoisy_sigma20.png');
            temp_image1 = rgb2gray(image1);
            imageNoisy1 = im2double(temp_image1);
                
            ref_image1 = imread('images/alleyReference.png');
            ref_temp_image1 = rgb2gray(ref_image1);
            imageReference1 = im2double(ref_temp_image1);
                
            image2 = imread('images/townNoisy_sigma5.png');
            temp_image2 = rgb2gray(image2);
            imageNoisy2 = im2double(temp_image2);
                
            ref_image2 = imread('images/townReference.png');
            ref_temp_image2 = rgb2gray(ref_image2);
            imageReference2 = im2double(ref_temp_image2);
                
            image3 = imread('images/treesNoisy_sigma10.png');
            temp_image3 = rgb2gray(image3);
            imageNoisy3 = im2double(temp_image3);
                
            ref_image3 = imread('images/treesReference.png');
            ref_temp_image3 = rgb2gray(ref_image3);
            imageReference3 = im2double(ref_temp_image3);
                
            filtered1 = nonLocalMeans(imageNoisy1, 20/255, h, patchSize, windowSize);
            filtered2 = nonLocalMeans(imageNoisy2, 5/255, h, patchSize, windowSize);
            filtered3 = nonLocalMeans(imageNoisy3, 10/255, h, patchSize, windowSize);
            
            %Show difference image
            %Show the denoised image
            parameters = strcat('PatchSize: ',num2str(patchSize));
            parameters = strcat(parameters,' window size: ');
            parameters = strcat(parameters,num2str(windowSize));
            parameters = strcat(parameters,' h: ');
            parameters = strcat(parameters,num2str(h));
            
            index1 = strcat('Image 1:',parameters); 
            index2 = strcat('Image 2:',parameters);
            index3 = strcat('Image 3:',parameters);
            
            figure('name', strcat('NL-Means Denoised Image',index1));
            imshow(filtered1);
            diff_image1 = abs(imageNoisy1 - filtered1);
            figure('name', strcat('Difference Image',index1));
            imshow(diff_image1 / max(max((diff_image1))));

            figure('name', strcat('NL-Means Denoised Image',index2));
            imshow(filtered2);
            diff_image2 = abs(imageNoisy2 - filtered2);
            figure('name', strcat('Difference Image',index2));
            imshow(diff_image2 / max(max((diff_image2))));
            
            figure('name', strcat('NL-Means Denoised Image',index3));
            imshow(filtered3);
            diff_image3 = abs(imageNoisy3 - filtered3);
            figure('name', strcat('Difference Image',index3));
            imshow(diff_image3 / max(max((diff_image3))));
            
            index1
            %Print some statistics ((Peak) Signal-To-Noise Ratio)
            disp('For Noisy Input');
            [peakSNR, SNR] = psnr(imageNoisy1, imageReference1);
            disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

            disp('For Denoised Result');
            [peakSNR, SNR] = psnr(filtered1, imageReference1);
            disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);
            
            index2
            %Print some statistics ((Peak) Signal-To-Noise Ratio)
            disp('For Noisy Input');
            [peakSNR, SNR] = psnr(imageNoisy2, imageReference2);
            disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

            disp('For Denoised Result');
            [peakSNR, SNR] = psnr(filtered2, imageReference2);
            disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);
            
            index3
            %Print some statistics ((Peak) Signal-To-Noise Ratio)
            disp('For Noisy Input');
            [peakSNR, SNR] = psnr(imageNoisy3, imageReference3);
            disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

            disp('For Denoised Result');
            [peakSNR, SNR] = psnr(filtered3, imageReference3);
            disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);
            
        end
    end
end