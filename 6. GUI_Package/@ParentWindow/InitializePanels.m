function InitializePanels(parentWindow)
    % InitializeOpenedWindowsPanel: Define and initialized the uicontrols of the
    % four panels of the parent window (panelWelcome,panelOpticalElementEditorMain,
    % panelSystemConfigurationData,panelOpenedWindows)
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    fontSize = aodHandles.FontSize;
    fontName = aodHandles.FontName;
    
    aodHandles.panelMain = uipanel(...
        'Parent',aodHandles.FigureHandle,...
        'units','normalized',....
        'Position',[0.0,0.04,1.0,0.96]);
    
    aodHandles.panelOpticalElementEditorMain = uipanel(...
        'Parent',aodHandles.panelMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0,0.0,0.6,1.0],...
        'Visible','on');
%     
%     aodHandles.panelComponentEditorMain = uipanel(...
%         'Parent',aodHandles.panelMain,...
%         'FontSize',fontSize,'FontName', fontName,...
%         'Units','Normalized',...
%         'Position',[0,0.0,0.5,1.0],...
%         'Visible','off');
%     
    aodHandles.panelQuickLayoutView = uipanel(...
        'Parent',aodHandles.panelMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0.6,0.0,0.4,1.0],...
        'Visible','on');

    aodHandles.panelQuickLayoutSetting = uipanel(...
        'Parent',aodHandles.panelQuickLayoutView,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0.0,0.82, 1.0, 0.18],...
        'Visible','on');
    
    aodHandles.btngrpQuickLayoutAxesViewSetting = uibuttongroup(...
        'Parent',aodHandles.panelQuickLayoutView,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0.68,0.78, 0.32, 0.04],...
        'Visible','on');
    % Create three radio buttons in the button group.
    aodHandles.rdbtnQuickAxisRotate = uicontrol(aodHandles.btngrpQuickLayoutAxesViewSetting,...
        'Style','radiobutton','String','Rotate','Units','Normalized',...
        'Position',[0.0,0.1, 0.35, 0.9],'callback',{@rotateQuickLayout,parentWindow});
    aodHandles.rdbtnQuickAxisZoom = uicontrol(aodHandles.btngrpQuickLayoutAxesViewSetting,...
        'Style','radiobutton','String','Zoom','Units','Normalized',...
        'Position',[0.35,0.1, 0.35, 0.9],'callback',{@zoomQuickLayout,parentWindow});
    aodHandles.rdbtnQuickAxisPan = uicontrol(aodHandles.btngrpQuickLayoutAxesViewSetting,...
        'Style','radiobutton','String','Pan','Units','Normalized',...
        'Position',[0.70,0.1, 0.30, 0.9],'callback',{@panQuickLayout,parentWindow});
    
    aodHandles.axesQuickLayout = axes( ...
        'Parent',aodHandles.panelQuickLayoutView,...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Units', 'Normalized',...
        'Position', [0.1,0.10, 0.85, 0.65],...
        'Box','on','xticklabel',[],'yticklabel',[]);
    rotate3d(aodHandles.axesQuickLayout,'on')
    
    aodHandles.lblQuickLayoutType = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'lblQuickLayoutType', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Quick Layout Type ',...
        'units','normalized',...
        'Position',[0.01,0.69,0.30,0.25]);
    
    aodHandles.popQuickLayoutType = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickLayoutType', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'None','System','Surface/Component'},...
        'Value',1,...
        'units','normalized',...
        'Position',[0.35,0.7,0.22,0.25]);
    
    aodHandles.lblQuickLayoutDimension = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'lblQuickLayoutDimension', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Dimension ',...
        'units','normalized',...
        'Position',[0.60,0.69,0.18,0.25]);
    
    aodHandles.popQuickLayoutDimension = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickLayoutDimension', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'2D','3D'},...
        'Value',1,...
        'units','normalized',...
        'Position',[0.80,0.7,0.15,0.25]);

    
    aodHandles.lblPupilSamplingType = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'lblPupilSamplingType', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Pupil Sampling Type ',...
        'units','normalized',...
        'Position',[0.01,0.34,0.30,0.25]);
    
    aodHandles.popQuickPupilSamplingType = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickPupilSamplingType', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', GetSupportedPupilSamplingTypes(),...
        'Value',1,...
        'units','normalized',...
        'Position',[0.35,0.35,0.22,0.25]);
    
    aodHandles.lblQuickNumberOfRay = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'lblQuickNumberOfRay', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Number Of Rays ',...
        'units','normalized',...
        'Position',[0.60,0.34,0.18,0.25]);
    
   aodHandles.popQuickNumberOfRay1 = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickNumberOfRay1', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', num2cell([3:2:51]),...
        'Value',1,...
        'units','normalized',...
        'Position',[0.80,0.35,0.07,0.25]);

    aodHandles.popQuickNumberOfRay2 = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickNumberOfRay2', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', num2cell([3:2:51]),...
        'Value',1,...
        'units','normalized',...
        'Position',[0.88,0.35,0.07,0.25]);

    aodHandles.lblQuickFieldIndex = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'lblQuickFieldIndex', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Field Point ',...
        'units','normalized',...
        'Position',[0.01,0.04,0.30,0.25]);
    
    aodHandles.popQuickFieldIndex = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickFieldIndex', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'All'},...
        'Value',1,...
        'units','normalized',...
        'Position',[0.35,0.05,0.22,0.25]);
    
    aodHandles.lblQuickWavelengthIndex = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'lblQuickWavelengthIndex', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Wavelength ',...
        'units','normalized',...
        'Position',[0.60,0.04,0.18,0.25]);
    
    aodHandles.popQuickWavelengthIndex = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutSetting,...
        'Tag', 'popQuickWavelengthIndex', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'All'},...
        'Value',1,...
        'units','normalized',...
        'Position',[0.80,0.05,0.15,0.25]);   
 

    aodHandles.panelSystemConfigurationData = uipanel(...
        'Parent',aodHandles.SystemConfigurationFigureHandle,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0,0,1.0,1.0]);
    
    nTaskBar = 5;
    for k = 1:nTaskBar
        aodHandles.panelTaskBar(k) = uipanel(...
            'Parent',aodHandles.FigureHandle,...
            'FontSize',fontSize,'FontName', fontName,...
            'Units','Normalized',...
            'Position',[(k-1)/nTaskBar,0,1/nTaskBar,0.04]);
        aodHandles.lblTaskBar(k) = uicontrol(...
            'Parent',aodHandles.panelTaskBar(k),...
            'Tag', 'lblTaskBar', ...
            'Style', 'text', ...
            'HorizontalAlignment','left',...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'String', 'System paraxial property !! ',...
            'Units','Normalized',...
            'Position',[0,0,1,1]);
    end
    
    set(aodHandles.popQuickLayoutType,...
        'Callback',{@popQuickLayoutType_Callback,parentWindow});
    set(aodHandles.popQuickLayoutDimension,...
        'Callback',{@popQuickLayoutDimension_Callback,parentWindow});
     set(aodHandles.popQuickPupilSamplingType,...
        'Callback',{@popQuickPupilSamplingType_Callback,parentWindow});
    set(aodHandles.popQuickNumberOfRay1,...
        'Callback',{@popQuickNumberOfRay1_Callback,parentWindow});   
    set(aodHandles.popQuickNumberOfRay2,...
        'Callback',{@popQuickNumberOfRay2_Callback,parentWindow});   
    set(aodHandles.popQuickFieldIndex,...
        'Callback',{@popQuickFieldIndex_Callback,parentWindow});   
    set(aodHandles.popQuickWavelengthIndex,...
        'Callback',{@popQuickWavelengthIndex_Callback,parentWindow});

    parentWindow.ParentHandles = aodHandles;
end
function popQuickLayoutType_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end
function popQuickLayoutDimension_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end

function popQuickPupilSamplingType_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end
function popQuickNumberOfRay1_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end
function popQuickNumberOfRay2_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end
function popQuickWavelengthIndex_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end
function popQuickFieldIndex_Callback(hObject, eventdata,parentWindow)
    selectedSurfOrCompIndex = parentWindow.ParentHandles.SelectedElementIndex;
    updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex);
end

function zoomQuickLayout(hObject, eventdata,parentWindow)
    zoom(parentWindow.ParentHandles.axesQuickLayout,'on')
end
function rotateQuickLayout(hObject, eventdata,parentWindow)
    rotate3d(parentWindow.ParentHandles.axesQuickLayout,'on')
end
function panQuickLayout(hObject, eventdata,parentWindow)
    pan(parentWindow.ParentHandles.axesQuickLayout,'on')
end
