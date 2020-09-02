function varargout = Project(varargin)
% PROJECT MATLAB code for Project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project

% Last Modified by GUIDE v2.5 12-Dec-2019 08:45:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_OutputFcn, ...
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


% --- Executes just before Project is made visible.
function Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project (see VARARGIN)

% Choose default command line output for Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


clc;
global OriginalImageSize;
global CompressedImageSize;
while(1)
    dlgtitle = 'Enter your choice:';
    prompt = sprintf("1 - Select Image\n2 - Low Compression Test\n3 - High Compression Test\n4 - Compress Students Photographs\n5 - Exit");
    dims = [1 50];
    value = inputdlg(prompt,dlgtitle,dims);
    choice = str2double(value);
    switch choice
        case 1
            [filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
            file = strcat(pathname, filename);
            if isempty(file)
                clc;
                continue;
            end
            img = imread(file);
            axes(handles.axes1);
            imshow(img);
            OriginalImageSize = CalSize(file);
            OriginalImageSize = round(OriginalImageSize,1);
            set(handles.text1,'string',"Image size: "+OriginalImageSize+" KB");
            axes(handles.axes2);
            imhist(img);
            cla(handles.axes3,'reset');
            cla(handles.axes4,'reset');
            cla(handles.axes5,'reset');
            cla(handles.axes6,'reset');
            set(handles.text2,'string',"");
            set(handles.text6,'string',"");
            set(handles.text3,'string',"");
            set(handles.text7,'string',"");
            set(handles.text23,'string',"");
            set(handles.text24,'string',"");
            
        case 2
            img = getimage(handles.axes1);
            if isempty(img)
                uiwait(msgbox('Please Select Image!!!','','modal'));
                continue;
            end
            img = imresize(img,[1048 1048]);
            compressedImage = DCT(img);
            compressedImage = imresize(compressedImage,[264 264]);
            axes(handles.axes3);
            imshow(compressedImage);
            imwrite(compressedImage,'Compressed.jpg');
            CompressedImageSize = CalSize('Compressed.jpg');
            CompressedImageSize = round(CompressedImageSize,1);
            set(handles.text2,'string',"Image size: "+CompressedImageSize+" KB");
            CR = OriginalImageSize/CompressedImageSize;
            CR = round(CR,2);
            set(handles.text6,'string',"Compression Ratio: "+CR);
            RD = 1 - (1/CR);
            RD = RD * 100;
            RD = round(RD,2);
            set(handles.text23,'string',"Relative Data Redundancy: "+RD+"%");
            axes(handles.axes4);
            img = imread('Compressed.jpg');
            imhist(img);
            
        case 3
            img = getimage(handles.axes1);
            if isempty(img)
                uiwait(msgbox('Please Select Image!!!','','modal'));
                continue;
            end
            img = imresize(img,[1048 1048]);
            compressedImage = LBG(img);
            compressedImage = imresize(compressedImage,[264 264]);
            axes(handles.axes5);
            imshow(compressedImage);
            imwrite(compressedImage,'Compressed.jpg');
            CompressedImageSize = CalSize('Compressed.jpg');
            CompressedImageSize = round(CompressedImageSize,1);
            set(handles.text3,'string',"Image size: "+CompressedImageSize+" KB");
            CR = OriginalImageSize/CompressedImageSize;
            CR = round(CR,2);
            set(handles.text7,'string',"Compression Ratio: "+CR);
            RD = 1 - (1/CR);
            RD = RD * 100;
            RD = round(RD,2);
            set(handles.text24,'string',"Relative Data Redundancy: "+RD+"%");
            axes(handles.axes6);
            img = imread('Compressed.jpg');
            imhist(img);
            
        case 4
            while(1)
                dlgtitle = 'Images Type:';
                prompt = sprintf("1 - JPG\n2 - BMP\n3 - PNG\n4 - TIFF\n5 - Cancel Progress");
                dims = [1 50];
                value = inputdlg(prompt,dlgtitle,dims);
                c = str2double(value);
                if c ==1
                    type = 'JPG';
                    break;
                elseif c ==2
                    type = 'BMP';
                    break;
                elseif c ==3
                    type = 'PNG';
                    break;
                elseif c ==4
                    type = 'TIFF';
                    break;
                elseif c ==5
                    break;
                else
                    uiwait(msgbox('Please Enter correct choice!!','','modal'));
                    continue;
                end
            end
            if c == 5
                continue;
            end
            
            while(1)
                dlgtitle = 'Compression Type:';
                prompt = sprintf("1 - Low Compression\n2 - High Compression\n3 - Cancel Progress");
                dims = [1 50];
                value = inputdlg(prompt,dlgtitle,dims);
                t = str2double(value);
                if t ==1
                    break;
                elseif t ==2
                    break;
                elseif t ==3
                    break;
                else
                    uiwait(msgbox('Please Enter correct choice!!','','modal'));
                    continue;
                end
            end
            if t == 3
                continue;
            end
            
            dir_path = 'C:\Users\moaya\Documents\MATLAB\Workspace\Project\Students Images\';
            dir_path = strcat(dir_path,'\');
            dirpath = strcat(dir_path,['*.' type]);
            files = dir(dirpath);
            file_names={files.name};
            sf=size(file_names);
            OriginalImage= 0;
            CompressedImage = 0;
            for i=1:sf(2)
                fprintf('Image %d is in progress...\n',i);
                s1 = strcat(dir_path,char(file_names{i}));
                M = imread(s1);
                M = Laplacian_sharpening(M);
                M = Filtering(M);
                if t==1
                    M = imresize(M,[1048 1048]);
                    M = DCT(M);
                    M = imresize(M,[264 264]);
                else
                    M = imresize(M,[1048 1048]);
                    M = LBG(M);
                    M = imresize(M,[264 264]);
                    M = pwr_law_transformation(M);
                    M = logarithmic(M);
                end
                BW = im2bw(M,0.5);
                s2 = strcat(['C:\Users\moaya\Documents\MATLAB\Workspace\Project\Compressed Images\'],char(file_names{i}));
                imwrite(M,s2,type);
                s3 = strcat(['C:\Users\moaya\Documents\MATLAB\Workspace\Project\Compressed Black and White Images\'],char(file_names{i}));
                imwrite(BW,s3,type);
                OriginalImage = OriginalImage + CalSize(s1);
                CompressedImage = CompressedImage + CalSize(s2);
            end
            
            if OriginalImage ~= 0
                CR = OriginalImage / CompressedImage;
                OriginalImage = round(OriginalImage,1);
                CompressedImage = round(CompressedImage,1);
                CR = round(CR,2);
                RD = 1 - (1/CR);
                RD = RD * 100;
                RD = round(RD,2);
                disp('Images has been compressed successfuly.');
                fprintf('\nTotal size of the original images is:  %.1f KB',OriginalImage);
                fprintf('\nTotal size of the compressed images is:  %.1f KB\n',CompressedImage);
                fprintf('Compression Ratio: %.2f',CR);
                fprintf('\nRelative Data Redundancy: %.2f%%\n\n',RD);
            else
                uiwait(msgbox(['There are no ' type ' images in this folder!!'],'','modal'));
            end
            
        case 5
            break;
        otherwise
            uiwait(msgbox('Please Enter correct choice!!','','modal'));
    end
end
disp('The Application is Closed!!');
close all;
