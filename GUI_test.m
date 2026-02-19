
function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the

%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 23-Feb-2022 19:08:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_OutputFcn, ...
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
% End initialization code - DfigureO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
HK = get(handles.edit6,'String');
HK = char(HK);
In = get(handles.edit12,'String');
In = "Head"+char(In);
addpath 'AES_update'\
%key='7fcc1dd7bccb9e31a6bf48bb803644b70a3c135fd21a00f92c2bd71b04fbb62c'
Out = Cipher(HK,In);
set(handles.edit13,'string',Out);


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)

% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)

% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BK = get(handles.edit10,'String');
salt = get(handles.edit5,'String');
BK = [char(BK),char(salt)];
a = java.security.MessageDigest.getInstance('SHA-256');
%str = '00000001000010000000111100010110000111010010010000101011001100100011100101000000010001110100111001010101010111000110001101101010011100010111100001111111100001101000110110010100100110111010001010101001101100001011011110111110110001011100110011010011';
%若unicode可以用unicode2native函数转码，或者直接用java.lang.String的getBytes
a.update(uint8(BK));
HK = sprintf('%02X',typecast(a.digest,'uint8'));%BK的摘要值 使用sha256
set(handles.edit6,'string',HK);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --- Executes during object creation, after setting all properties.
function text_put1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_put1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on mouse press over axes background.
function axes5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.tif';'*.*'},'载入指纹');


% --- Executes on mouse press over axes background.
function axes6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text21,'string','处理中');
filename_t = get(handles.text20,'String');
filename = char(filename_t)
Num = strtok(filename,'_');
newNum = str2num(Num);
num_pic = 8; %m
%Sm
newNum = newNum*num_pic + 1;
%n
[S,r,T] = match(newNum,5,1);
r = mod(r,8)+1;
set(handles.edit7,'string',num2str(r));
%FD
set(handles.edit8,'string',num2str(S));
for j = -3:1
    S = round(S,-j);
end
S = S/10;
set(handles.edit9,'string',num2str(S));
%Dk
n = 5;
dataS  = cell(n,1);
[T_x,] = size(T);
for i = 1 : n
    temp = "";
    for j = 2 : T_x
        temp = temp + num2str(T(j,i)) + ",";
    end
    dataS{i,1} = char(temp);
end
set(handles.uitable5,'Data',dataS);
%
BK = "";
for i=1:T_x-1
    BK = BK+dec2bin(S(i),8);
end
% S_ = reshape(dec2bin(S,7),[1,length(S)*7]);
set(handles.edit10,'string',BK);
%set(handles.text21,'string','');
%set(handles.edit11,'string','');



% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function uitable5_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uitable5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename,pathname]=uigetfile({'*.jpg';'*.*'},'载入指纹');
if isequal(filename,0)|isequal(pathname,0)
    errordlg('没有选中文件','出错');
    return;
else
    set(handles.text21,'string','处理中');
    set(handles.text20,'string',filename);
    
    file=[pathname,filename];
    x1=file;
    axes(handles.axes1);
    imshow(x1);
    
    newChr = strrep(filename,'_1','_2');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes2);
    imshow(x1);
    
    newChr = strrep(filename,'_1','_3');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes3);
    imshow(x1);
    
    newChr = strrep(filename,'_1','_4');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes4);
    imshow(x1);
    
    newChr = strrep(filename,'_1','_5');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes5);
    imshow(x1);
    
    
    newChr = strrep(filename,'_1','_6');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes6);
    imshow(x1);
    
    
    newChr = strrep(filename,'_1','_7');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes7);
    imshow(x1);
    
    
    newChr = strrep(filename,'_1','_8');
    file=[pathname,newChr];
    x1=file;
    axes(handles.axes8);
    imshow(x1);
    
    load('db.mat');
    Num = strtok(filename,'_');
    newNum = str2num(Num);
    num_pic = 8; %m
    %Sm
    newNum = newNum*num_pic + 1;
    dataS  = cell(num_pic,1);
    for i = 1 : num_pic
        M1 = ff{newNum+i-1};
        M1=M1(M1(:,3)<5,:);
        count1=size(M1,1);
        temp = "";
        for j = 1 : count1
            temp = temp + "(";
            for l = 1 : 3
                temp = temp + num2str(M1(j,l)) + ",";
            end
            temp = temp + num2str(M1(j,4))+"),";
        end
        dataS{i,1} = char(temp);
    end
    %set(handles.uitable3,'Data',dataS);
    %n
    [S,r,T] = match(newNum,5,1);
    r = mod(r,8)+1;
    %set(handles.edit7,'string',num2str(r));
    %FD
    %set(handles.edit8,'string',num2str(S));
    for j = -3:1
        S = round(S,-j);
    end
    S = S/10;
    set(handles.edit9,'string',num2str(S));
    %Dk
    n = 5;
    dataS  = cell(n,1);
    [T_x,] = size(T);
    for i = 1 : n
        temp = "";
        for j = 2 : T_x
            temp = temp + num2str(T(j,i)) + ",";
        end
        dataS{i,1} = char(temp);
    end
   % set(handles.uitable5,'Data',dataS);
    %
    BK = "";
    for i=1:T_x-1
        
        BK = BK+dec2bin(S(i),8);
        
    end
    % S_ = reshape(dec2bin(S,7),[1,length(S)*7]);
    set(handles.edit10,'string',BK);
    set(handles.text21,'string','');
    
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

In = get(handles.edit12,'String');
In = char(In);
addpath 'AES_update'\
%key='7fcc1dd7bccb9e31a6bf48bb803644b70a3c135fd21a00f92c2bd71b04fbb62c'
Out = Cipher(HK,In);
set(handles.edit13,'string',Out);





set(handles.text21,'string','处理中');
Out="";
L = 1;
filename_t = get(handles.text20,'String');
filename = char(filename_t)
Num = strtok(filename,'_');
newNum = str2num(Num);
num_pic = 8; %m
%Sm
newNum = newNum*num_pic + 1;
%n
while Out(1:4)~="Head"
[S,r,T] = match(newNum,5,1);
r = mod(r,8)+1;
for j = -3:1
    S = round(S,-j);
end
S = S/10;
%Dk
n = 5;
dataS  = cell(n,1);
[T_x,] = size(T);
for i = 1 : n
    temp = "";
    for j = 2 : T_x
        temp = temp + num2str(T(j,i)) + ",";
    end
    dataS{i,1} = char(temp);
end
%
BK = "";
for i=1:T_x-1
    BK = BK+dec2bin(S(i),8);
end
salt = get(handles.edit5,'String');
BK = [BK,char(salt)];
a = java.security.MessageDigest.getInstance('SHA-256');
%str = '00000001000010000000111100010110000111010010010000101011001100100011100101000000010001110100111001010101010111000110001101101010011100010111100001111111100001101000110110010100100110111010001010101001101100001011011110111110110001011100110011010011';
%若unicode可以用unicode2native函数转码，或者直接用java.lang.String的getBytes
a.update(uint8(BK));
HK = sprintf('%02X',typecast(a.digest,'uint8'));%BK的摘要值 使用sha256
set(handles.edit6,'string',HK);

In = get(handles.edit12,'String');
In = char(In);
addpath 'AES_update'\
%key='7fcc1dd7bccb9e31a6bf48bb803644b70a3c135fd21a00f92c2bd71b04fbb62c'
Out = InvCipher(HK,In);
set(handles.text21,'string',"第"+num2str(L)+"次尝试");
L=L+1;
end

set(handles.edit13,'string',Out(5:end));

