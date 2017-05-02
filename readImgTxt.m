function [images, digits] = readImgTxt(filename)
%readImgTxt reads images and corresponding digits from a text file 
% it returns a cell array with the image data in arrays, and a vector with
% the digits.

fileID = fopen(filename)

lineNum = 1

while lineNum < 22
    fgetl(fileID);
    lineNum = lineNum+1;
end

imgSize = 32;
images = cell(900,1);
digits = zeros(900,1);
imgNum = 1
imgRowNum = 1
tline = fgetl(fileID);
image = zeros(imgSize,imgSize);
while (tline ~= -1)
    imgRow = str2num(tline);
    image(imgRowNum,:) = imgRow;
    imgRowNum = imgRowNum+1;
    if(imgRowNum>imgSize)
        images{imgNum} = image;
        image = zeros(imgSize,imgSize);
        tline = fgetl(fileID);
        digits(imgNum) = str2num(tline);
        imgRowNum = 1;
        imgNum = imgNum+1;
    end
    tline = fgetl(fileID);
end
