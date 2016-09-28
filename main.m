function [] = main()
%% Change part number to test different part of this assignment
part = 1;
%% Part 0: Sharpen
if part == 0
    sigma = 10;
    alpha = 2;
    original = imread('Gugong.jpg');
    lowFiltered = imgaussfilt(original, sigma);
    detail = original - lowFiltered;
    sharpened = original + alpha * detail;
    imwrite(sharpened, 'sharpenedGugong.jpg');
end
%% Part 1: Hybrid Images
if part == 1
    % read images and convert to single format
    im1 = im2single(imread('./cat.jpg'));
    im2 = im2single(imread('./tiger.jpg'));
%    im1 = rgb2gray(im1); % convert to grayscale
%    im2 = rgb2gray(im2);
    
    % use this if you want to align the two images (e.g., by the eyes) and crop
    % them to be of same size
    [im2, im1] = align_images(im2, im1);
    % uncomment this when debugging hybridImage so that you don't have to keep aligning
    % keyboard; 

    cutoff_low = 5;
    cutoff_high = 3; 
    im12 = hybridImage(im1, im2, cutoff_low, cutoff_high);
    imshow(im12);

%     %% Crop resulting image (optional)
%     figure(1), hold off, imagesc(im12), axis image, colormap gray
%     disp('input crop points');
%     [x, y] = ginput(2);  x = round(x); y = round(y);
%     im12 = im12(min(y):max(y), min(x):max(x), :);
%     figure(1), hold off, imagesc(im12), axis image, colormap gray

    % %% Compute and display Gaussian and Laplacian Pyramids (you need to supply this function)
    % N = 5; % number of pyramid levels (you may use more or fewer, as needed)
    % pyramids(im12, N);

end
end

%% hybrid Image implementation
function [result] = hybridImage(im1, im2, cutoff_low, cutoff_high)
lowPassed = imgaussfilt(im1, cutoff_low);
highPassed = im2 - imgaussfilt(im2, cutoff_high);

result = (lowPassed + highPassed) ./ 2;
end