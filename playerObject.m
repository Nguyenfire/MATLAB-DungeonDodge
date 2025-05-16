classdef playerObject < handle
    properties
        xPos;
        yPos;
        hP;
        speed;
        entity;
    end
    methods
        function obj = playerObject(xPos, yPos, hP, speed)
            obj.xPos = xPos;
            obj.yPos = yPos;
            obj.hP = hP;
            obj.speed = speed;
            obj.entity = rectangle('Position', [obj.xPos, obj.yPos, 2, 2], 'EdgeColor', 'b', 'LineWidth', 2, 'FaceColor', 'b');
        end

        function drawPlayer(obj, newXPos, newYPos)
            obj.xPos = newXPos;
            obj.yPos = newYPos;
            obj.entity.Position = [obj.xPos, obj.yPos, 2, 2];
            uistack(obj.entity, 'top');
        end
    end
end