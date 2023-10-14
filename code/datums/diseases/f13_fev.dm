/* FEV diseases */
// Main code

// FEV - Curling 13
/datum/disease/curling_thirteen
	form = "Virus"
	name = "Curling 13"
	desc = "A modified version of Forced Evolutionary Virus specifically engineered to kill every irradiated lifeform. The more radiation you have stored - the faster you'll die."
	max_stages = 5
	stage_prob = 100 // It's handled below
	spread_text = "Airborne"
	agent = "Forced Evolutionary Virus"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_text = "Mutadone, Haloperidol and Penicillin"
	cures = list(/datum/reagent/medicine/mutadone, /datum/reagent/medicine/haloperidol, /datum/reagent/medicine/spaceacillin)
	cure_chance = 40 // If you can gather all three - you deserve a somewhat of a good chance.
	severity = DISEASE_SEVERITY_BIOHAZARD

/datum/disease/curling_thirteen/update_stage(new_stage)
	if(new_stage > stage)
		var/radiation_prob = max(round(affected_mob.radiation * 0.05), 1) // 1000 rads will result in 50 chance
		var/new_stage_prob = min(radiation_prob, 50)
		if(prob(new_stage_prob))
			return ..()
		return
	return ..()

/datum/disease/curling_thirteen/stage_act()
	..()
	switch(stage)
		if(1) // Calm before the storm
			if(prob(1))
				to_chat(affected_mob, "<span class='warning'>You scratch at an itch.")
				affected_mob.adjustBruteLoss(1,0)
			if(prob(1))
				affected_mob.emote("cough")
		if(2)
			if(prob(2))
				to_chat(affected_mob, "<span class='warning'>You scratch at an itch.")
				affected_mob.adjustBruteLoss(3,0)
			if(prob(2))
				affected_mob.emote("cough")
				affected_mob.adjustOxyLoss(2)
				to_chat(affected_mob, "<span class='warning'>Your chest hurts.</span>")
			if(prob(4))
				to_chat(affected_mob, "<span class='warning'>You feel a cold sweat form.</span>")
		if(3)
			if(prob(2))
				to_chat(affected_mob, "<span class='danger'>You see four of everything...</span>")
				affected_mob.Dizzy(5)
			if(prob(3))
				to_chat(affected_mob, "<span class='danger'>You feel a sharp pain from your lower chest!</span>")
				affected_mob.adjustOxyLoss(6)
				affected_mob.emote("gasp")
			if(prob(3))
				to_chat(affected_mob, "<span class='danger'>It hurts like hell! Make it stop!")
				affected_mob.adjustBruteLoss(6,0)
			if(prob(3))
				affected_mob.vomit(10)
			if(prob(4))
				to_chat(affected_mob, "<span class='danger'>Your head feels dizzy...</span>")
				affected_mob.adjustStaminaLoss(10)
		if(4) // That's the part where you start dying
			if(prob(2))
				to_chat(affected_mob, "<span class='userdanger'>You feel as if your organs just exploded!</span>")
				affected_mob.playsound_local(affected_mob, 'sound/effects/singlebeat.ogg', 50, 0)
				affected_mob.blur_eyes(10)
				affected_mob.vomit(10, 1, 1, 0, 1, 1)
			if(prob(3))
				to_chat(affected_mob, "<span class='warning'>You should probably lie down for a moment...</span>")
				affected_mob.adjustStaminaLoss(30)
			if(prob(3))
				to_chat(affected_mob, "<span class='userdanger'>Your skin starts to rip apart!")
				affected_mob.adjustBruteLoss(10,0)
				affected_mob.emote("scream")
			if(prob(8))
				affected_mob.adjustToxLoss(2)
		if(5) // That's the part where you die for real
			var/datum/component/mood/mood = affected_mob.GetComponent(/datum/component/mood)
			mood.setSanity(SANITY_INSANE) // Who wouldn't be insane when they have 5 seconds left to live?
			if(prob(5))
				to_chat(affected_mob, "<span class='userdanger'>You feel as if all your organs just exploded!</span>")
				affected_mob.emote("scream")
				affected_mob.blur_eyes(5)
				affected_mob.vomit(50, 1, 1, 0, 1, 1)
			if(prob(7))
				to_chat(affected_mob, "<span class='userdanger'>Your skin keeps ripping itself apart!")
				affected_mob.adjustBruteLoss(15,0)
				affected_mob.emote("cry")
			if(prob(10))
				affected_mob.adjustToxLoss(5)
	return


/datum/disease/fev1 //You die from mutations.
	form = "Forced Evolutionary Virus"
	name = "FEV-I Toxin Strain"
	max_stages = 4
	cures = list(/datum/reagent/medicine/mutadone)
	cure_text = "Mutadone."
	cure_chance = 40 // Yeah.
	agent = "DNA"
	desc = "A megavirus, with a protein sheath reinforced by ionized hydrogen. This virus is capable of mutating the affected into something horrifying..."
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DISEASE_SEVERITY_BIOHAZARD
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	bypasses_immunity = FALSE // This can be cured!
	var/FEV1trait = FALSE

/datum/disease/fev1/stage_act()
	..()
	affected_mob.adjustCloneLoss(-4,0) // Don't die while you are mutating.
	switch(stage)
		if(2)
			if (prob(8))
				to_chat(affected_mob, "<span class='danger'>You feel weird...</span>")
				affected_mob.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
		if(3)
			if (prob(100))
				if(!FEV1trait)
					to_chat(affected_mob, "<span class='danger'>Your skin twitches and swells...</span>")
					affected_mob.Jitter(3)
					ADD_TRAIT(affected_mob, TRAIT_FEV, "FEV-I Exposure") //So you can dose FEV, and then take mutadone. Still deadly and dangerous
					affected_mob.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
					FEV1trait = TRUE
				if(prob(2))
					affected_mob.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
		if(4)
			if (prob(20))
				to_chat(affected_mob, "<span class='danger'>The pain is unbearable!</span>")
				affected_mob.emote("cry")
			if (prob(15))
				to_chat(affected_mob, "<span class='danger'>Your skin begins to shift, hurting like hell!</span>")
				affected_mob.emote("scream")
				affected_mob.Jitter(4)
				affected_mob.easy_randmut(NEGATIVE+NEGATIVE)
			if (prob(6))
				to_chat(affected_mob, "<span class='danger'>Your body shuts down for a moment!</span>")
				affected_mob.Unconscious(10)


/datum/disease/fev2 //You die from mutations.
	form = "Forced Evolutionary Virus"
	name = "FEV-II Stable Strain"
	max_stages = 4
	cures = list(/datum/reagent/medicine/mutadone, /datum/reagent/medicine/haloperidol)
	cure_text = "Mutadone."
	cure_chance = 5 // Nonlethal.
	agent = "DNA"
	desc = "A megavirus, with a protein sheath reinforced by ionized hydrogen, which has been however, affected by radiation. This will mutate the host into something less... Horrifying."
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DISEASE_SEVERITY_BIOHAZARD
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	bypasses_immunity = FALSE // This can be cured!
	var/FEV2trait = FALSE

/datum/disease/fev2/stage_act()
	..()
	affected_mob.adjustCloneLoss(-4,0) // Don't die while you are mutating.
	switch(stage)
		if(2)
			if (prob(8))
				to_chat(affected_mob, "<span class='danger'>You feel weird...</span>")
				affected_mob.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
				affected_mob.emote("cough")
		if(3)
			if(prob(2))
				to_chat(affected_mob, "<span class='danger'>Your skin hurts, and your insides burn!</span>")
				affected_mob.adjustCloneLoss(2,0)
				affected_mob.emote("cough")
		if(4)
			if(!FEV2trait)
				to_chat(affected_mob, "<span class='reallybig hypnophrase'>Simple! Efficient! Glorious!</span>")
				var/datum/component/mood/mood = affected_mob.GetComponent(/datum/component/mood)
				mood.setSanity(SANITY_INSANE) // You're happy, aren't you?
				ADD_TRAIT(affected_mob, TRAIT_FEVII, "FEV-II Exposure")
				FEV2trait = TRUE //Stops spam
				affected_mob.emote("screams")
			if(prob(0.1))
				to_chat(affected_mob, "<span class='danger'>You feel the lingering effects of the virus in your blood...</span>") //Warning that you're still able to infect others via blood to blood transmission


