function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 30-Dec-2020 00:20:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @untitled_OpeningFcn, ...
    'gui_OutputFcn',  @untitled_OutputFcn, ...
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

% maxIteration = 50;
% epsilon = 0.00001;


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_equation_Callback(hObject, eventdata, handles)
% hObject    handle to edit_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_equation as text
%        str2double(get(hObject,'String')) returns contents of edit_equation as a double




% --- Executes during object creation, after setting all properties.
function edit_equation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_equation.
function pushbutton_equation_Callback(hObject, eventdata, handles)
f = @(x) get(handles.edit_equation,'String');



function edit2_file_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_file_name as text
%        str2double(get(hObject,'String')) returns contents of edit2_file_name as a double


% --- Executes during object creation, after setting all properties.
function edit2_file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2_file_name.
function pushbutton2_file_name_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile({'*.txt'},'File Selector');
if(filename==0)
    set(handles.text7_file_name, 'String', '');
else
    set(handles.text7_file_name, 'String', strcat(pathname,filename));
end


% --- Executes on button press in pushbutton3_bisection.
function pushbutton3_bisection_Callback(hObject, eventdata, handles)
maxIteration = str2double(get(handles.edit3_max_iterations, 'String'));
epsilon = str2double(get(handles.edit4_epsilon, 'String'));
set(handles.table,'Data',[]);
set(handles.text_root,'String',[]);
set(handles.text_iteration,'String',[]);

name = get(handles.text7_file_name,'String');
if(isempty(name))
    equation = get(handles.edit_equation,'String');
    f=inline(equation);
else
    equation = fileread(name);
    f=inline(equation);
end

xl=str2double(get(handles.edit5_x1, 'String'));
xu=str2double(get(handles.edit6_x2, 'String'));

    old_x_axis=[];
    old_error_axis=[];
    old_i_axis = [];
tol=0.01;

if(isempty(get(handles.edit5_x1,'string')) || isempty(get(handles.edit6_x2,'string')) || isempty(get(handles.edit3_max_iterations,'string')))
    errordlg('Missing Input Data','Error');
else
    if(xu <xl || f(xu)*f(xl)>0)
        errordlg('Can not apply bisection method','Error');
    else
        fprintf('\n\nxl\t\t\txu\t\t\txr\t\t\tf(xr)\n');
        % max=str2double(get(handles.edit3_max_iterations, 'String'));
        for i=2:maxIteration
            xr=(xu+xl)/2;
            fprintf('%f\t%f\t%f\t%f\n',xl,xu,xr,f(xr));
            if f(xu)*f(xr)<0
                xl=xr;
            else
                xu=xr;
            end
            xnew(1)=0;
            xnew(i)=xr;
            
            error = abs((xnew(i)-xnew(i-1))/xnew(i));
            row ={i-1 xr error};
            oldData = get(handles.table,'Data');
            newData=[oldData; row];
            set(handles.table,'Data',newData);
            
        new_i_axis=[old_i_axis i];
        old_i_axis=new_i_axis;
       
        
        new_error_axis=[old_error_axis error];
        old_error_axis=new_error_axis;
            
            if abs((xnew(i)-xnew(i-1))/xnew(i))<epsilon,break,end
        end
        
        
         axes(handles.axes1);
         plot(new_i_axis,new_error_axis);
         xlabel('iterations')
         ylabel('Bisection error')
         
        fprintf('\nRoot is "Bisection method": %f\n', xr);
        set(handles.text_root,'String',xr);
        set(handles.text_iteration,'String',i-1);
    end
end


% --- Executes on button press in pushbutton4_false_position.
function pushbutton4_false_position_Callback(hObject, eventdata, handles)
maxIteration = str2double(get(handles.edit3_max_iterations, 'String'));
epsilon = str2double(get(handles.edit4_epsilon, 'String'));
set(handles.table,'Data',[]);
set(handles.text_root,'String',[]);
set(handles.text_iteration,'String',[]);

name = get(handles.text7_file_name,'String');
if(isempty(name))
    equation = get(handles.edit_equation,'String');
    f=inline(equation);
else
    equation = fileread(name);
    f=inline(equation);
end

xl = str2double(get(handles.edit5_x1, 'String'));
xu = str2double(get(handles.edit6_x2, 'String'));


    old_x_axis=[];
    old_error_axis=[];
    old_i_axis = [];
    
    
i = 1;
if(isempty(get(handles.edit5_x1,'string')) || isempty(get(handles.edit6_x2,'string')) || isempty(get(handles.edit3_max_iterations,'string')))
    errordlg('Missing Input Data','Error');
else
    if(xu <xl || f(xu)*f(xl)>0)
        errordlg('Can not apply False-position method','Error');
    else
        xr = (xl*f(xu)-f(xl)*xu)/(f(xu)-f(xl));
        xo = 0;
        fprintf('False position method\n');
        fprintf('xl\t\t xu\t\t\txr \t\tf(xr)\n');
        
        while abs((xr-xo)/xr) > epsilon || i< maxIteration
            fprintf('%f\t%f\t%f\t%f\n',xl,xu,xr,f(xr));
            if(f(xr) * f(xu)) < 0
                xl = xr;
            else
                xu = xr;
            end
            error = abs((xr-xo)/xr) ;
            row ={i xr error};
            oldData = get(handles.table,'Data');
            newData=[oldData; row];
            set(handles.table,'Data',newData);
            
            xo=xr;
            xr = (xl*f(xu)-f(xl)*xu)/(f(xu)-f(xl));
            i = i+1;
            
            
        new_i_axis=[old_i_axis i];
        old_i_axis=new_i_axis;
       
        
        new_error_axis=[old_error_axis error];
        old_error_axis=new_error_axis;
        end
        
         axes(handles.axes1);
         plot(new_i_axis,new_error_axis);
         xlabel('iterations')
         ylabel('False-Reguli error')
         
        fprintf('%f\t%f\t%f\t%f\n',xl,xu,xr,f(xr));
        fprintf('The root using false position method is %g\n',xr);
        set(handles.text_root,'String',xr);
        set(handles.text_iteration,'String',i-1);
    end
end


% --- Executes on button press in pushbutton5_fixed_point.
% --- Executes on button press in pushbutton5_fixed_point.
function pushbutton5_fixed_point_Callback(hObject, eventdata, handles)
maxIteration = str2double(get(handles.edit3_max_iterations, 'String'));
epsilon = str2double(get(handles.edit4_epsilon, 'String'));
set(handles.table,'Data',[]);
set(handles.text_root,'String',[]);
set(handles.text_iteration,'String',[]);

name = get(handles.text7_file_name,'String');
if(isempty(name))
    equation = get(handles.edit_equation,'String');
    f=inline(equation);
else
    equation = fileread(name);
    f=inline(equation);
end

x1 = str2double(get(handles.edit5_x1, 'String'));
x2 = str2double(get(handles.edit6_x2, 'String'));
    old_x_axis=[];
    old_error_axis=[];
    old_i_axis = [];

if(isempty(get(handles.edit5_x1,'string')) || isempty(get(handles.edit6_x2,'string')) || isempty(get(handles.edit3_max_iterations,'string')))
    errordlg('Missing Input Data','Error');
else
    xo = (x1+x2)/2;
    
    while abs(diff(f(xo))) > 1
        
        errordlg('this fucntion diverges please enter another equation','Error');
        equation = get(handles.edit_equation,'String');
        f=inline(equation);
        
    end
    
    i= 1;
    error = 0;
    while (abs(error)>epsilon || i<maxIteration)
        x = f(xo);
        error = abs((x-xo)/x);
        
        row ={i x abs(error)};
        oldData = get(handles.table,'Data');
        newData=[oldData; row];
        set(handles.table,'Data',newData);
        
        xo = x;
        i = i+1;
        
        new_i_axis=[old_i_axis i];
        old_i_axis=new_i_axis;
       
        
        new_error_axis=[old_error_axis error];
        old_error_axis=new_error_axis;
        
    end
    
    axes(handles.axes1);
    plot(new_i_axis,new_error_axis);
    xlabel('iterations')
    ylabel('Fixed Point error')
    
    set(handles.text_root,'String',x);
        set(handles.text_iteration,'String',i-1);
end


% hObject    handle to pushbutton5_fixed_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6_Newton_Raphson.
function pushbutton6_Newton_Raphson_Callback(hObject, eventdata, handles)
maxIteration = str2double(get(handles.edit3_max_iterations, 'String'));
epsilon = str2double(get(handles.edit4_epsilon, 'String'));
set(handles.table,'Data',[]);
set(handles.text_root,'String',[]);
set(handles.text_iteration,'String',[]);
set(handles.text_x2,'String','There is no need for x2');
handles.label_warning.visible ='on';

syms x;
name = get(handles.text7_file_name,'String');
if(isempty(name))
    equation = get(handles.edit_equation,'String');
    f=inline(equation);
    dif=diff(sym(equation));
    d=inline(dif);
else
    equation = fileread(name);
    f=inline(equation);
    dif=diff(sym(equation));
    d=inline(dif);
end


x1 = str2double(get(handles.edit5_x1, 'String'));


    old_x_axis=[];
    old_error_axis=[];
    old_i_axis = [];

if(isempty(get(handles.edit5_x1,'string')) || isempty(get(handles.edit3_max_iterations,'string')))
    errordlg('Missing Input Data','Error');
else
    
    %     x(1)= (x1+x2)/2;
    x(1)= x1;
    for i=1:maxIteration
        x(i+1)=x(i)-((f(x(i))/d(f(x(i)))))
        err(i)=abs((x(i+1)-x(i))/x(i))
        d_x=double(x(i+1));
        d_error=double(err(i));
        
        
        new_i_axis=[old_i_axis i];
        old_i_axis=new_i_axis;
       
        
        new_error_axis=[old_error_axis err(i)];
        old_error_axis=new_error_axis;
        
        row ={i d_x d_error};
        oldData = get(handles.table,'Data');
        newData=[oldData; row];
        set(handles.table,'Data',newData);
        
        
        fprintf('%i\t\t%f\t\t%f\t\t%f\t\t%f\t\t%f\n',i,double(x(i+1)),double(x(i)),double(f(x(i))),double(d(x(i))),double(err(i)));
       
        
        if err(i)<epsilon
            break
        end
    end
    
    
    axes(handles.axes1);
    plot(new_i_axis,new_error_axis);
    xlabel('iterations')
    ylabel('Newton error')
    
    
    set(handles.text_root,'String',d_x);
    set(handles.text_iteration,'String',i);
    
end




% --- Executes on button press in pushbutton7_Secant.
function pushbutton7_Secant_Callback(hObject, eventdata, handles)
maxIteration = str2double(get(handles.edit3_max_iterations, 'String'));
epsilon = str2double(get(handles.edit4_epsilon, 'String'));
set(handles.table,'Data',[]);
set(handles.text_root,'String',[]);
set(handles.text_iteration,'String',[]);

name = get(handles.text7_file_name,'String');
if(isempty(name))
    equation = get(handles.edit_equation,'String');
    f=inline(equation);
else
    equation = fileread(name);
    f=inline(equation);
end



if(isempty(get(handles.edit5_x1,'string')) || isempty(get(handles.edit6_x2,'string')) || isempty(get(handles.edit3_max_iterations,'string')))
    errordlg('Missing Input Data','Error');
else
    iteration =0;
    
    x(1) = str2double(get(handles.edit5_x1, 'String'));
    x(2) = str2double(get(handles.edit6_x2, 'String'));

    old_x_axis=[];
    old_error_axis=[];
    old_i_axis = [];
    
    for i=3:(maxIteration+3)
        x(i) = x(i-1) - (f(x(i-1)))*((x(i-1) - x(i-2))/(f(x(i-1)) - f(x(i-2))));
        err(i) = abs((x(i)-x(i-1))/x(i));
        
        new_i_axis=[old_i_axis i-3];
        old_i_axis=new_i_axis;
       
        
        new_error_axis=[old_error_axis err(i)];
        old_error_axis=new_error_axis;
        
      
        
        row ={iteration x(i) err(i) };
        oldData = get(handles.table,'Data');
        newData=[oldData; row];
        set(handles.table,'Data',newData);
        
        if abs((x(i)-x(i-1))/x(i))<epsilon || iteration > maxIteration
            root=double(x(i))
            iteration
            break
        end
        iteration=iteration+1;
    end
    
   
    axes(handles.axes1);
    plot(new_i_axis,new_error_axis);
    xlabel('iterations')
    ylabel('secant error')
    
    set(handles.text_root,'String',x(i));
    set(handles.text_iteration,'String',iteration);
    set(handles.text_count,'String',1);
end
 

% --- Executes on button press in plot_next.
function plot_next_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit5_x1,'string')) || isempty(get(handles.edit6_x2,'string')) || isempty(get(handles.edit3_max_iterations,'string')))
    errordlg('Missing Input Data','Error');
else
    
    count = str2double(get(handles.text_count,'String'));
     
    if(count == 1)
    
    maxIteration = str2double(get(handles.edit3_max_iterations, 'String'));
    epsilon = str2double(get(handles.edit4_epsilon, 'String'));
    set(handles.table,'Data',[]);
    set(handles.text_root,'String',[]);
    set(handles.text_iteration,'String',[]);
    name = get(handles.text7_file_name,'String');
    if(isempty(name))
    equation = get(handles.edit_equation,'String');
    f=inline(equation);
    else
    equation = fileread(name);
    f=inline(equation);
    end
    
     x(1) = str2double(get(handles.edit5_x1, 'String'));
     x(2) = str2double(get(handles.edit6_x2, 'String'));
      count = count +2 
        old_x_axis=[];
        old_error_axis=[];
        old_i_axis = [];
        new_i_axis = [old_i_axis];
        new_error_axis = [old_error_axis];

    else 
        x(count) = x(count-1) - (f(x(count-1)))*((x(count-1) - x(count-2))/(f(x(count-1)) - f(x(count-2))));
        err(count) = abs((x(count)-x(count-1))/x(count));
        
        new_i_axis=[old_i_axis count-3]
        old_i_axis=new_i_axis
 
        
        new_error_axis=[old_error_axis err(count)];
        old_error_axis=new_error_axis;
        

    end
    axes(handles.axes1);
    plot(new_i_axis,new_error_axis);
    xlabel('iterations')
    ylabel('secant error')
    
    count = count + 1 
end
   







function edit4_epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_epsilon as text
%        str2double(get(hObject,'String')) returns contents of edit4_epsilon as a double


% --- Executes during object creation, after setting all properties.
function edit4_epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_max_iterations_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_max_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_max_iterations as text
%        str2double(get(hObject,'String')) returns contents of edit3_max_iterations as a double

% --- Executes during object creation, after setting all properties.
function edit3_max_iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_max_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9_clear.
function pushbutton9_clear_Callback(hObject, eventdata, handles)
set(handles.text7_file_name, 'String', '');
% hObject    handle to pushbutton9_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_x1_Callback(hObject, eventdata, handles)
% hObject    handle to edit5_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5_x1 as text
%        str2double(get(hObject,'String')) returns contents of edit5_x1 as a double


% --- Executes during object creation, after setting all properties.
function edit5_x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_x2_Callback(hObject, eventdata, handles)
% hObject    handle to edit6_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6_x2 as text
%        str2double(get(hObject,'String')) returns contents of edit6_x2 as a double


% --- Executes during object creation, after setting all properties.
function edit6_x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10_sin.
function pushbutton10_sin_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit_equation,'String')))
    set(handles.edit_equation, 'String', 'sin(x)');
else
    set(handles.edit_equation, 'String', strcat(get(handles.edit_equation,'String'), 'sin(x)'));
end

% hObject    handle to pushbutton10_sin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11_sqrt.
function pushbutton11_sqrt_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit_equation,'String')))
    set(handles.edit_equation, 'String', 'sqrt(x)');
else
    set(handles.edit_equation, 'String', strcat(get(handles.edit_equation,'String'), 'sqrt(x)'));
end

% hObject    handle to pushbutton11_sqrt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12_cos.
function pushbutton12_cos_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit_equation,'String')))
    set(handles.edit_equation, 'String', 'cos(x)');
else
    set(handles.edit_equation, 'String', strcat(get(handles.edit_equation,'String'), 'cos(x)'));
end
% hObject    handle to pushbutton12_cos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13_poly.
function pushbutton13_poly_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit_equation,'String')))
    set(handles.edit_equation, 'String', '(x).^( )');
else
    set(handles.edit_equation, 'String', strcat(get(handles.edit_equation,'String'), '(x).^( )'));
end

% hObject    handle to pushbutton13_poly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14_exp.
function pushbutton14_exp_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit_equation,'String')))
    set(handles.edit_equation, 'String', 'exp(x)');
else
    set(handles.edit_equation, 'String', strcat(get(handles.edit_equation,'String'), 'exp(x)'));
end

% hObject    handle to pushbutton14_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15_tan.
function pushbutton15_tan_Callback(hObject, eventdata, handles)
if(isempty(get(handles.edit_equation,'String')))
    set(handles.edit_equation, 'String', 'tan(x)');
else
    set(handles.edit_equation, 'String', strcat(get(handles.edit_equation,'String'), 'tan(x)'));
end
% hObject    handle to pushbutton15_tan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on table and none of its controls.
function table_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to table (see GCBO)
% eventdata  structure with the following fields (see TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset ;
set(handles.table, 'Data', cell(size(get(handles.table,'Data'))));
initialize_gui(gcbf, handles, true);



function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

set(handles.edit_equation,'String','');
set(handles.edit5_x1, 'String',0);
set(handles.edit6_x2,  'String',0);
set(handles.edit3_max_iterations,  'String', 50);
set(handles.edit4_epsilon, 'String', 0.00001);
set(handles.text_root,'String',[]);
set(handles.text_iteration,'String',[]);

% set(handles.unitgroup, 'SelectedObject', handles.english);
% 
% set(handles.text4, 'String', 'lb/cu.in');
% set(handles.text5, 'String', 'cu.in');
% set(handles.text6, 'String', 'lb');

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes during object creation, after setting all properties.
function text_count_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
