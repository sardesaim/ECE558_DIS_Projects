function varargout = Blend(varargin)
% BLEND MATLAB code for Blend.fig
%      BLEND, by itself, creates a new BLEND or raises the existing
%      singleton*.
%
%      H = BLEND returns the handle to a new BLEND or the handle to
%      the existing singleton*.
%
%      BLEND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BLEND.M with the given input arguments.
%
%      BLEND('Property','Value',...) creates a new BLEND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Blend_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Blend_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Blend

% Last Modified by GUIDE v2.5 13-Nov-2019 11:25:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Blend_OpeningFcn, ...
                   'gui_OutputFcn',  @Blend_OutputFcn, ...
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

% --- Executes just before Blend is made visible.
function Blend_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Blend (see VARARGIN)

% Choose default command line output for Blend
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Blend.
if strcmp(get(hObject,'Visible'),'off')
%     plot(rand(5));
end

% UIWAIT makes Blend wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Blend_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end
% --- Executes on button press in Img1.
% --- read images selected by the user 
function Img1_Callback(hObject, eventdata, handles)
% hObject    handle to Img1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [img1, path1, ~] = uigetfile('*.jpg; *.png; *.jpeg', 'Pick a source image');
    if ~isequal(img1, 0)
        fg = im2double(imread(horzcat(path1,img1)));
    end
    axes(handles.Source);
    cla;
    fg1 = fg;
    hObject.UserData = fg;
    imshow(fg)
    
% --- Executes on button press in Img2.
% --- read images selected by the user 
function Img2_Callback(hObject, eventdata, handles)
% hObject    handle to Img2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [img2, path2, ~] = uigetfile('*.jpg; *.png; *.jpeg', 'Pick a source image');
    if ~isequal(img2, 0)
        bg = im2double(imread(horzcat(path2,img2)));
    end
    axes(handles.Target);
    cla;
    imshow(bg)
    hObject.UserData = bg;

% --- Executes during object creation, after setting all properties.
function Img2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Img2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Rect.
% --- select rectangular ROI 
function Rect_Callback(hObject, eventdata, handles)
% hObject    handle to Rect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    el = findobj('Tag', 'Ellipse');
    fr = findobj('Tag', 'FreeHnd');
    crt = findobj('Tag', 'DrawROI');
    axes(handles.Source);
    try
        roi = crt.UserData{3};
        delete(roi);
    catch
    end
    el.Value=0;
    fr.Value=0;

    
% --- Executes on button press in Ellipse.
% --- select elliptical ROI 
function Ellipse_Callback(hObject, eventdata, handles)
% hObject    handle to Ellipse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    re = findobj('Tag', 'Rect');
    fr = findobj('Tag', 'FreeHnd');
    crt = findobj('Tag', 'DrawROI');
    axes(handles.Source);
    try
        roi = crt.UserData{3};
        delete(roi);
    catch
    end
    re.Value=0;
    fr.Value=0;
    
% --- Executes on button press in FreeHnd.
% --- select freehand ROI 
function FreeHnd_Callback(hObject, eventdata, handles)
% hObject    handle to FreeHnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    re = findobj('Tag', 'Rect');
    el = findobj('Tag', 'Ellipse');
    crt = findobj('Tag', 'DrawROI');
    axes(handles.Source);
    try
        roi = crt.UserData{3};
        delete(roi);
    catch
    end
    re.Value=0;
    el.Value=0;
     
% --- Executes on button press in Blnd.
% --- Blend the selected images based on selected ROI 
function Blnd_Callback(hObject, eventdata, handles)
% hObject    handle to Blnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h1 = findobj('Tag', 'Img1');
    h2 = findobj('Tag', 'Img2');
    nl = findobj('Tag', 'nlayers');
    msk = findobj('Tag', 'DrawROI');
    trg = findobj('Tag', 'SetTrgtLocn');
    bg = h2.UserData;
    try
        fg1 = trg.UserData{1};
        bw_mask = trg.UserData{2};
    catch
        fg1 = msk.UserData{1};
        bw_mask = msk.UserData{2};
    end
    %handle RGB images. 
    if size(bg,3)>1
        blendedImg(:,:,1) = blendPyramid(fg1(:,:,1),bg(:,:,1),bw_mask,str2double(nl.String));
        blendedImg(:,:,2) = blendPyramid(fg1(:,:,2),bg(:,:,2),bw_mask,str2double(nl.String));
        blendedImg(:,:,3) = blendPyramid(fg1(:,:,3),bg(:,:,3),bw_mask,str2double(nl.String));
    else
        blendedImg(:,:,1) = blendPyramid(fg1(:,:,1),bg(:,:,1),bw_mask,str2double(nl.String));
    end
%     blendedImg = ScaleRGBValues(blendedImg);
    axes(handles.Source);                                   
    imshow(h1.UserData);
    axes(handles.Target);
    imshow(bg);
    axes(handles.Outputs);
    imshow(blendedImg);
    imwrite(blendedImg, 'blend.png');

% --- Executes on button press in SetTrgtLocn.
function SetTrgtLocn_Callback(hObject, eventdata, handles)
% hObject    handle to SetTrgtLocn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    droi = findobj('Tag', 'DrawROI');
    fgp = droi.UserData{1};
    bwm = droi.UserData{2};
    src = findobj('Tag', 'SetSrcLocn');
    axes(handles.Target);
    trgtLoc = drawrectangle();
    trgtPos = trgtLoc.Position;
    try
        srcPos = src.UserData;
        transVec = trgtPos(1:2)-srcPos(1:2);
    catch
        transVec = [0,0];    
    end
    %translate image to location selected by the user. 
    fgp=imtranslate(fgp, transVec);
    bwm = imtranslate(bwm, transVec);
    axes(handles.Source);
    imshow(fgp);
    axes(handles.Outputs);
    imshow(bwm);
    hObject.UserData{1} = fgp;
    hObject.UserData{2} = bwm;
    imwrite(bwm, 'mask.png');
    imwrite(fgp, 'fgPadded.png');
    delete(trgtLoc);

% --- Executes on button press in SetSrcLocn.
function SetSrcLocn_Callback(hObject, eventdata, handles)
% hObject    handle to SetSrcLocn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    axes(handles.Source);
    srcLoc = drawrectangle();
    srcPos = srcLoc.Position;
    hObject.UserData = srcPos;
    delete(srcLoc);
    
function nlayers_Callback(hObject, eventdata, handles)
% hObject    handle to nlayers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nlayers as text
%        str2double(get(hObject,'String')) returns contents of nlayers as a double

% --- Executes during object creation, after setting all properties.
function nlayers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nlayers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DrawROI.
% --- draw ROI based on selected region type 

function DrawROI_Callback(hObject, eventdata, handles)
% hObject    handle to DrawROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h1 = findobj('Tag', 'Img1');
    h2 = findobj('Tag', 'Img2');
    re = findobj('Tag', 'Rect');
    el = findobj('Tag', 'Ellipse');
    fr = findobj('Tag', 'FreeHnd');
    src = findobj('Tag', 'SetSrcLocn');
    trg = findobj('Tag', 'SetTrgtLocn');
    fg1 = trg.UserData;
    if isempty(fg1)
        fg1 = h1.UserData;
    end
    bg = h2.UserData; 
    axes(handles.Source);
    if re.Value == 1 && el.Value == 0 && fr.Value == 0
        [fg1, roi, bw_mask] = createROIMask(fg1, bg, 1);
    elseif re.Value == 0 && el.Value == 1 && fr.Value == 0
        [fg1, roi, bw_mask] = createROIMask(fg1, bg, 2);
    else
        [fg1, roi, bw_mask] = createROIMask(fg1, bg, 3);
    end
    axes(handles.Outputs);
    imshow(bw_mask);
    axes(handles.Source);
    imshow(fg1);
    imwrite(bw_mask, 'mask.png');
    imwrite(fg1, 'fgPadded.png');
    hObject.UserData{1} = fg1;
    hObject.UserData{2} = bw_mask;
    hObject.UserData{3} = roi;


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(Blend);
    run('Blend');
