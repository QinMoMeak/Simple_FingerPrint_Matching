clear all; clc; addpath(genpath(pwd));

%% EXTRACT FEATURES FROM AN ARBITRARY FINGERPRINT
filename='001_1.jpg';
img = imread(filename);
if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
disp(['Extracting features from ' filename ' ...']);
ffnew=ext_finger(img,1);

%% GET FEATURES OF AN ARBITRARY FINGERPRINT FROM THE TEMPLATE AND MATCH IT WITH FIRST ONE
load('db.mat'); i=1;
second=['00' num2str(fix((i-1)/8)+1) '_' num2str(mod(i-1,8)+1)];
third=['00' num2str(fix((i-1)/8)+1) '_' num2str(mod(i-1,8)+2)];
forth=['00' num2str(fix((i-1)/8)+1) '_' num2str(mod(i-1,8)+3)];
fifth=['00' num2str(fix((i-1)/8)+4) '_' num2str(mod(i-1,8)+2)];
sixth=['00' num2str(fix((i-1)/8)+5) '_' num2str(mod(i-1,8)+3)];
disp(['Calculating distance between ' filename ' and ' second '¡¢' third '¡¢' forth ' from FVC2002']);
S=match(ffnew,ff{i},ff{i+1},ff{i+2},ff{i+3},ff{i+4},1);
