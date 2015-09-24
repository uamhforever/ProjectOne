function InitializePanels(parentWindow)
    % InitializeOpenedWindowsPanel: Define and initialized the uicontrols of the
    % four panels of the parent window (panelWelcome,panelSurfaceEditorMain,
    % panelSystemConfigurationData,panelOpenedWindows)
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    fontSize = aodHandles.FontSize;
    fontName = aodHandles.FontName;
    
    aodHandles.panelMain = uipanel(...
        'Parent',aodHandles.FigureHandle,...
        'units','normalized',....
        'Position',[0.0,0.04,1.0,0.96]);
    
    aodHandles.panelSurfaceEditorMain = uipanel(...
        'Parent',aodHandles.panelMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0,0.0,0.5,1.0],...
        'Visible','on');
    aodHandles.panelComponentEditorMain = uipanel(...
        'Parent',aodHandles.panelMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0,0.0,0.5,1.0],...
        'Visible','off');
    
    aodHandles.panelQuickLayoutView = uipanel(...
        'Parent',aodHandles.panelMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[0.5,0.0,0.5,1.0],...
        'Visible','on');
    aodHandles.axesQuickLayout = axes( ...
        'Parent',aodHandles.panelQuickLayoutView,...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Units', 'Normalized',...
        'Position', [0.1,0.1, 0.8, 0.75],...
        'Box','on','xticklabel',[],'yticklabel',[]);
    
    aodHandles.lblQuickLayoutType = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutView,...
        'Tag', 'lblQuickLayoutType', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Quick Layout Type ',...
        'units','normalized',...
        'Position',[0.01,0.915,0.30,0.04]);
    
    aodHandles.popQuickLayoutType = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutView,...
        'Tag', 'popQuickLayoutType', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'None','System','Surface/Component'},...
        'Value',1,...
        'units','normalized',...
        'Position',[0.35,0.915,0.25,0.05]);
    
    aodHandles.lblQuickLayoutDimension = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutView,...
        'Tag', 'lblQuickLayoutDimension', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Dimension ',...
        'units','normalized',...
        'Position',[0.63,0.915,0.15,0.04]);
    
    aodHandles.popQuickLayoutDimension = uicontrol( ...
        'Parent',aodHandles.panelQuickLayoutView,...
        'Tag', 'popQuickLayoutDimension', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'2D','3D'},...
        'Value',1,...
        'units','normalized',...
        'Position',[0.80,0.915,0.1,0.05]);
    
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

