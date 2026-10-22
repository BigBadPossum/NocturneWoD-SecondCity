// Custom by Possum
// There is a hunter perk called sheer grit that could not be translated well into ss13, so I made my own modification of it.
/datum/quirk/darkpack/sheer_grit
	name = "Sheer Grit"
	desc = {"Your sheer mental resolve has made your mind compensate where your body cannot, a life force only a true born human could have.
		You gain additional health as if it was stamina using your wits stat."}
	// This is technically an 8 point merit to get its full value. 5 in wits + 3 from the cost means its 8 to get 62.5 additional HP (12.5 per rank of wits)
	value = 3
	mob_trait = TRAIT_MERIT_SHEERGRIT
	icon = FA_ICON_SHIELD_ALT
	allowed_splats = list(SPLAT_NONE)

/datum/quirk/darkpack/sheer_grit/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.recalculate_max_health()

/datum/quirk/darkpack/sheer_grit/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.recalculate_max_health()
