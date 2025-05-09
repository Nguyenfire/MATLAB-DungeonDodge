function move(keys, player)
    % Move box based on key states
    x = player.xPos;
    y = player.yPos;
    speed = player.speed;

rectangle('Position', [-30, -30, 60, 60], EdgeColor='k', LineWidth=1) % Outline of room
    if keys.w, y = y + speed; end % Facing up
    if keys.s, y = y - speed; end % Facing Down
    if keys.a, x = x - speed; end % Facing Left
    if keys.d, x = x + speed; end % Facing Right

    if x >= 30-2, x = 30-2; end
    if x <= -30, x = -30; end
    if y >= 30-2, y = 30-2; end
    if y <= -30, y = -30; end

player.drawPlayer(x, y);
pause(0.01)
end