alive = true;
enemySpriteVal = random_range(0, 3);
enemySprites = [spr_slimeIdle, spr_skeletonWalk, spr_golemRun, spr_batFly];

sprite_index = enemySprites[enemySpriteVal];
image_xscale = -1;