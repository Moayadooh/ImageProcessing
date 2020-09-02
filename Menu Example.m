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

% Last Modified by GUIDE v2.5 19-Nov-2019 22:15:38

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
function Select_Image_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
img = strcat(pathname, filename);
img = imread(img);
img_gray = rgb2gray(img);
axes(handles.axes1);
imshow(img),title('Original Image');
axes(handles.axes2);
imshow(img_gray),title('Grayscale Image');


% --------------------------------------------------------------------
function Add_Noise_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Add_Filter_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Find_Edges_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Robert_Kernel_Technique_Callback(hObject, eventdata, handles)
img_gray = getimage(handles.axes2);
if isempty(img_gray)
    message = msgbox('Please Select Image!!!');
    disp(message);
else
    I = double(img_gray); 
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

    img_gray(i,j) = sqrt(mx.^2+my.^2);
    end
    end
    robert_edge = img_gray;
    axes(handles.axes7);
    imshow(robert_edge);title('Robert-Kernel Technique');
end


% --------------------------------------------------------------------
function Laplacian_Kernel_Technique_Callback(hObject, eventdata, handles)
img_gray = getimage(handles.axes2);
if isempty(img_gray)
    message = msgbox('Please Select Image!!!');
    disp(message);
else
    I = double(img_gray); 
    for i=1:size(I,1)-2
    for j=1:size(I,2)-2
    %Negative Laplacian mask:
    % 0 -1  0
    %-1  4 -1
    % 0 -1  0
    img_gray(i,j) = ((4*I(i+1,j+1))-(I(i,j+1)+I(i+1,j)+I(i+2,j+1)+I(i+1,j+2)));
    end
    end
    
    laplacian_edge = img_gray;
    axes(handles.axes8);
    imshow(laplacian_edge);title('Laplacian-Kernel Technique');
end


% --------------------------------------------------------------------
function Salt_Pepper_Noise_Callback(hObject, eventdata, handles)
img_gray = getimage(handles.axes2);
if isempty(img_gray)
    message = msgbox('Please Select Image!!!');
    disp(message);
else
    salt_pepper = imnoise(img_gray,'salt & pepper');
    axes(handles.axes3);
    imshow(salt_pepper),title('Salt and Pepper Noise');
end


% --------------------------------------------------------------------
function Speckle_Noise_Callback(hObject, eventdata, handles)
img_gray = getimage(handles.axes2);
if isempty(img_gray)
    message = msgbox('Please Select Image!!!');
    disp(message);
else
    speckle = imnoise(img_gray,'speckle');
    axes(handles.axes5);
    imshow(speckle),title('Speckle Noise');
end


% --------------------------------------------------------------------
function Median_Filter_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Average_Filter_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Average_Salt_Pepper_Callback(hObject, eventdata, handles)
salt_pepper = getimage(handles.axes3);
if isempty(salt_pepper)
    message = msgbox('Please select image and add salt & pepper noise!!!');
    disp(message);
else
    I = double(salt_pepper); 
    for i=1:size(I,1)-2
    for j=1:size(I,2)-2
    %Calculate Average:
    Average = round((I(i,j)+I(i+1,j)+I(i+2,j)+I(i,j+1)+I(i+1,j+1)+I(i+2,j+1)+I(i,j+2)+I(i+1,j+2)+I(i+2,j+2))/9);
    salt_pepper(i,j) = Average;
    end
    end
    
    filtered_img = salt_pepper;
    axes(handles.axes4);
    imshow(filtered_img),title('Average Filter');
end


% --------------------------------------------------------------------
function Average_Speckle_Noise_Callback(hObject, eventdata, handles)
speckle = getimage(handles.axes5);
if isempty(speckle)
    message = msgbox('Please select image and add speckle noise!!!');
    disp(message);
else
    I = double(speckle); 
    for i=1:size(I,1)-2
    for j=1:size(I,2)-2
    %Calculate Average:
    Average = round((I(i,j)+I(i+1,j)+I(i+2,j)+I(i,j+1)+I(i+1,j+1)+I(i+2,j+1)+I(i,j+2)+I(i+1,j+2)+I(i+2,j+2))/9);
    speckle(i,j) = Average;
    end
    end
    
    filtered_img = speckle;
    axes(handles.axes6);
    imshow(filtered_img),title('Average Filter');
end


% --------------------------------------------------------------------
function Median_Salt_Pepper_Callback(hObject, eventdata, handles)
salt_pepper = getimage(handles.axes3);
if isempty(salt_pepper)
    message = msgbox('Please select image and add salt & pepper noise!!!');
    disp(message);
else
    I = double(salt_pepper); 
    for i=1:size(I,1)-2
    for j=1:size(I,2)-2
    %Find Median:
    Median = [I(i,j) I(i+1,j) I(i+2,j) I(i,j+1) I(i+1,j+1) I(i+2,j+1) I(i,j+2) I(i+1,j+2) I(i+2,j+2)];
    Median = sort(Median);
    Med = Median(5);
    salt_pepper(i,j) = Med;
    end
    end
    
    filtered_img = salt_pepper;
    axes(handles.axes4);
    imshow(filtered_img),title('Median Filter');
end


% --------------------------------------------------------------------
function Median_Speckle_Noise_Callback(hObject, eventdata, handles)
speckle = getimage(handles.axes5);
if isempty(speckle)
    message = msgbox('Please select image and add speckle noise!!!');
    disp(message);
else
    I = double(speckle); 
    for i=1:size(I,1)-2
    for j=1:size(I,2)-2
    %Find Median:
    Median = [I(i,j) I(i+1,j) I(i+2,j) I(i,j+1) I(i+1,j+1) I(i+2,j+1) I(i,j+2) I(i+1,j+2) I(i+2,j+2)];
    Median = sort(Median);
    Med = Median(5);
    speckle(i,j) = Med;
    end
    end
    
    filtered_img = speckle;
    axes(handles.axes6);
    imshow(filtered_img),title('Median Filter');
end
