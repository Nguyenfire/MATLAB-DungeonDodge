function [numEnemies, enemyList] = createRoom(level, player)
    roomType = randi(10); % Chooses which room will be generated
    enemyList = enemyObject.empty();

if roomType <= 7 % Normal Room (70%)
    numEnemies = 2*level;
    for i = 1:numEnemies
        enemy = enemyObject(randi([-25, 25]), randi([-25, 25]));
        enemyList(i) = enemy;
    end
else             % Rest Room (30%)
    numEnemies = 0;
    player.hP = player.hP+1;
end