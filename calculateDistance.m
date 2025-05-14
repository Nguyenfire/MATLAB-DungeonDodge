function [totalDistance, xDistance, yDistance] = calculateDistance(player, enemy)
% Calculates the distance between player and enemy
    xDistance = player.xPos - enemy.xPos;
    yDistance = player.yPos - enemy.yPos;
    totalDistance = sqrt((player.xPos - enemy.xPos)^2 + (player.yPos - enemy.yPos)^2);
end
