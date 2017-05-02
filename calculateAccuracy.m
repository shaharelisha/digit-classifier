function [accuracy, wrongMatches] = calculateAccuracy(numTestImages, matchingDigits, testDigits)
% Calculates the accuracy of the system as a fraction of the correctly 
% estimated test labels over the total number of test images. This function
% will also output a matrix of the wrong matches.
%
% Inputs
%   (int)    numTestImages    total number of test images
%   (vector) matchingDigits   estimated test labels
%   (vector) testDigits       actual test labels
%
% Outputs
%   (double) accuracy         fraction of correctly estimated test labels
%   (matrix) wrongMatches     first column is real labels, whereas second
%                             column lists estimated labels

    correctMatches = 0;
    i = 1;
    for x=1:numTestImages
        if testDigits(x) == matchingDigits(x)
            correctMatches = correctMatches + 1;
        else
            wrongMatches(i, :) = [testDigits(x) matchingDigits(x)];
            i = i + 1;
        end
    end
    accuracy = correctMatches/numTestImages;
