function [] = main()
%% Change part number to test different part of this assignment
part = 3;
%% Part 0: Sharpen
if part == 0
    sigma = 10;
    alpha = 2;
    original = im2single(imread('Gugong.jpg'));
    lowFiltered = myGaussFilt(original, sigma);
    detail = original - lowFiltered;
    sharpened = original + alpha * detail;
    imwrite(sharpened, 'sharpenedGugong.jpg');
end
%% Part 1: Hybrid Images
if part == 1
    % read images and convert to single format
    im1 = im2single(imread('./funny.jpg'));
    im2 = im2single(imread('./cry.jpg'));
 %   im1 = rgb2gray(im1); % convert to grayscale
 %   im2 = rgb2gray(im2);
    
    % use this if you want to align the two images (e.g., by the eyes) and crop
    % them to be of same size
    [im2, im1] = align_images(im2, im1);
    % uncomment this when debugging hybridImage so that you don't have to keep aligning
    % keyboard; 

    cutoff_low = 3;
    cutoff_high = 4;
    im12 = hybridImage(im1, im2, cutoff_low, cutoff_high);
    imshow(im12);
%     %% Crop resulting image (optional)
%     figure(1), hold off, imagesc(im12), axis image, colormap gray
%     disp('input crop points');
%     [x, y] = ginput(2);  x = round(x); y = round(y);
%     im12 = im12(min(y):max(y), min(x):max(x), :);
%     figure(1), hold off, imagesc(im12), axis image, colormap gray

end
%% Part 2
if part == 2
    N = 4; % number of pyramid levels (you may use more or fewer, as needed)
    im12 = im2single(imread('./lincoln.jpg'));
    im12 = rgb2gray(im12);
    pyramids(im12, N);
end

%% Part 3
if part == 3
    im1 = im2single(imread('./apple.jpg'));
    im2 = im2single(imread('./orange.jpg'));
    im1 = rgb2gray(im1); % convert to grayscale
    im2 = rgb2gray(im2);
    mask = zeros(size(im1));
    mask(:, 1:size(im1, 2) / 2) = 1;
    blend(im1, im2, mask);
end
end

%% Implementations
function [result] = hybridImage(im1, im2, cutoff_low, cutoff_high)
im1r = im1(:, :, 1);
im1g = im1(:, :, 2);
im1b = im1(:, :, 3);

im2r = im2(:, :, 1);
im2g = im2(:, :, 2);
im2b = im2(:, :, 3);
lowPassedr = myGaussFilt(im1r, cutoff_low);
highPassedr = im2r - myGaussFilt(im2r, cutoff_high);
lowPassedg = myGaussFilt(im1g, cutoff_low);
highPassedg = im2g - myGaussFilt(im2g, cutoff_high);
lowPassedb = myGaussFilt(im1b, cutoff_low);
highPassedb = im2b - myGaussFilt(im2b, cutoff_high);
highPassed = cat(3, highPassedr, highPassedg, highPassedb);
lowPassed = cat(3, lowPassedr, lowPassedg, lowPassedb);
result = (lowPassed + highPassed) ./ 2;
end

function [] = pyramids(img, N)
i = 1;
sigma = 1;
currLow = img;
while i < N + 1
   figure(i);
   low = myGaussFilt(img, sigma);
   sigma = sigma * 2;
   imshow(currLow);
   figure(i + N);
   high = currLow - low;
   high = imadjust(high);
   currLow = low;
   imshow(high);
   i = i + 1;
end
end

function [] = blend(im1, im2, mask1)
mask2 = ones(size(mask1)) - mask1;
N = 5;
lowIm1 = im1;
lowIm2 = im2;
sigma = 1;
result = zeros(size(im1));
for a = 1:N
    low1 = myGaussFilt(im1, sigma);
    low2 = myGaussFilt(im2, sigma);
    tempMask1 = myGaussFilt(mask1, sigma);
    tempMask2 = myGaussFilt(mask2, sigma);
    sigma = sigma * 2;
    high1 = lowIm1 - low1;
    high2 = lowIm2 - low2;
    lowIm1 = low1;
    lowIm2 = low2;
    result = result + high1 .* tempMask1 + high2 .* tempMask2;
end
result = result + low1 .* tempMask1 + low2 .* tempMask2;
imshow(result);
end

%% Helper functions
function [f]= myGaussFilt(img, sigma)
f = conv2(img, gaussian2d(sigma), 'same');
end

function [f] = myGaussFiltRGB(img, sigma)
imgr = img(:, :, 1);
imgg = img(:, :, 2);
imgb = img(:, :, 3);
fr = conv2(imgr, gaussian2d(sigma), 'same');
fg = conv2(imgg, gaussian2d(sigma), 'same');
fb = conv2(imgb, gaussian2d(sigma), 'same');
f = cat(3, fr, fg, fb);
end

function [f] = gaussian2d(sigma)
N = sigma * 2;
[x, y] = meshgrid(round(-N/2):round(N/2), round(-N/2):round(N/2));
f = exp(-x.^2/(2*sigma^2) - y.^2 / (2*sigma^2));
f = f ./ sum(f(:));
end