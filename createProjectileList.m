function projectileList = createProjectileList(enemyList, speed)
% Creates List of Projectiles to itterate through
    projectileList = enemyProjectile.empty();
    
for i = 1:length(enemyList)
    projectile = enemyProjectile(enemyList(i), speed);
    projectileList(i) = projectile;
end