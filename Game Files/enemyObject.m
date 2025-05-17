classdef enemyObject < handle
    % Class for Enemies
    properties
        xPos;
        yPos;
        entity;
    end
    methods
        function obj = enemyObject(xPos, yPos)
            obj.xPos = xPos;
            obj.yPos = yPos;
            obj.entity = rectangle('Position', [obj.xPos, obj.yPos, 2, 2], 'EdgeColor', 'k', 'LineWidth', 2, 'FaceColor', 'r');
        end

        function delete(obj) % Deletes the visual object
            delete(obj.entity);
        end
    end
end