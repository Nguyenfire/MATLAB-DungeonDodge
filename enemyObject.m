classdef enemyObject < handle
    properties
        xPos;
        yPos;
        hP;
        shotCount;
        entity;
        size;
    end
    methods
        function obj = enemyObject(xPos, yPos, hP, shotCount, size)
            obj.xPos = xPos;
            obj.yPos = yPos;
            obj.hP = hP;
            obj.shotCount = shotCount;
            obj.size = size;
            obj.entity = rectangle('Position', [obj.xPos, obj.yPos, size, size], 'EdgeColor', 'k', 'LineWidth', 2, 'FaceColor', 'r');
        end

        function delete(obj)
            delete(obj.entity);
        end

    end
end