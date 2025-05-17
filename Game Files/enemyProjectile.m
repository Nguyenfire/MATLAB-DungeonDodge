classdef enemyProjectile < handle
    % Class for Enemy Projectiles
    properties
        xPos;
        yPos;
        bullet;
        speed;
        distanceTraveled;
    end
    methods
        function obj = enemyProjectile(enemyObject, speed)
            obj.xPos = enemyObject.xPos;
            obj.yPos = enemyObject.yPos;
            obj.bullet = rectangle('Position', [enemyObject.xPos, enemyObject.yPos, 1, 1], 'EdgeColor', 'k', 'LineWidth', 1, 'FaceColor', 'y', 'curvature', [1,1]);
            obj.speed = speed;
            obj.distanceTraveled = 0;
        end

        function projectileMove(obj, xDist, yDist) % Moves the projectile
            obj.xPos = obj.xPos+xDist*obj.speed;
            obj.yPos = obj.yPos+yDist*obj.speed;
            obj.bullet.Position = [obj.xPos, obj.yPos, 1, 1];
            obj.xPos = obj.xPos+xDist*obj.speed;
            obj.distanceTraveled = obj.distanceTraveled + 1;
        end

        function deleteProjectile(obj)
            delete(obj.bullet);
        end

    end
end