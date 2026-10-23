// Witch Finder, page 143
// 2-7 point merit. Yes, they can stack, for 6 points you can get a damage mod of 60 while losing 3 bag slots from items that can be taken from you.
/datum/quirk/darkpack/item_quirk/talisman_rank_one
	name = "Talisman (Weak)"
	desc = "As an occultist, you have obtained a talisman to protect yourself and potentially others from most types of damage. This one is quite weak but still useful. You still need three ranks in occult to identify it."
	// This merits power is based on how many points you spend.
	value = 2
	// This merit is specific to hunters. It is only for regular humans and should not be given to kinfolk, ghouls, or mages.
	// This is so being a human/hunter has options and thus encourages people to play them otherwise the entire server is majority vamps/werewolves. -Possum
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_STAR_OF_LIFE

/datum/quirk/darkpack/item_quirk/talisman_rank_one/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/occult_artifact/hunter/talisman_rank_one/T
	T = new /obj/item/occult_artifact/hunter/talisman_rank_one()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(T, slots, FALSE)

// Five point merit
/datum/quirk/darkpack/item_quirk/talisman_rank_two
	name = "Talisman (Moderate)"
	desc = "As an occultist, you have obtained a talisman to protect yourself and potentially others from most types of damage. This one is of middling strength. You still need three ranks in occult to identify it."
	value = 5
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_STAR_OF_LIFE

/datum/quirk/darkpack/item_quirk/talisman_rank_two/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/occult_artifact/hunter/talisman_rank_two/T
	T = new /obj/item/occult_artifact/hunter/talisman_rank_two()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(T, slots, FALSE)

// Seven point merit
/datum/quirk/darkpack/item_quirk/talisman_rank_three
	name = "Talisman (Strong)"
	desc = "As an occultist, you have obtained a talisman to protect yourself and potentially others from most types of damage. This one is of quite strong. You still need three ranks in occult to identify it."
	value = 7
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_STAR_OF_LIFE

/datum/quirk/darkpack/item_quirk/talisman_rank_three/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/occult_artifact/hunter/talisman_rank_three/T
	T = new /obj/item/occult_artifact/hunter/talisman_rank_three()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(T, slots, FALSE)


// Some of the smarter people might notice that, unlike starting werewolf fetishes, these talismans do not start ID'd, you need to roll occult and *you can fail* thus losing the benefit of the merit entirely.
// This is intentional, it requires occult 3 to make any use of these merits AND softly encourages you to pump your occult/intelligence higher or take master occultist, otherwise you are taking a gamble. -Possum
// If you want to make them auto-ID, make occult 3 a pre-req to take this merit at all.

/obj/item/occult_artifact/hunter
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	abstract_type = /obj/item/occult_artifact/hunter

/obj/item/occult_artifact/hunter/proc/update_talisman_damage_mod(mob/living/carbon/human/H)
	if(!istype(H) || !H.dna || !H.dna.species)
		return

	var/total_reduction = 0

	for(var/obj/item/occult_artifact/hunter/T in H.get_all_contents())
		if(!T.identified || T.owner != H)
			continue

		switch(T.type)
			if(/obj/item/occult_artifact/hunter/talisman_rank_one)
				total_reduction += 10
			if(/obj/item/occult_artifact/hunter/talisman_rank_two)
				total_reduction += 20
			if(/obj/item/occult_artifact/hunter/talisman_rank_three)
				total_reduction += 30

	H.dna.species.damage_modifier = min(total_reduction, 70)

// Tier 1
/obj/item/occult_artifact/hunter/talisman_rank_one
	true_name = "protective talisman"
	true_desc = "Decreases a small amount of incoming damage."
	icon_state = "talisman_rank_1"
	research_value = 10

// This code is a direct copy from key of alamut. I do not like how its done but it might be this way for a reason so its a 1:1 copy. -Possum
/obj/item/occult_artifact/hunter/talisman_rank_one/grant_powers()
	var/mob/living/carbon/human/H = owner
	update_talisman_damage_mod(H)

/obj/item/occult_artifact/hunter/talisman_rank_one/ungrant_powers()
	var/mob/living/carbon/human/H = owner
	update_talisman_damage_mod(H)

// Tier 2
/obj/item/occult_artifact/hunter/talisman_rank_two
	true_name = "protective talisman"
	true_desc = "Decreases a moderate amount of incoming damage."
	icon_state = "talisman_rank_2"
	research_value = 20

/obj/item/occult_artifact/hunter/talisman_rank_two/grant_powers()
	var/mob/living/carbon/human/H = owner
	update_talisman_damage_mod(H)

/obj/item/occult_artifact/hunter/talisman_rank_two/ungrant_powers()
	var/mob/living/carbon/human/H = owner
	update_talisman_damage_mod(H)

// Tier 3
/obj/item/occult_artifact/hunter/talisman_rank_three
	true_name = "protective talisman"
	true_desc = "Decreases a great amount of incoming damage."
	icon_state = "talisman_rank_3"
	research_value = 30

/obj/item/occult_artifact/hunter/talisman_rank_three/grant_powers()
	var/mob/living/carbon/human/H = owner
	update_talisman_damage_mod(H)

/obj/item/occult_artifact/hunter/talisman_rank_three/ungrant_powers()
	var/mob/living/carbon/human/H = owner
	update_talisman_damage_mod(H)
