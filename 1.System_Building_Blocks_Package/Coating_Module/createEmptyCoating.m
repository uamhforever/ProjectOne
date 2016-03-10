function emptyCoating = createEmptyCoating()
    % returns an empty struct or object of class
    if isstruct(Coating())
        emptyCoating = struct(...
            'Name',{},...
            'Type',{},...            
            'UniqueParameters',{},...
            'ClassName',{},...
            'SavedIndex',{});
    else
        emptyCoating = Coating.empty;
    end
end