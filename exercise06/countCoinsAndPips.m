% name : Pilar Navarro Ramírez
% student number : 3086150
function [numCoins, numPips] = countCoinsAndPips(I)
%COUNTCOINSANDPIPS counts coins and pips in the input image
%   [numCoins, numPips] = countCoinsAndPips(I) gets a grayscale input
%   image and returns the number of coins and pips on dominoes in the
%   image. Also a figure is opened, visualizing the found coins and dices.

I = imgaussfilt(I,1.2);
BW=edge(I,'Sobel');
[centersCoins, radiiCoins] = imfindcircles(BW,[120,500],'Sensitivity',0.95);
[centersPips, radiiPips] = imfindcircles(BW,[15,40],'Sensitivity',0.79,'EdgeThreshold',0.12);

numCoins = size(radiiCoins);
numCoins=numCoins(1);
numPips = size(radiiPips);
numPips=numPips(1);

figure;
imshow(I);
hold on;
viscircles(centersCoins, radiiCoins,'EdgeColor','b');
viscircles(centersPips, radiiPips,'EdgeColor','g');

end