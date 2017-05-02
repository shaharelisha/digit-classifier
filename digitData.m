%% Load training and test datasets into Matlab workspace

[testImages, testDigits] = readImgTxt('test.txt');  % test imageset

[trainingImages, trainingDigits] = readImgTxt('training.txt'); % training imageset

numTestImages = size(testImages, 1);    % size of test imageset
numTrainingImages = size(trainingImages, 1);    % size of training imageset

%% Estimate most likely label using corr2

matchingDigits = matchingDigitsCorr2(numTestImages,numTrainingImages, ...
    trainingImages,testImages,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyCorr2, wrongMatchesCorr2] = calculateAccuracy(numTestImages, ...
    matchingDigits, testDigits);

%% Estimate most likely label using xcorr2

matchingDigits = matchingDigitsXcorr2(numTestImages,numTrainingImages,...
    trainingImages,testImages,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyXcorr2, wrongMatchesXcorr2] = calculateAccuracy(numTestImages, ...
    matchingDigits, testDigits);

%% Create training and test imagesets of the negatives

% new imageset for negatives of test images
for i=1:numTestImages
    testImg = testImages{i};
    testImg = imcomplement(testImg);
    testImagesNegatives{i} = testImg;
end
% new imageset for negatives of training images
for j=1:numTrainingImages
    trainingImg = trainingImages{j};
    trainingImg = imcomplement(trainingImg);
    trainingImagesNegatives{j} = trainingImg;
end

%% Estimate most likely label using corr2 - negatives

matchingDigits = matchingDigitsCorr2(numTestImages,numTrainingImages, ...
    trainingImagesNegatives,testImagesNegatives,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyCorr2Negatives, wrongMatchesCorr2Negatives] = calculateAccuracy(...
    numTestImages, matchingDigits, testDigits);

%% Estimate most likely label using xcorr2 - negatives

matchingDigits = matchingDigitsXcorr2(numTestImages,numTrainingImages, ...
    trainingImagesNegatives,testImagesNegatives,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyXcorr2Negatives, wrongMatchesXcorr2Negatives] = ...
    calculateAccuracy(numTestImages, matchingDigits, testDigits);

%% Create training imageset with added noise

for j=1:numTrainingImages
    trainingImg = trainingImages{j};
    trainingImg = imnoise(trainingImg);
    trainingImagesNoise{j} = trainingImg;
end

%% Estimate most likely label using corr2 - noise

matchingDigits = matchingDigitsCorr2(numTestImages,numTrainingImages, ...
    trainingImagesNoise,testImages,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyCorr2Noise, wrongMatchesCorr2Noise] = calculateAccuracy(...
    numTestImages, matchingDigits, testDigits);

%% Estimate most likely label using xcorr2 - noise

matchingDigits = matchingDigitsXcorr2(numTestImages,numTrainingImages, ...
    trainingImagesNoise,testImages,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyXcorr2Noise, wrongMatchesXcorr2Noise] = calculateAccuracy(...
    numTestImages, matchingDigits, testDigits);

%% Create training imageset with rotated images

for j=1:numTrainingImages
    trainingImg = trainingImages{j};
    % rotate image by 20 degrees and crop to original size
    trainingImg = imrotate(trainingImg, 20, 'nearest', 'crop');
    trainingImagesRotated{j} = trainingImg;
end

%% Estimate most likely label using corr2 - rotated

matchingDigits = matchingDigitsCorr2(numTestImages,numTrainingImages, ...
    trainingImagesRotated,testImages,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyCorr2Rotated, wrongMatchesCorr2Rotated] = calculateAccuracy(...
    numTestImages, matchingDigits, testDigits);

%% Estimate most likely label using xcorr2 - rotated

matchingDigits = matchingDigitsXcorr2(numTestImages,numTrainingImages, ...
    trainingImagesRotated,testImages,trainingDigits);
% calculate accuracy and list wrong matches
[accuracyXcorr2Rotated, wrongMatchesXcorr2Rotated] = calculateAccuracy(...
    numTestImages, matchingDigits, testDigits);
