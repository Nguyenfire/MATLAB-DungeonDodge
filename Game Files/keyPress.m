function keyPress(src, event)
    global keys;
    if isfield(keys, event.Key)
        keys.(event.Key) = true; % Set key state to "pressed"
    end
end