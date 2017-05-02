function matchingDigits = matchingDigitsXcorr2(numTestImages,numTrainingImages,trainingImages,testImages,trainingDigits)
% Estimate the most likely label for each test image by matching with the 
% training image with the maximal correlation using xcorr2.
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
        i  % kept i to show progression (prints iteration number)
        imagesetMax = 0;        % minimum correlation is 0
        testImg = testImages{i};
        % iterate through each training image
        for j=1:numTrainingImages
            trainingImg = trainingImages{j};
            
            % correlate each test image with each training image at all
            % offsets
            xc = xcorr2(testImg, trainingImg);
            currentMax = max(xc(:));       % max correlation of all offsets
            
            % if correlation is larger than stored imagesetMax value, 
            % then reset imagesetMax to current correlation value and
            % set closestMatch to the training image's label
            if imagesetMax < currentMax
                imagesetMax = currentMax;
                closestMatch = trainingDigits(j);
            end

        end
        % add the closestMatch label to the vector matchingDigits
        matchingDigits(i) = closestMatch;
    end