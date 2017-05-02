function matchingDigits = matchingDigitsCorr2(numTestImages,numTrainingImages,trainingImages,testImages,trainingDigits)
% Estimate the most likely label for each test image by matching with the 
% training image with the maximal correlation using corr2.
%
% Inputs
%   (int)    numTestImages      total number of test images
%   (int)    numTrainingImages  total number of training images
%   (vector) trainingImages     imageset of training images
%   (vector) testImages         imageset of test images
%   (vector) trainingDigits     labels of training images
%
% Outputs
%   (vector) matchingDigits     estimated test labels

    matchingDigits = zeros(numTestImages, 1);
    % iterate through each test image
    for i=1:numTestImages
        i % kept i to show progression (prints iteration number)
        maxCorrelation = -1;        % minimum correlation is -1
        testImg = testImages{i};
        % iterate through each training image
        for j=1:numTrainingImages
            trainingImg = trainingImages{j};
            
            % correlate each test image with each training image
            correlation = corr2(testImg, trainingImg);
            
            % if correlation is larger than stored maxCorrelation value, 
            % then reset maxCorrelation to current correlation value and
            % set closestMatch to the training image's label
            if maxCorrelation < correlation
                maxCorrelation = correlation;
                closestMatch = trainingDigits(j);
            end
        end
        % add the closestMatch label to the vector matchingDigits
        matchingDigits(i) = closestMatch;
    end