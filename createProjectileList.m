function projectileList = createProjectileList(enemyList)

    projectileList = enemyProjectile.empty();
    
for i = 1:length(enemyList)
    projectile = enemyProjectile(enemyList(i));
    projectileList(i) = projectile;
end