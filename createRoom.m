function [numEnemies, enemyList] = createRoom(level, player)
roomType = randi(10); % Chooses which room will be generated
enemyList = enemyObject.empty();

if roomType <= 7 % Normal Room (70%)
    numEnemies = 2*level;
    for i = 1:numEnemies
        enemy = enemyObject(randi([-25, 25]), randi([-25, 25]), 1, 3, 2);
        enemyList(i) = enemy;
    end

elseif roomType < 10 % Rest Room (20%)
    numEnemies = 0;
    player.hP = player.hP+1;
else                 % Boss Room (10%)
    numEnemies = 1;
    enemy = enemyObject(-5, 20, level*100, 100, 10);
    enemyList(1) = enemy;
end