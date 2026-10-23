// Night Stalkers, p. 134
// A 5 point cost to make yourself even harder to be dominated/jerry manded, acts as a good alternative to untameable, which is far more powerful at total immunity. -Possum
/datum/quirk/darkpack/indomitable
	name = "Indomitable"
	desc = {"Through resolve, strength of will, and bloody minded determination you are unceasing in your path.
		You are gain a +1 bonus to resist effects like dominate or presence."}
	// In the books, the power ranges from 1-5 and can give a pretty massive bonus, however in gameplay terms this means that it would make becoming immune to dominate/presence trival.
	// Instead, at 5 point costs with a +1 bonus means a 10 willpower character can negate most of those same powers, for a pretty hefty point cost to resist.
	// This update also gave princes an innately applied debuff (-2) to targets of presence and dominate, so they always have a chance to overcome even the strongest humans.
	// This is so some head honcho with actual power/authority in game can genuinely make use of the discipline they are most likely to use. -Possum
	value = 5
	mob_trait = TRAIT_MERIT_INDOMITABLE
	icon = FA_ICON_STREET_VIEW
	allowed_splats = list(SPLAT_NONE)
