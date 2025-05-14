classdef enemyProjectile < handle
    properties
        xPos;
        yPos;
        bullet;
    end
    methods
        function obj = enemyProjectile(enemyObject)
            obj.xPos = enemyObject.xPos;
            obj.yPos = enemyObject.yPos;
            obj.bullet = rectangle('Position', [enemyObject.xPos, enemyObject.yPos, 1, 1], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', 'y', 'curvature', [1,1]);
        end

        function projectileMove(obj, newXPos, newYPos)
            obj.bullet.Position = [obj.xPos+newXPos, obj.yPos-newYPos, 1, 1];
            uistack(obj.bullet, 'top');
            obj.xPos = obj.xPos+newXPos;
            obj.yPos = obj.yPos+newYPos;
            refresh
        end

        function deleteProjectile(obj)
            delete(obj.bullet);
        end

    end
end