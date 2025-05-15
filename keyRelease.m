function keyRelease(src, event)
    global keys;
    if isfield(keys, event.Key) 
        keys.(event.Key) = false; % Set key state to "released"
    end
end