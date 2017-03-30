function patchImg = gen_patchImg(img, patchSize, slideStep)

% 2017-03-25
% This matlab code generates the patch-image for infrared 
% patch-image model.
%
% Yimian Dai. Questions? yimian.dai@gmail.com
% Copyright: College of Electronic and Information Engineering, 
%            Nanjing University of Aeronautics and Astronautics


if ~exist('patchSize', 'var')
    patchSize = 50;
end

if ~exist('slideStep', 'var')
    slideStep = 10;
end

% img = reshape(1:9, [3 3])
% img = reshape(1:12, [3 4])
% patchSize = 2;
% slideStep = 1;
[imgHei, imgWid] = size(img);

rowPatchNum = ceil((imgHei - patchSize) / slideStep) + 1;
colPatchNum = ceil((imgWid - patchSize) / slideStep) + 1;
rowPosArr = [1 : slideStep : (rowPatchNum - 1) * slideStep, imgHei - patchSize + 1];
colPosArr = [1 : slideStep : (colPatchNum - 1) * slideStep, imgWid - patchSize + 1];

%% arrayfun version, identical to the following for-loop version
[meshCols, meshRows] = meshgrid(colPosArr, rowPosArr);
idx_fun = @(row,col) img(row : row + patchSize - 1, col : col + patchSize - 1);
patchCell = arrayfun(idx_fun, meshRows, meshCols, 'UniformOutput', false);
patchTen = cat(3, patchCell{:});
patchImg = reshape(patchTen, [patchSize^2, length(patchTen)]);

%% for-loop version
% patchImg = zeros(patchSize * patchSize, rowPatchNum * colPatchNum);
% k = 0;
% for col = colPosArr
%     for row = rowPosArr
%         k = k + 1;
%         tmp_patch = img(row : row + patchSize - 1, col : col + patchSize - 1);
%         patchImg(:, k) = tmp_patch(:);
%     end
% end

