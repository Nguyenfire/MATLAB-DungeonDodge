function [totalDistance] = calculateDistance(player, enemy)
% Calculates the distance between player and enemy
    totalDistance = sqrt((player.xPos - enemy.xPos)^2 + (player.yPos - enemy.yPos)^2);
end