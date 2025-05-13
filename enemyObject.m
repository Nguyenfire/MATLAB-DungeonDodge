classdef enemyObject < handle
    properties
        xPos;
        yPos;
        hP;
        size;
        entity;
        bullet;
    end
    methods
        function obj = enemyObject(xPos, yPos, hP, size)
            obj.xPos = xPos;
            obj.yPos = yPos;
            obj.hP = hP;            
            obj.size = size;
            obj.entity = rectangle('Position', [obj.xPos, obj.yPos, size, size], 'EdgeColor', 'k', 'LineWidth', 2, 'FaceColor', 'r');
            obj.bullet = rectangle('Position', [obj.xPos, obj.yPos, 1, 1], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', 'y', 'curvature', [1,1]);
        end

        function delete(obj)
            delete(obj.entity);
        end

        function moveBullet(obj, x, y)
            obj.bullet.Position = [x, y, 1, 1];
            pause(0.01)
        end
    end
end