// Witch Finders, p. 183
// Good for larping as a mage. -Possum
/datum/quirk/darkpack/item_quirk/familiar_summoner
	name = "Familiar"
	desc = "You gain the service of a supernatural familiar disguised as a dog that will obey your commands, called to you by an enchanted whistle. The familiar may be a spirit, demon, or ghost in disguise depending on your preference."
	// Surprisingly what it costs in the book.
	value = 1
	// This merit is specific to hunters. It is only for regular humans and should not be given to kinfolk, ghouls, or mages.
	// This is so being a human/hunter has options and thus encourages people to play them otherwise the entire server is majority vamps/werewolves. -Possum
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_SHIELD_DOG

/datum/quirk/darkpack/item_quirk/familiar_summoner/add_unique(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/familiar_summoning_charm/whistle = new /obj/item/familiar_summoning_charm()
	var/list/slots = list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
	)
	H.equip_in_one_of_slots(whistle, slots, FALSE)


/obj/item/familiar_summoning_charm
	name = "strange whistle"
	desc = "A strange looking dog whistle that looks old and features strange designs or cracks through its wooden structure. Is this yours?"
	icon_state = "familiar_whistle"
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/familiar_summoning_charm/attack_self(mob/user)
	. = ..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	H.add_beastmaster_minion(/mob/living/basic/pet/dog/darkpack/familiar)
	H.visible_message(span_warning("As the whistle is silently blown a dog sprints from seemingly nowhere, bounding up to [H] before looking at them expectantly."))
	del(src)

// This is a spiritual familiar used by hunters to fight the supernatural, unlike a vampire who can resummon many wolves, this dog is beefy because you only get 1 per shift. -Possum
/mob/living/basic/pet/dog/darkpack/familiar
	name = "dog"
	desc = "An uncannily alert and intelligent dog, likely someone's pet."
	// You only get one, so its much beefier as a result.
	speed = 0.1
	maxHealth = 300
	health = 300