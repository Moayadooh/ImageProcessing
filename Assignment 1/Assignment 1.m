function varargout = Assignment(varargin)
% ASSIGNMENT MATLAB code for Assignment.fig
%      ASSIGNMENT, by itself, creates a new ASSIGNMENT or raises the existing
%      singleton*.
%
%      H = ASSIGNMENT returns the handle to a new ASSIGNMENT or the handle to
%      the existing singleton*.
%
%      ASSIGNMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIGNMENT.M with the given input arguments.
%
%      ASSIGNMENT('Property','Value',...) creates a new ASSIGNMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Assignment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Assignment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Assignment

% Last Modified by GUIDE v2.5 19-Oct-2019 14:34:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Assignment_OpeningFcn, ...
                   'gui_OutputFcn',  @Assignment_OutputFcn, ...
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


% --- Executes just before Assignment is made visible.
function Assignment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Assignment (see VARARGIN)

% Choose default command line output for Assignment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Assignment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Assignment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
img = strcat(pathname, filename);
img = imread(img);
f = rgb2gray(img);
f = im2double(f);
[m n] = size(f);
c = 2;
y = 1.2;

if y > 0
    disp('bright input values into a wider range of output values');
else
    disp('dark input values into a wider range of output values');
end

for i = 1:m
for j = 1:n
s(i,j) = c*(f(i,j)^y);
end
end

delete(findall(findall(gcf,'Type','axe'),'Type','text'));
axes(handles.axes1);
imshow(f),title('Original Image');
axes(handles.axes4);
imhist(f),title('Histogram of Original Image');
axes(handles.axes2);
imshow(s),title('After Power-Law Transformation');
axes(handles.axes5);
imhist(s),title('Histogram After Power-Law Transformation');

cla(handles.axes3);
set(handles.axes3,'visible','off');
cla(handles.axes6);
set(handles.axes6,'visible','off');


function pushbutton2_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
img = strcat(pathname, filename);
img = imread(img);
A=rgb2gray(img);
axes(handles.axes1);
imshow(A),title('Orginal Image');
axes(handles.axes4);
imhist(A),title('Histogram of Original Image');

I1 = A;
I = zeros(size(A));
F1 = [0 1 0;
     1 -4 1;
     0 1 0];

A = padarray(A,[1,1]);
A = double(A);
for i = 1:size(A,1)-2
    for j = 1:size(A,2)-2
        I(i,j) = sum(sum(F1.*A(i:i+2,j:j+2))); 
   end
end
I = uint8(I);

axes(handles.axes2);
imshow(I),title('Filtered Image');
axes(handles.axes5);
imhist(I),title('Histogram of Filtered Image');
B = I1 - I;
axes(handles.axes3);
imshow(B),title('Sharpened Image');
axes(handles.axes6);
imhist(B),title('Histogram of Sharpened Image');


function pushbutton3_Callback(hObject, eventdata, handles)
delete(findall(findall(gcf,'Type','axe'),'Type','text'));

[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
f = strcat(pathname, filename);
f = imread(f);
g = rgb2gray(f);
g = im2double(g);
c = 6;
[M,N] = size(g);
        for x = 1:M
            for y = 1:N
                m = double(g(x,y));
                z(x,y) = c.*log10(1+m); 
            end
        end
        
axes(handles.axes1);
imshow(g),title('Orginal Image');
axes(handles.axes4);
imhist(g),title('Histogram of Orginal Image');
axes(handles.axes2);
imshow(z),title('After Logarithmic');
axes(handles.axes5);
imhist(z),title('Histogram After Logarithmic');

cla(handles.axes3);
set(handles.axes3,'visible','off');
cla(handles.axes6);
set(handles.axes6,'visible','off');

function pushbutton4_Callback(hObject, eventdata, handles)
delete(findall(findall(gcf,'Type','axe'),'Type','text'));

[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
h = strcat(pathname, filename);
h = imread(h);
h = rgb2gray(h);
axes(handles.axes1);
imshow(h),title('Orginal Image');
axes(handles.axes4);
imhist(h),title('Not Equalized Histogram');
h = histeq(h);
axes(handles.axes2);
imshow(h),title('After Histogram Equalization');
axes(handles.axes5);
imhist(h),title('Equalized Histogram');

cla(handles.axes3);
set(handles.axes3,'visible', 'off');
cla(handles.axes6);
set(handles.axes6,'visible', 'off');
