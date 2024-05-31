if (!playerInvul)
{
	move_x = 15 * (other.image_index * -1);

	move_and_collide(move_x, move_y, collisionTiles);
}