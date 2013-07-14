function varargout = Kmeans(varargin)
% KMEANS MATLAB code for Kmeans.fig
%      KMEANS, by itself, creates a new KMEANS or raises the existing
%      singleton*.
%
%      H = KMEANS returns the handle to a new KMEANS or the handle to
%      the existing singleton*.
%
%      KMEANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KMEANS.M with the given input arguments.
%
%      KMEANS('Property','Value',...) creates a new KMEANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Kmeans_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Kmeans_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Kmeans

% Last Modified by GUIDE v2.5 23-Oct-2012 13:55:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Kmeans_OpeningFcn, ...
                   'gui_OutputFcn',  @Kmeans_OutputFcn, ...
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


% --- Executes just before Kmeans is made visible.
function Kmeans_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kmeans (see VARARGIN)

% Choose default command line output for Kmeans
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Kmeans wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Kmeans_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global k Img g_matrix c count;
count = 0;
[temp_img,g_matrix,c]= K_means_Begin(Img,k);
axes(handles.axes2);
imshow(uint8(temp_img));
set(handles.Time,'String',''); 
set(handles.Iterations,'String',count); 

% --- Executes on button press in Step.
function Step_Callback(hObject, eventdata, handles)
% hObject    handle to Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global k Img g_matrix c count ;
% global ImgName;
count = count + 1; 
[temp_img,g_matrix,c]= K_means_Step(Img,k,c,g_matrix);
axes(handles.axes2);
imshow(uint8(temp_img));
set(handles.Iterations,'String',count); 
% name = strcat(ImgName,'_result.jpg');
% imwrite(uint8(temp_img),name);

% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Img k ImgName;
[time, count,m] = K_means_Run(Img,k);
axes(handles.axes2);
imshow(uint8(m));
set(handles.Iterations,'String',count);
set(handles.Time,'String',time);
name = strcat(ImgName,'_result.jpg');
imwrite(uint8(m),name);

% --- Executes on button press in ImageSelection.
function ImageSelection_Callback(hObject, eventdata, handles)
% hObject    handle to ImageSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Img ImgName;
set(handles.No_Cluster,'String','');
set(handles.Iterations,'String','');
set(handles.Time,'String','');
[ImgName, ImgDir] = uigetfile('*.jpg;*.tif;*.png;*.gif;*.tiff', 'Select the Image File');
Img = strcat(ImgDir,ImgName);
axes(handles.axes1);
imshow(Img);
Img = imread(Img);


function Time_Callback(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time as text
%        str2double(get(hObject,'String')) returns contents of Time as a double


% --- Executes during object creation, after setting all properties.
function Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Iterations_Callback(hObject, eventdata, handles)
% hObject    handle to Iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Iterations as text
%        str2double(get(hObject,'String')) returns contents of Iterations as a double


% --- Executes during object creation, after setting all properties.
function Iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function No_Cluster_Callback(hObject, eventdata, handles)
% hObject    handle to No_Cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of No_Cluster as text
%        str2double(get(hObject,'String')) returns contents of No_Cluster as a double
global k;
k = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function No_Cluster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to No_Cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key release with focus on figure1 and none of its controls.
function figure1_KeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)
