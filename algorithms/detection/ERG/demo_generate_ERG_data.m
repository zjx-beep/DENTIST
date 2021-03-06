% 2020-3-29
% This matlab code implements the ERG model for infrared target-background 
% separation.


clc;
clear;
close all;

utilsPath = '../../../utils';
addpath(utilsPath);
addpath('../../../label');
addpath('../../../libs/PROPACK');


for setId = 8
    setImgNumArr = [3 75 75 75 75 5 32 3 1 114 30];
    setImgNum = setImgNumArr(setId);
    clear tarCube;
    tic;
    for imgId = 0:500%setImgNum
        img = get_infrared_img(setId, imgId, utilsPath); % double 0-255                                   
        [m,n] = size(img);
        
       %fix deadpoint for set_8
        img(173,97)=img(173,96);
        img(175,204)=img(175,205);
        img(175,201)=img(175,202);
        %fix deadpoint for set_6
        img(95,23)=img(96,23);
        img(224,25)=img(224,26);

        %done
        [ result_x,result_y,result_feature,path] = track_alg_path( img,n,m);
        a=max(max(path));
        b=min(min(path));
        path=(path-10)/(a-b);
        result=im2bw(path,0.6);
       imwrite(path,['./result',num2str(setId),'/',num2str(imgId),'.bmp']);
       imwrite(result,['./result',num2str(setId),'/',num2str(imgId),'.jpg']);
        %figure; imshow(result, []);
    end % imgId
    toc
end % setId