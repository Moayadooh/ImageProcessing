function varargout = Compression(varargin)
% COMPRESSION MATLAB code for Compression.fig
%      COMPRESSION, by itself, creates a new COMPRESSION or raises the existing
%      singleton*.
%
%      H = COMPRESSION returns the handle to a new COMPRESSION or the handle to
%      the existing singleton*.
%
%      COMPRESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPRESSION.M with the given input arguments.
%
%      COMPRESSION('Property','Value',...) creates a new COMPRESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Compression_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Compression_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Compression

% Last Modified by GUIDE v2.5 25-Nov-2019 10:21:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Compression_OpeningFcn, ...
                   'gui_OutputFcn',  @Compression_OutputFcn, ...
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


% --- Executes just before Compression is made visible.
function Compression_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Compression (see VARARGIN)

% Choose default command line output for Compression
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Compression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Compression_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png';'*.tiff'},'File Selector');
file = strcat(pathname, filename);

img = imread(file);
axes(handles.axes1);
imshow(img),title('Original Image');

fileinfo = dir(file);
SIZE = fileinfo.bytes;
size = SIZE/1024;
set(handles.text1,'string',size);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, eventdata, handles)
I1 = getimage(handles.axes1);
I = I1(:,:,1);
I = im2double(I);
T = dctmtx(8);
B = blkproc(I,[8 8],'P1*x*P2',T,T');
mask = [1 1 1 1 0 0 0 0
        1 1 1 0 0 0 0 0
        1 1 0 0 0 0 0 0
        1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0];
B2 = blkproc(B,[8 8],'P1.*x',mask);
I2 = blkproc(B2,[8 8],'P1*x*P2',T',T);


G1 = I1(:,:,2);
I = im2double(G1);
T = dctmtx(8);
B = blkproc(I,[8 8],'P1*x*P2',T,T');
mask = [1 1 1 1 0 0 0 0
        1 1 1 0 0 0 0 0
        1 1 0 0 0 0 0 0
        1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0];
B2 = blkproc(B,[8 8],'P1.*x',mask);
I3 = blkproc(B2,[8 8],'P1*x*P2',T',T);


B1 = I1(:,:,3);
I = im2double(B1);
T = dctmtx(8);
B = blkproc(I,[8 8],'P1*x*P2',T,T');
mask = [1 1 1 1 0 0 0 0
        1 1 1 0 0 0 0 0
        1 1 0 0 0 0 0 0
        1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0];
B2 = blkproc(B,[8 8],'P1.*x',mask);
I4 = blkproc(B2,[8 8],'P1*x*P2',T',T);

L(:,:,:) = cat(3,I2, I3, I4);

axes(handles.axes2);
imshow(L),title('Compressed Image');
imwrite(L,'Compressed.jpg');
fileinfo = dir('Compressed.jpg');

SIZE = fileinfo.bytes;
size = SIZE/1024;
set(handles.text2,'string',size);
