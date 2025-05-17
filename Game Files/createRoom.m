function [numEnemies, enemyList] = createRoom(level, player)
% Creates Room of Enemies
    global combatBGM;    
    global restingBGM;

    roomType = randi(10); % Chooses which room will be generated
    enemyList = enemyObject.empty();

if roomType <= 9 % Normal Room (90%)
    stop(restingBGM)
    
    numEnemies = 2*level;
    for i = 1:numEnemies
        enemy = enemyObject(randi([-25, 25]), randi([-25, 25]));
        enemyList(i) = enemy;
        play(combatBGM)
    end

else % Rest Room (10%)
    stop(combatBGM)
    numEnemies = 0;
    player.hP = player.hP+1;
    player.speed = 0.05;
    play(restingBGM)
end