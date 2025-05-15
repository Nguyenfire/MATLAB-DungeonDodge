function projectileList = createProjectileList(enemyList, speed)

    projectileList = enemyProjectile.empty();
    
for i = 1:length(enemyList)
    projectile = enemyProjectile(enemyList(i), speed);
    projectileList(i) = projectile;
end