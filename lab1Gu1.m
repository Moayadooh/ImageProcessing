function varargout = lab1Gu1(varargin)
% LAB1GU1 MATLAB code for lab1Gu1.fig
%      LAB1GU1, by itself, creates a new LAB1GU1 or raises the existing
%      singleton*.
%
%      H = LAB1GU1 returns the handle to a new LAB1GU1 or the handle to
%      the existing singleton*.
%
%      LAB1GU1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB1GU1.M with the given input arguments.
%
%      LAB1GU1('Property','Value',...) creates a new LAB1GU1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab1Gu1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab1Gu1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab1Gu1

% Last Modified by GUIDE v2.5 29-Oct-2019 15:24:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab1Gu1_OpeningFcn, ...
                   'gui_OutputFcn',  @lab1Gu1_OutputFcn, ...
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


% --- Executes just before lab1Gu1 is made visible.
function lab1Gu1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab1Gu1 (see VARARGIN)

% Choose default command line output for lab1Gu1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab1Gu1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab1Gu1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[baseFileName, folder] = uigetfile('*.*', 'Specify an image file');

% Create the full file name.
fullImageFileName = fullfile(folder, baseFileName);
im_original=imread(fullImageFileName );
%im_original=rgb2gray(im_original);
axes(handles.axes1);
imshow(im_original);
axis equal;
axis tight;
axis off;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
[x,y,z] = size(image);
imge = rgb2gray(image);
axes(handles.axes2);
imshow(imge);
axis equal;
axis tight;
axis off;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = getimage(handles.axes2);

I= double(X); 
for i=1:size(I,1)-2
for j=1:size(I,2)-2
%Sobel mask for x-direction:
mx=((2*I(i+2,j+1)+I(i+2,j)+I(i+2,j+2))-(2*I(i,j+1)+I(i,j)+I(i,j+2)));
%Sobel mask for y-direction:
my=((2*I(i+1,j+2)+I(i,j+2)+I(i+2,j+2))-(2*I(i+1,j)+I(i,j)+I(i+2,j)));
 
X(i,j)=sqrt(mx.^2+my.^2);
end
end

axes(handles.axes3);
imshow(X);title('Edge Gradient Image');
axis equal;
axis tight;
axis off;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = getimage(handles.axes3);
Thresh=100;
X=max(X,Thresh);
X(X==round(Thresh))=0;
X=uint8(X);
axes(handles.axes4);
imshow(~X);title('Edge detected Image');
axis equal;
axis tight;
axis off;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = getimage(handles.axes2);

I= double(X); 
for i=1:size(I,1)-2
for j=1:size(I,2)-2
%Prewitt mask for x-direction:
mx=((I(i+2,j+1)+I(i+2,j)+I(i+2,j+2))-(I(i,j+1)+I(i,j)+I(i,j+2)));
%Prewitt mask for y-direction:
my=((I(i+1,j+2)+I(i,j+2)+I(i+2,j+2))-(I(i+1,j)+I(i,j)+I(i+2,j)));
 
X(i,j)=sqrt(mx.^2+my.^2);
end
end
axes(handles.axes5);
imshow(X);title('Edge Gradient Image');
axis equal;
axis tight;
axis off;






% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = getimage(handles.axes5);
Thresh=100;
X=max(X,Thresh);
X(X==round(Thresh))=0;
X=uint8(X);
axes(handles.axes6);
imshow(~X);title('Edge detected Image');
axis equal;
axis tight;
axis off;