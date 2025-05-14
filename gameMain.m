clear;
clc;
numEnemies = 0;
global keys
global currentRoom;
keys = struct('w', false, 's', false, 'a', false, 'd', false, 'space', false, 'f', false);
screenSize = get(0, 'ScreenSize'); %Gets size of screen
enemiesKilled = 0;

backGroundMusic = input("Would you like your music to be character based or random? (Character/Random/None) \n" , 's');
if backGroundMusic == "None" || backGroundMusic == "none"
    disp("No Music selected");
else 
    if backGroundMusic == "random" || backGroundMusic == "Random" 
        random = randi(11); % Chooses randomly between 6 audio sets that will loop until program end
        if random <= 2 %
            [song, sampleRate] = audioread('ReDashMOG.mp3');
            BGM = audioplayer(song, sampleRate);
            play(BGM);
        elseif random <= 4 
            [song, sampleRate] = audioread('unity.mp3');
            BGM = audioplayer(song, sampleRate);
            play(BGM);
        elseif random <= 6
            [song, sampleRate] = audioread('YouveAlwaysGotMe.mp3');
            BGM = audioplayer(song, sampleRate);
            play(BGM);
        elseif random <=8
            [song, sampleRate] = audioread('bite.mp3');
            BGM = audioplayer(song, sampleRate);
            play(BGM);
        elseif random <=10
            [song, sampleRate] = audioread('ACPUFreeze.mp3');
            BGM = audioplayer(song, sampleRate);
            play(BGM);
        else
            [song, sampleRate] = audioread('Sweden.mp3');
            BGM = audioplayer(song, sampleRate);
            play(BGM);
        end
    end
end

difficulty = input("What difficulty would you like to play? (Easy, Normal, Hard) \n", 's');
if  difficulty == "easy" || difficulty == "Easy" % Changes base playerHealth depending on difficulty
    healthPoints = 7;
    level = 1;
    disp("Easy Difficulty Selected")
elseif difficulty == "normal" || difficulty == "Normal"
    healthPoints = 5;
    level = 2;
    disp("Normal Difficulty Selected")
elseif difficulty == "hard" || difficulty == "Hard"
    healthPoints = 3;
    level = 3;
    disp("Hard Difficulty Selected")
elseif difficulty == "hardcore" || difficulty == "Hardcore"
    healthPoints = 1;
    level = 100;
    disp("Good luck :)")
else
    error("You did not choose a difficulty, please run again");
end

character = input("What character would you like to play? (Samurai, Knight, Soldier) \n", 's' );
if  character == "Samurai" || character == "samurai"      % Checks for keyword 'samurai'

    healthPoints = floor(healthPoints/2);
    speed = 0.3;
    disp("Samurai Selected");
    if backGroundMusic == "Character" || backGroundMusic == "character" % BGMs for samurai
        [song, sampleRate] = audioread('CamelliaInstrumental.mp3');
        BGM = audioplayer(song, sampleRate);
        play(BGM);
    end

elseif character == "Knight" || character == "knight"  % Same as above, except with different Character values, video, and BGM
    speed = 0.5;
    disp("Knight Selected")
    if backGroundMusic == "Character" || backGroundMusic == "character"
        [song, sampleRate] = audioread('clarionCallInstrumental.mp3');
        BGM = audioplayer(song, sampleRate);
        play(BGM);
    end
elseif character == "Soldier" || character == "soldier" % Same as above, except with different Character values, video, and BGM
    healthPoints = healthPoints*2;
    speed = 0.2;
    disp("Soldier Selected")
    if backGroundMusic == "Character" || backGroundMusic == "character"
        [song, sampleRate] = audioread('theRedHoodInstrumental.mp3');
        BGM = audioplayer(song, sampleRate);
        play(BGM);
    end
else
    error("You did not choose a character, please run again");
end
pause(1)


instructions = sprintf("Instruction Box");
instructionsBox = msgbox(instructions, 'GameInstructions');
uiwait(instructionsBox)


currentRoom = figure('KeyPressFcn', @keyPress, 'KeyReleaseFcn', @keyRelease); % creates figure
set(currentRoom, 'Position', screenSize);
axis equal;
axis off
axis([-30, 30, -30, 30]);

rectangle('Position', [-30, -30, 60, 60], EdgeColor='k', LineWidth=1) % Outline of room
player = playerObject(-1, -30, healthPoints, speed);


while isvalid(currentRoom)% while game is open
   BGM.StopFcn = @(src, event) play(BGM);
   if player.hP <=0
       close(currentRoom);
   end
   if numEnemies == 0
       portal = rectangle("Position", [-2, -4, 4, 8], 'EdgeColor', 'm', 'LineWidth', 2, 'FaceColor', 'm');
       move(keys, player);
       cla;
       player = playerObject(player.xPos, player.yPos, player.hP, speed);

       if (player.xPos >= -4 && player.xPos <= 2 && player.yPos >= -6 && player.yPos <= 4) && keys.f
           cla;
           player = playerObject(-1, -30, player.hP, speed);
           keys = struct('w', false, 's', false, 'a', false, 'd', false, 'space', false, 'f', false);
           [numEnemies, enemyList] = createRoom(level, player);
           projectileList = createProjectileList(enemyList);
       end
   end

   if exist("enemyList", "var")
       i = 1;
       j = 1;
       while i <= numEnemies
           if j <= length(projectileList)
               projectileList(j).projectileMove(0.25, 0.25)
               distanceFromProjectile = calculateDistance(player, projectileList(j));
           end
           distanceFromEnemy = calculateDistance(player, enemyList(i));
           if(distanceFromProjectile <= 3 && j <= length(projectileList))
               player.hP = player.hP - 1;
               player.entity.FaceColor = 'r';
               pause(0.01)
               player.entity.FaceColor = 'b';
               projectileList(j).deleteProjectile();
               projectileList(j) = [];
           end
           
           %if (abs(player.xPos-enemyList(i).xPos) <= 2 && abs(player.yPos-enemyList(i).yPos) <= 2)
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

clear("currentRoom");
clear("keys");
clear("player");


if exist("BGM", "var")
    clear('BGM');
end

[endScreen, sampleRateEndSong] = audioread('LivingMice.mp3');
gameOver = audioplayer(endScreen, sampleRateEndSong);
play(gameOver, 1);
disp("You defeated " + enemiesKilled + " enemies!")
disp("To play again, run program again (F5)");
