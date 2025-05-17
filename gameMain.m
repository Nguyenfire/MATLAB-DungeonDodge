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

[song, sampleRate] = audioread('ConstantModerato.mp3'); % BGM For Starting Game
startingBGM = audioplayer(song, sampleRate);
play(startingBGM);

[song, sampleRate] = audioread('UnwelcomeSchool.mp3'); % BGM For Starting Game
restingBGM = audioplayer(song, sampleRate);
play(startingBGM);

instructions = sprintf("Use WASD to move around the arena. \n" + ...
    "Press space on the portal to move to the next room. \n" + ...
    "Avoid the yellow balls and run into the red boxes to defeat them. \n \n" + ...
    "Knight Class: Faster Speed, less HP \n \n" + ...
    "Samurai Class: Slight Speed Increase, less HP \n \n" + ...
    "Solder Class: Slower, more HP \n \n" + ...
    "Good Luck and Have Fun!");

instructionsBox = msgbox(instructions, 'Game Instructions'); % Loads Instructions, waits until UI is closed to continue)
uiwait(instructionsBox)

if backGroundMusic == "random" || backGroundMusic == "Random" % Random music selector
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

difficulty = input("What difficulty would you like to play? (Easy, Normal, Hard) \n", 's');
if difficulty == "easy" || difficulty == "Easy" % Changes base playerHealth, enemySpeed, enemy count, 
    healthPoints = 10;                          % and how long projectiles move depending on difficulty
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
    level = 100;
    moveTime = inf;
    enemySpeed = 0.07;
    disp("Good luck :)")
else
    error("You did not choose a difficulty, please run again");
end

character = input("What character would you like to play? (Samurai, Knight, Soldier) \n", 's' );
if character == "Samurai" || character == "samurai"      % Checks for keyword 'samurai'
    healthPoints = floor(healthPoints/2);                % Sets new values based on character
    speed = 0.3;
    disp("Samurai Selected");
    if backGroundMusic == "Character" || backGroundMusic == "character" % BGM for samurai
        [song, sampleRate] = audioread('CamelliaInstrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    end

elseif character == "Knight" || character == "knight"  % Same as above, except with different Character values and BGM
    speed = 0.5;
    disp("Knight Selected")
    if backGroundMusic == "Character" || backGroundMusic == "character"
        [song, sampleRate] = audioread('clarionCallInstrumental.mp3');
        combatBGM = audioplayer(song, sampleRate);
    end

elseif character == "Soldier" || character == "soldier" % Same as above, except with different Character values and BGM
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

currentRoom = figure('KeyPressFcn', @keyPress, 'KeyReleaseFcn', @keyRelease); % creates figure that accepts functions KeyPress and keyRelease
set(currentRoom, 'Position', screenSize);
axis equal;
axis off
axis([-30, 30, -30, 30]);

rectangle('Position', [-30, -30, 60, 60], 'EdgeColor', 'k', 'LineWidth', 1) % Outline of room
player = playerObject(-1, -30, healthPoints, speed); % Beginning Player Object

while isvalid(currentRoom) % while game is open
   if player.hP <=0 % HP check, if you have none game ends
       close all;
       break;
   end

   if numEnemies == 0 % If no players creates portal in middle of screen, rest of code is for optimization and reducing lag
       portal = rectangle("Position", [-2, -4, 4, 8], 'EdgeColor', 'm', 'LineWidth', 2, 'FaceColor', 'm'); 
       move(keys, player);
       cla;
       player = playerObject(player.xPos, player.yPos, player.hP, speed);
       

       if (player.xPos >= -4 && player.xPos <= 2 && player.yPos >= -6 && player.yPos <= 4) && keys.space % Hit space over portal
           clear startingBGM                                                                             % Go into new room with enemies
           cla;                                                                                          % Or resting room
           player = playerObject(-1, -30, player.hP, speed);
           keys = struct('w', false, 's', false, 'a', false, 'd', false, 'space', false);
           [numEnemies, enemyList] = createRoom(level, player);
           projectileList = createProjectileList(enemyList, enemySpeed);
       end
   end

   if exist("enemyList", "var")
       i = 1;
       j = 1;
       while i <= numEnemies % Itterates through enemies and enemy projectiles
           if j <= length(projectileList) && projectileList(j).distanceTraveled < moveTime
               [distanceFromProjectile, xDistanceFromProjectile, yDistanceFromProjectile] = calculateDistance(player, projectileList(j));
               projectileList(j).projectileMove(xDistanceFromProjectile, yDistanceFromProjectile);
           end
           [distanceFromEnemy, ~, ~] = calculateDistance(player, enemyList(i));
           if(distanceFromProjectile <= 3 && j <= length(projectileList)) % If close enough to projectile player takes dmg
               player.hP = player.hP - 1;
               player.entity.FaceColor = 'r';
               pause(0.03)
               player.entity.FaceColor = 'b';
               projectileList(j).deleteProjectile();
               projectileList(j) = [];
           end
           
           if(distanceFromEnemy <= 2) % If close enough to enemy, enemy is deleted
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

   move(keys, player) % Moves player

   end
end

close all;

stop(combatBGM);
stop(restingBGM);

[endScreen, sampleRateEndSong] = audioread('LivingMice.mp3'); % Ending Music
gameOver = audioplayer(endScreen, sampleRateEndSong);
play(gameOver);

endScreenText = sprintf("You defeated %d enemes! \n To play again, close this window and run the program again", enemiesKilled);
endScreenBox = msgbox(endScreenText, 'End Screen'); % Loads Instructions, waits until UI is closed to continue)
uiwait(endScreenBox)
