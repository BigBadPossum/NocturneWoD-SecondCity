// Witch Finder, page 143
// 1-3 point merit. Yes, they can stack, for 6 points you can get a damage mod of 60 while losing 3 bag slots from items that can be taken from you.
/datum/quirk/darkpack/item_quirk/talisman_rank_one
	name = "Talisman (Weak)"
	desc = "As an occultist, you have obtained a talisman to protect yourself and potentially others. This one is quite weak but still useful. You still need three ranks in occult to make them work."
	// This merits power is based on how many points you spend.
	value = 1
	// This merit is specific to hunters. It is only for regular humans and should not be given to kinfolk, ghouls, or mages.
	// This is so being a human/hunter has options and thus encourages people to play them otherwise the entire server is majority vamps/werewolves. -Possum
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_STAR_OF_LIFE

/datum/quirk/darkpack/item_quirk/talisman_rank_one/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/occult_artifact/hunter/talisman_rank_one = new()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(talisman_rank_one, slots, FALSE)

// Two point merit
/datum/quirk/darkpack/item_quirk/talisman_rank_two
	name = "Talisman (Moderate)"
	desc = "As an occultist, you have obtained a talisman to protect yourself and potentially others. This one is of middling strength. You still need three ranks in occult to make them work."
	value = 2
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_STAR_OF_LIFE

/datum/quirk/darkpack/item_quirk/talisman_rank_two/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/occult_artifact/hunter/talisman_rank_two = new()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(talisman_rank_two, slots, FALSE)

// Three point merit
/datum/quirk/darkpack/item_quirk/talisman_rank_three
	name = "Talisman (Strong)"
	desc = "As an occultist, you have obtained a talisman to protect yourself and potentially others. This one is of quite strong. You still need three ranks in occult to make them work."
	value = 3
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_STAR_OF_LIFE

/datum/quirk/darkpack/item_quirk/talisman_rank_three/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/occult_artifact/hunter/talisman_rank_three = new()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(talisman_rank_three, slots, FALSE)


// Some of the smarter people might notice that, unlike starting werewolf fetishes, these talismans do not start ID'd, you need to roll occult and *you can fail* thus losing the benefit of the merit entirely.
// This is intentional, it requires occult 3 to make any use of these merits AND softly encourages you to pump your occult/intelligence higher, otherwise you are taking a gamble. -Possum
// If you want to make them auto-ID, make occult 3 a pre-req to take this merit at all.

// Tier 1
/obj/item/occult_artifact/hunter/talisman_rank_one
	true_name = "Talisman"
	true_desc = "Decreases incoming damage."
	icon_state = "k_alamut_tal_1"
	research_value = 10

/obj/item/occult_artifact/hunter/talisman_rank_one/grant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 70)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier+10

/obj/item/occult_artifact/hunter/talisman_rank_one/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 50)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier-10

// Tier 2
/obj/item/occult_artifact/hunter/talisman_rank_two
	true_name = "Talisman"
	true_desc = "Decreases incoming damage."
	icon_state = "k_alamut_tal_2"
	research_value = 10

/obj/item/occult_artifact/hunter/talisman_rank_two/grant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 70)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier+20

/obj/item/occult_artifact/hunter/talisman_rank_two/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 50)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier-20

// Tier 3
/obj/item/occult_artifact/hunter/talisman_rank_three
	true_name = "Talisman"
	true_desc = "Decreases incoming damage."
	icon_state = "k_alamut_tal_3"
	research_value = 10

/obj/item/occult_artifact/hunter/talisman_rank_three/grant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 70)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier+30

/obj/item/occult_artifact/hunter/talisman_rank_three/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 50)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier-30
