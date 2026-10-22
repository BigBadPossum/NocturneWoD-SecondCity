//Function for updating a player's health based on their current stats.
/mob/living/proc/recalculate_max_health(initial = FALSE)
	var/old_max_health = maxHealth

	// All players gain additional health from Stamina.
	maxHealth = round(initial(maxHealth) + ((initial(maxHealth) / 8) * st_get_stat(STAT_STAMINA)))

	// Players with Sheer Grit also gain additional health from Wits.
	if(HAS_TRAIT(src, TRAIT_MERIT_SHEERGRIT))
		maxHealth += round((initial(maxHealth) / 8) * st_get_stat(STAT_WITS))

	if(initial)
		health = maxHealth
	else if(health > 0)
		health = max(health + maxHealth - old_max_health, 1)
