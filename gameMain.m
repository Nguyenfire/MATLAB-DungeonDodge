clear;
clc;
numEnemies = 0;
global keys
global restingBGM;
global combatBGM;
keys = struct('w', false, 's', false, 'a', false, 'd', false, 'space', false);
screenSize = get(0, 'ScreenSize'); %Gets size of screen
enemiesKilled = 0;

backGroundMusic = input("Would you like your music to be character based or random? (Character/Random) \n" , 's');

[song, sampleRate] = audioread('ConstantModerato.mp3');
startingBGM = audioplayer(song, sampleRate);
play(startingBGM);

if backGroundMusic == "random" || backGroundMusic == "Random" 
    random = randi(5);
    if random == 1
        [song, sampleRate] = audioread('ReDashMOG.mp3');
        combatBGM = audioplayer(song, sampleRate);
    elseif random == 2 
        [song, sampleRate] = audioread('Unbreakable_Instrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    elseif random == 3
        [song, sampleRate] = audioread('OriginalMe_Instrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    elseif random == 4
        [song, sampleRate] = audioread('bite.mp3');
        combatBGM = audioplayer(song, sampleRate);
    else
        [song, sampleRate] = audioread('Sweden.mp3');
        combatBGM = audioplayer(song, sampleRate);
    end
end

[song, sampleRate] = audioread('UnwelcomeSchool.mp3');
restingBGM = audioplayer(song, sampleRate);

difficulty = input("What difficulty would you like to play? (Easy, Normal, Hard) \n", 's');
if difficulty == "easy" || difficulty == "Easy" % Changes base playerHealth depending on difficulty
    healthPoints = 10;
    level = 1;
    moveTime = 150;
    enemySpeed = 0.03;
    disp("Easy Difficulty Selected")
elseif difficulty == "normal" || difficulty == "Normal"
    healthPoints = 7;
    level = 2;
    moveTime = 200;
    enemySpeed = 0.04;
    disp("Normal Difficulty Selected")
elseif difficulty == "hard" || difficulty == "Hard"
    healthPoints = 5;
    level = 3;
    moveTime = 300;
    enemySpeed = 0.05;
    disp("Hard Difficulty Selected")
elseif difficulty == "hardcore" || difficulty == "Hardcore"
    healthPoints = 1;
    level = 6;
    moveTime = inf;
    enemySpeed = 0.07;
    disp("Good luck :)")
else
    error("You did not choose a difficulty, please run again");
end

character = input("What character would you like to play? (Samurai, Knight, Soldier) \n", 's' );
if character == "Samurai" || character == "samurai"      % Checks for keyword 'samurai'
    healthPoints = floor(healthPoints/2);
    speed = 0.3;
    disp("Samurai Selected");
    if backGroundMusic == "Character" || backGroundMusic == "character" % BGMs for samurai
        [song, sampleRate] = audioread('CamelliaInstrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    end

elseif character == "Knight" || character == "knight"  % Same as above, except with different Character values, video, and BGM
    speed = 0.5;
    disp("Knight Selected")
    if backGroundMusic == "Character" || backGroundMusic == "character"
        [song, sampleRate] = audioread('clarionCallInstrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    end

elseif character == "Soldier" || character == "soldier" % Same as above, except with different Character values, video, and BGM
    healthPoints = healthPoints*2;
    speed = 0.2;
    disp("Soldier Selected")
    if backGroundMusic == "Character" || backGroundMusic == "character"
        [song, sampleRate] = audioread('theRedHoodInstrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    end

else
    error("You did not choose a character, please run again");
end

instructions = sprintf("Use WASD to move around the arena. \n" + ...
    "Press space on the portal to move to the next room. \n" + ...
    "Avoid the yellow balls and run into the red boxes to defeat them. \n" + ...
    "Have fun!");
instructionsBox = msgbox(instructions, 'Game Instructions');
uiwait(instructionsBox)

currentRoom = figure('KeyPressFcn', @keyPress, 'KeyReleaseFcn', @keyRelease); % creates figure
set(currentRoom, 'Position', screenSize);
axis equal;
axis off
axis([-30, 30, -30, 30]);

rectangle('Position', [-30, -30, 60, 60], EdgeColor='k', LineWidth=1) % Outline of room
player = playerObject(-1, -30, healthPoints, speed);

while isvalid(currentRoom) % while game is open
   if player.hP <=0
       close all;
       break;
   end

   % combatBGM.StopFcn = @(src, event) play(combatBGM);

   if numEnemies == 0
       portal = rectangle("Position", [-2, -4, 4, 8], 'EdgeColor', 'm', 'LineWidth', 2, 'FaceColor', 'm');
       player = playerObject(player.xPos, player.yPos, player.hP, speed);
       move(keys, player);
       cla;
       player = playerObject(player.xPos, player.yPos, player.hP, speed);

       if (player.xPos >= -4 && player.xPos <= 2 && player.yPos >= -6 && player.yPos <= 4) && keys.space
           clear startingBGM
           cla;
           player = playerObject(-1, -30, player.hP, speed);
           keys = struct('w', false, 's', false, 'a', false, 'd', false, 'space', false);
           [numEnemies, enemyList] = createRoom(level, player);
           projectileList = createProjectileList(enemyList, enemySpeed);
       end
   end

   if exist("enemyList", "var")
       i = 1;
       j = 1;
       while i <= numEnemies
           if j <= length(projectileList) && projectileList(j).distanceTraveled < moveTime
               [distanceFromProjectile, xDistanceFromProjectile, yDistanceFromProjectile] = calculateDistance(player, projectileList(j));
               projectileList(j).projectileMove(xDistanceFromProjectile, yDistanceFromProjectile);
           end
           [distanceFromEnemy, xDistanceFromEnemy, yDistanceFromEnemy] = calculateDistance(player, enemyList(i));
           if(distanceFromProjectile <= 3 && j <= length(projectileList))
               player.hP = player.hP - 1;
               player.entity.FaceColor = 'r';
               pause(0.03)
               player.entity.FaceColor = 'b';
               projectileList(j).deleteProjectile();
               projectileList(j) = [];
           end
           
           if(distanceFromEnemy <= 2)
               enemyList(i).delete()
               enemyList(i) = [];
               numEnemies = numEnemies-1;
               enemiesKilled = enemiesKilled + 1;
               if numEnemies == 0
                   clear("enemyList");
                   clear("projectileList")
               end
           end
           i = i+1;
           j = j+1;
       end

   move(keys, player)

   end
end

close all;

stop(combatBGM);
clear restingBGM;

[endScreen, sampleRateEndSong] = audioread('LivingMice.mp3');
gameOver = audioplayer(endScreen, sampleRateEndSong);
play(gameOver, 1);

disp("You defeated " + enemiesKilled + " enemies!")
disp("To play again, run program again (F5)");
