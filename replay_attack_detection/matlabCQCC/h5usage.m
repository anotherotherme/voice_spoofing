clear; close all; clc;


a = [1,2,3];
b = [2,3,4,5,6];

h5create('myfile.h5','/DS1', [10 20])
mydata = rand(10,20);
h5write('myfile.h5', '/DS1', mydata)
h5create('myfile.h5','/DS2', [3])
h5write('myfile.h5', '/DS2', a)