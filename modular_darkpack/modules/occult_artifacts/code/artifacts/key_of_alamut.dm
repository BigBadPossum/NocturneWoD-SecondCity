// Nocturne edit, when making the talisman for the hunter merits they used this code but the way it was written stood to be improved and its logic better defined.
// This should fix a bug and stop the removal logic from screwing up. -Possum
/obj/item/occult_artifact/vampire/proc/update_vampire_damage_mod(mob/living/carbon/human/H)
	if(!istype(H) || !H.dna || !H.dna.species)
		return

	var/total_reduction = 0

	for(var/obj/item/occult_artifact/vampire/V in H.get_all_contents())
		if(!V.identified || V.owner != H)
			continue

		if(istype(V, /obj/item/occult_artifact/vampire/key_of_alamut))
			total_reduction += 20

	H.dna.species.damage_modifier = min(total_reduction, 70)


/obj/item/occult_artifact/vampire/key_of_alamut
	true_name = "Key of Alamut"
	true_desc = "Decreases incoming damage."
	icon_state = "k_alamut"
	research_value = 30

/obj/item/occult_artifact/vampire/key_of_alamut/grant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	update_vampire_damage_mod(H)

/obj/item/occult_artifact/vampire/key_of_alamut/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	update_vampire_damage_mod(H)
