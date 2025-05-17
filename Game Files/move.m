function move(keys, player)
    % Move box based on key states
    x = player.xPos; % takes current player position and speed
    y = player.yPos; 
    speed = player.speed;

rectangle('Position', [-30, -30, 60, 60], EdgeColor='k', LineWidth=1) % Outline of room
    if keys.w, y = y + speed; end % Move based on keypresses
    if keys.s, y = y - speed; end 
    if keys.a, x = x - speed; end 
    if keys.d, x = x + speed; end 

    if x >= 30-2, x = 30-2; end % If you go beyond edge of screen, you move back to edge
    if x <= -30, x = -30; end
    if y >= 30-2, y = 30-2; end
    if y <= -30, y = -30; end

player.drawPlayer(x, y); % Redraws player at new position
pause(0.01)
drawnow limitrate;
end