%clearing command line
clc;
%clearing all defined varibles
clear all;
%closing all plot windows etc.
close all;

%openning modules
tools;

path_to_folder = "../data/";

file_names = read_images(path_to_folder);

img = imread(strcat(path_to_folder, file_names{1}));
imshow(img);
