classdef enemyObject < handle
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

        function delete(obj)
            delete(obj.entity);
        end

        function redrawEnt(obj)
            obj.entity = rectangle('Position', [obj.xPos, obj.yPos, 2, 2], 'EdgeColor', 'k', 'LineWidth', 2, 'FaceColor', 'r');
        end
    end
end