function [] = getFFT(imname) 
im = imread(imname);
gray_image = rgb2gray(im);
result = imagesc(log(abs(fftshift(fft2(gray_image)))));
imshow(result)
end