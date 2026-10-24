GLOBAL_LIST_INIT(endowment_merit_choice, generate_merit_endowment())

/proc/generate_merit_endowment()
	var/list/choices = list()

	for(var/obj/item/storage/box/hunter/hunter_case as anything in valid_subtypesof(/obj/item/storage/box/hunter))
		choices[initial(hunter_case.name)] = hunter_case

	return choices

// Hunter: The Vigil, p. 67
// Human only merit. Ghouls, kinfolk, and mages should not be able to take these. Being human is already painful enough, hunters need *something* so more than masochists play them.. -Possum
/datum/quirk/darkpack/item_quirk/endowment
	name = "Endowment"
	desc = "You have been entrusted with supplies from a conspiracy, compact, or organization of hunters that has put its faith in you. Be careful, your enemies finding this package might kill you over it."
	// The book makes them 1-5 and the 5 point merits for some factions in tabletop is stuff like unlimited ammo for your chosen weapon or the ability to punch a demon and instantly unpossesse them.
	// As this is not the tabletop, I middle grounded it at 3 and balanced much of the gear around this point. -Possum
	value = 3
	// Human/hunter only. Ghouls, kinfolk, mages, and supernaturals should not get the ability to take this. -Possum
	allowed_splats = list(SPLAT_NONE)
	icon = FA_ICON_RUPEE

/datum/quirk/darkpack/item_quirk/endowment/add_unique(client/client_source)
	var/mob/living/carbon/human/endowment_owner = astype(quirk_holder)
	if(!endowment_owner)
		return

	if(!length(GLOB.endowment_merit_choice))
		return

	var/selected_case = client_source?.prefs?.read_preference(/datum/preference/choiced/endowment_merit)

	var/obj/item/storage/box/hunter/case_type

	if(selected_case && selected_case != "Random")
		case_type = GLOB.endowment_merit_choice[selected_case]

	// Random selection or invalid preference.
	if(!case_type)
		case_type = GLOB.endowment_merit_choice[pick(GLOB.endowment_merit_choice)]

	var/obj/item/storage/box/hunter/new_case = new case_type(get_turf(endowment_owner))

	give_item_to_holder(
		new_case,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "This is your endowment, better hope it helps...",
		notify_player = TRUE,
	)


/datum/quirk_constant_data/blindfoldcolor
	associated_typepath = /datum/quirk/darkpack/item_quirk/endowment
	customization_options = list(/datum/preference/choiced/endowment_merit)

/datum/preference/choiced/endowment_merit
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "endowment_merit"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/endowment_merit/init_possible_values()
	return list("Random") + GLOB.endowment_merit_choice

/datum/preference/choiced/endowment_merit/create_default_value()
	return "Random"

/datum/preference/choiced/endowment_merit/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE
	return /datum/quirk/darkpack/item_quirk/endowment::name in preferences.all_quirks

/datum/preference/choiced/endowment_merit/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return


// Endowment kits. The box kits are so packed items and variants are easier to make. Just add any kit here as a subtype of box/hunter and it autofills into the options. -Possum

/obj/item/storage/box/hunter
	// This name is what it appears as in the character set up before it is overwritten by the PopulateContents() spawn. This allows players to indentify which kit is which while the box
	// remains generic in game to avoid meta gaming.
	name = "box"
	// The description remains in the box as a lore dump, hunters should destroy the box lest they risk revealing their affiliation to a compact.
	desc = "It's just an ordinary box."
	// The boxes are meant to blend in unless inspected.
	icon_state = "box"



// I considered making compacts 1-2 point merit cost and seperating conspiracies into 3-4 (5 point bonuses are stupidly powerful for some so they were excluded)
// Ultimately I did not want to flood the merit lists with more ranks like I did with the talismen so I put them at 3 and middle grounded all of them.
// Some conspiracies are excluded either due to dealing with splats that are not in the game yet, being redundant, being far too powerful/beyond the scope, not fitting the city setting, or just being really fucking lame. -Possum

/obj/item/storage/box/hunter/ashwood_abbey
	name = "Ashwood Abbey"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
The abbey sends their regards, within you will find your refunded application fee, weapons suited for hunters of the abbey, and the expectations of proving yourself by claiming trophies in your hunts.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/ashwood_abbey/PopulateContents()
	name = "box"
	new /obj/item/gun/ballistic/automatic/darkpack/musket (src)
	new /obj/item/ammo_box/darkpack/c75 (src)
	new /obj/item/storage/belt/sheath/vamp/sword (src)
	new /obj/item/stack/dollar/thousand (src)


/obj/item/storage/box/hunter/barret_commission
	name = "Barret Commission"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
The commission expects a great deal from you. Use this stipend to gather information, make bribes, and do whatever it takes to further our goals and knowledge, hopefully with your sanity and life intact.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

// The value given is equal to roughly what the Ashwood Abbey gets, as both compacts are rich assholes. -Possum
/obj/item/stack/dollar/barret_comission_funds
	amount = 7500

/obj/item/storage/box/hunter/barret_commission/PopulateContents()
	new /obj/item/stack/dollar/barret_comission_funds (src)


/obj/item/storage/box/hunter/bear_lodge
	name = "Bear Lodge"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
You are not hunting the dreaded werewolf because they are evil or even to kill them, but to hone your skills as a warrior. The lodge offers these tools, return a legend or be buried with your ancestors.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/bear_lodge/PopulateContents()
	name = "box"
	new /obj/item/gun/ballistic/shotgun/vampire (src)
	new /obj/item/ammo_box/darkpack/c12g/incap (src)
	new /obj/item/knife/hunting (src)
	new /obj/item/restraints/handcuffs (src)
	new /obj/item/restraints/legcuffs/bola (src)
	new /obj/item/restraints/legcuffs/bola (src)


/obj/item/storage/box/hunter/illum_brotherhood
	name = "Illuminated Brotherhood"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
Take as much as you need, illumination is what brought our brotherhood together. Use enough and you will find answers, just as we did.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/illum_brotherhood/PopulateContents()
	name = "box"
	new /obj/item/storage/box/baggie/cocaine (src)
	new /obj/item/storage/box/baggie/cocaine (src)
	new /obj/item/storage/box/baggie/heroin (src)
	new /obj/item/storage/box/baggie/heroin (src)
	new /obj/item/storage/box/baggie/meth (src)
	new /obj/item/storage/box/baggie/meth (src)
	new /obj/item/storage/box/baggie/weed (src)
	new /obj/item/storage/box/baggie/weed (src)


/obj/item/storage/box/hunter/promethean
	name = "Promethean Brotherhood"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
While the process of sacrificing the supernatural with fire has largely been abandoned, the brotherhood sees no issue with just so happening to perform one while defending yourself. Good luck, brother.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/promethean/PopulateContents()
	name = "box"
	new /obj/item/molotov (src)
	new /obj/item/molotov (src)
	new /obj/item/molotov (src)
	new /obj/item/molotov (src)
	new /obj/item/gas_can/full (src)
	new /obj/item/lighter (src)


/obj/item/storage/box/hunter/talbot
	name = "Talbot Group"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
Our work within the talbot group is not to look upon the supernatural as irredeemable monsters, the unwilling and repentant can be helped, if offered a shoulder to lean on. Lift them up so they will not fall further, initiate.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/talbot/PopulateContents()
	name = "box"
	new /obj/item/stack/medical/suture/medicated (src)
	new /obj/item/stack/medical/suture/medicated (src)
	new /obj/item/stack/medical/mesh/advanced (src)
	new /obj/item/stack/medical/mesh/advanced (src)
	new /obj/item/reagent_containers/hypospray/medipen/morphine (src)
	new /obj/item/storage/medkit/darkpack/ifak (src)


// Conspiracies


/obj/item/storage/box/hunter/ascending_ones
	name = "Ascending Ones"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
The three ascending divisions have pooled our resources for this care package. We suggest you continue supporting our interests as we move into the territory, bit by bit.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/ascending_ones/PopulateContents()
	name = "box"
	new /obj/item/storage/box/baggie/cocaine (src)
	new /obj/item/storage/box/baggie/heroin (src)
	new /obj/item/storage/box/baggie/meth (src)
	new /obj/item/reagent_containers/hypospray/medipen/morphine (src)
	new /obj/item/gun/ballistic/revolver/darkpack/magnum (src)
	new /obj/item/ammo_box/darkpack/c44 (src)


/obj/item/storage/box/hunter/cainite_heresy
	name = "Cainite Heresy"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
The creatures of Cain must be slain whereever the corruption takes root, even if it must be done in secrecy. Here are you weapons, you have your orders, see that it is done.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/cainite_heresy/PopulateContents()
	name = "box"
	new /obj/item/molotov (src)
	new /obj/item/lighter (src)
	new /obj/item/ammo_box/darkpack/c556/incendiary (src)
	new /obj/item/gun/ballistic/automatic/darkpack/huntrifle (src)
	new /obj/item/vampire_stake (src)
	new /obj/item/vampire_stake (src)


/obj/item/storage/box/hunter/cheiron_group
	name = "Cheiron Group"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
The Cheiron Group is delighted in your interest in progressing our pharmaceutical future. Within this package are several experimental treatments, you are instructed to use them as needed and record all side effects in your reports. Cheiron Group, for a brighter tomorrow.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/cheiron_group/PopulateContents()
	name = "box"
	new /obj/item/reagent_containers/hypospray/medipen/blood_loss (src)
	new /obj/item/reagent_containers/hypospray/medipen/ifak (src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid (src)
	new /obj/item/reagent_containers/hypospray/medipen/oxandrolone (src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol (src)
	new /obj/item/reagent_containers/hypospray/medipen/morphine (src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants (src)
	new /obj/item/reagent_containers/hypospray/medipen/survival/luxury (src)
	new /obj/item/reagent_containers/hypospray/medipen/atropine (src)


/obj/item/storage/box/hunter/malleus_maleficarum
	name = "Malleus Maleficarum"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
Faith is the foundation of god's will. Deny the witch, deny the demon, deny the monsters of the night. Here are the tools needed to peform your god given duties. Deus Veult.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/malleus_maleficarum/PopulateContents()
	name = "box"
	new /obj/item/knife/combat/bone (src)
	new /obj/item/vampire_stake (src)
	new /obj/item/storage/fancy/candle_box (src)
	new /obj/item/lighter (src)
	new /obj/item/reagent_containers/cup/glass/bottle/holywater (src)
	new /obj/item/book/bible (src)
	new /obj/item/clothing/neck/vampire/prayerbeads (src)


/obj/item/storage/box/hunter/vascu
	name = "Vanguard Serial Crimes Unit"
	desc = {"A seemingly ordinary box that has a small slit with an attached card that can be slid out and read. This one states:
Agent, our investigation has lead you to this location, we suspect it is a hotbed of supernatural activity. Collect any and all evidence you can, you have no back up, so be ready to leave if your cover is blown. You might be able to work with the local police, but they are under no obligation to help you due to jurisdictional issues and cannot be trusted.
Whoever owned this box has been instructed to destroy it, lest their connection be found and their life forfeit."}

/obj/item/storage/box/hunter/vascu/PopulateContents()
	name = "box"
	new /obj/item/detective_scanner/darkpack (src)
	new /obj/item/camera/detective (src)
	new /obj/item/storage/box/evidence (src)
	new /obj/item/storage/belt/holster/detective/darkpack/fbi (src)
	new /obj/item/ammo_box/darkpack/c45acp (src)
	new /obj/item/card/police/fbi (src)
