function varargout = Assignment2(varargin)
% ASSIGNMENT2 MATLAB code for Assignment2.fig
%      ASSIGNMENT2, by itself, creates a new ASSIGNMENT2 or raises the existing
%      singleton*.
%
%      H = ASSIGNMENT2 returns the handle to a new ASSIGNMENT2 or the handle to
%      the existing singleton*.
%
%      ASSIGNMENT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIGNMENT2.M with the given input arguments.
%
%      ASSIGNMENT2('Property','Value',...) creates a new ASSIGNMENT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Assignment2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Assignment2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Assignment2

% Last Modified by GUIDE v2.5 21-Nov-2019 07:51:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Assignment2_OpeningFcn, ...
                   'gui_OutputFcn',  @Assignment2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Assignment2 is made visible.
function Assignment2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Assignment2 (see VARARGIN)

% Choose default command line output for Assignment2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Assignment2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Assignment2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
clc;
while(1)
    disp('Enter your choice:');
    disp('1 - Select Image');
    disp('2 - Add Noise');
    disp('3 - Add Filter');
    disp('4 - Find Edges');
    disp('5 - Exit');
    choice = input('');
    switch choice
        case 1
            [filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
            img = strcat(pathname, filename);
            if isempty(img)
                clc;
                continue;
            end
            img = imread(img);
            img_gray = rgb2gray(img);
            axes(handles.axes1);
            imshow(img),title('Original Image');
            axes(handles.axes2);
            imshow(img_gray),title('Grayscale Image');
            cla(handles.axes3,'reset');
            cla(handles.axes4,'reset');
            cla(handles.axes5,'reset');
            clc;
            
        case 2
            clc;
            while(1)
                img_gray = getimage(handles.axes2);
                if isempty(img_gray)
                    message = msgbox('Please Select Image!!!');
                    disp(message);
                    clc;
                    break;
                end
                disp('Enter your choice:');
                disp('Type of Noise :');
                disp('1 - Speckle Noise');
                disp('2 - Salt and Pepper Noise');
                disp('3 - Back');
                type = input('');
                switch type
                    case 1
                        speckle = imnoise(img_gray,'speckle');
                        axes(handles.axes3);
                        imshow(speckle),title('Speckle Noise');
                        clc;
                        cla(handles.axes4,'reset');
                        cla(handles.axes5,'reset');
                        break;
                    case 2
                        salt_pepper = imnoise(img_gray,'salt & pepper');
                        axes(handles.axes3);
                        imshow(salt_pepper),title('Salt and Pepper Noise');
                        clc;
                        cla(handles.axes4,'reset');
                        cla(handles.axes5,'reset');
                        break;
                    case 3
                        clc;
                        break;
                    otherwise
                        clc;
                        message = msgbox('Please Enter correct choice!!!');
                        disp(message);
                end
            end
            
        case 3
            clc;
            while(1)
                noise_img = getimage(handles.axes3);
                if isempty(noise_img)
                    message = msgbox('Please select image and add noise to it!!!');
                    disp(message);
                    clc;
                    break;
                end
                disp('Enter your choice:');
                disp('Filter Technique :');
                disp('1 - Average Filter');
                disp('2 - Median Filter');
                disp('3 - Back');
                type = input('');
                switch type
                    case 1
                        I = double(noise_img); 
                        for i=1:size(I,1)-2
                        for j=1:size(I,2)-2
                        %Calculate Average:
                        Average = round((I(i,j)+I(i+1,j)+I(i+2,j)+I(i,j+1)+I(i+1,j+1)+I(i+2,j+1)+I(i,j+2)+I(i+1,j+2)+I(i+2,j+2))/9);
                        noise_img(i,j) = Average;
                        end
                        end

                        filtered_img = noise_img;
                        axes(handles.axes4);
                        imshow(filtered_img),title('Average Filter');
                        clc;
                        cla(handles.axes5,'reset');
                        break;
                    case 2
                        I = double(noise_img); 
                        for i=1:size(I,1)-2
                        for j=1:size(I,2)-2
                        %Find Median:
                        Median = [I(i,j) I(i+1,j) I(i+2,j) I(i,j+1) I(i+1,j+1) I(i+2,j+1) I(i,j+2) I(i+1,j+2) I(i+2,j+2)];
                        Median = sort(Median);
                        Med = Median(5);
                        noise_img(i,j) = Med;
                        end
                        end

                        filtered_img = noise_img;
                        axes(handles.axes4);
                        imshow(filtered_img),title('Median Filter');
                        clc;
                        cla(handles.axes5,'reset');
                        break;
                    case 3
                        clc;
                        break;
                    otherwise
                        clc;
                        message = msgbox('Please Enter correct choice!!!');
                        disp(message);
                end
            end
            
        case 4
            clc;
            while(1)
                filtered_img = getimage(handles.axes4);
                if isempty(filtered_img)
                    message = msgbox('Please select image and add filter to it!!!');
                    disp(message);
                    clc;
                    break;
                end
                disp('Enter your choice:');
                disp('Edge Detection Technique :');
                disp('1 - Robert Technique');
                disp('2 - Laplacian Technique');
                disp('3 - Back');
                type = input('');
                switch type
                    case 1
                        I = double(filtered_img); 
                        for i=1:size(I,1)-2
                        for j=1:size(I,2)-2
                        %Robert mask for Gradient of x:
                        % 1  0
                        % 0 -1
                        mx = 1*I(i,j)-1*I(i+1,j+1);

                        %Robert mask for Gradient of y:
                        % 0  1
                        %-1  0
                        my = -1*I(i,j+1)+1*I(i+1,j);

                        filtered_img(i,j) = sqrt(mx.^2+my.^2);
                        end
                        end
                        robert_edge = filtered_img;
                        axes(handles.axes5);
                        imshow(robert_edge);title('Robert Edge Detection');
                        clc;
                        break;
                    case 2
                        I = double(filtered_img); 
                        for i=1:size(I,1)-2
                        for j=1:size(I,2)-2
                        %Negative Laplacian mask:
                        % 0 -1  0
                        %-1  4 -1
                        % 0 -1  0
                        filtered_img(i,j) = ((4*I(i+1,j+1))-(I(i,j+1)+I(i+1,j)+I(i+2,j+1)+I(i+1,j+2)));
                        end
                        end

                        laplacian_edge = filtered_img;
                        axes(handles.axes5);
                        imshow(laplacian_edge);title('Laplacian Edge Detection');
                        clc;
                        break;
                    case 3
                        clc;
                        break;
                    otherwise
                        clc;
                        message = msgbox('Please Enter correct choice!!!');
                        disp(message);
                end
            end
            
        case 5
            break;
        otherwise
            clc;
            message = msgbox('Please Enter correct choice!!!');
            disp(message);
    end
end
clc;
disp('Application Closed!');
clear all;
close all;
