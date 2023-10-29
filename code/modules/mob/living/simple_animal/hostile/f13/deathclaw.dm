/*IN THIS FILE:
-Deathclaws
*/

//Base Deathclaw
/mob/living/simple_animal/hostile/deathclaw
	name = "deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match."
	icon = 'icons/fallout/mobs/monsters/deathclaw.dmi'
	icon_state = "deathclaw"
	icon_living = "deathclaw"
	icon_dead = "deathclaw_dead"
	icon_gib = "deathclaw_gib"
	robust_searching = 1
	maxHealth = 750
	health = 750
	obj_damage = 200
	armour_penetration = 0.2
	melee_damage_lower = 40
	melee_damage_upper = 50
	footstep_type = FOOTSTEP_MOB_HEAVY
	speed = -1.8//Actual speed handled by move_to_delay
	move_to_delay = 1.8

	gender = FEMALE //Actually lore accurate since majority of deathclaws are female, special ones with backwards claws are male.
	a_intent = INTENT_HARM //So we can not move past them.
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	robust_searching = TRUE
	speak = list("ROAR!","Rawr!","GRRAAGH!","Growl!")
	speak_emote = list("growls", "roars")
	emote_hear = list("grumbles.","grawls.")
	emote_taunt = list("stares ferociously", "stomps")
	speak_chance = 10
	taunt_chance = 25

	stat_attack = UNCONSCIOUS

	see_in_dark = 8
	decompose = FALSE
	wound_bonus = 0 //This might be a TERRIBLE idea
	bare_wound_bonus = 0
	sharpness = SHARP_EDGED
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 4,
							/obj/item/stack/sheet/animalhide/deathclaw = 2,
							/obj/item/stack/sheet/bone = 4)
	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "hits"
	attack_verb_simple = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("deathclaw")
	gold_core_spawnable = HOSTILE_SPAWN
	move_resist = MOVE_FORCE_OVERPOWERING
	emote_taunt_sound = list('sound/f13npc/deathclaw/taunt.ogg')
	aggrosound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = 'sound/f13npc/deathclaw/death.ogg'
	var/can_execute = FALSE
	var/execute_threshold = -20 //Default health you have to be to be executed

/mob/living/simple_animal/hostile/deathclaw/AttackingTarget()
	if(can_execute)
		var/mob/living/M = target
		if(!ishuman(M) || M.health > execute_threshold)
			..()
			return

		if(get_dist(src, M) > 0)
			a_intent = INTENT_GRAB
			grab_state = GRAB_NECK
			summon_backup(15)

			start_pulling(M, 1)
			M.grabbedby(src)
			M.drop_all_held_items()
			M.stop_pulling()

			var/obj/item/bodypart/chest/O = M.get_bodypart(BODY_ZONE_CHEST)
			O.force_wound_upwards(/datum/wound/pierce/critical)

			visible_message("<span class='danger'>[src] growls, lifting [M] into the air and violently executing them!</span>")
			to_chat(M, "<span class='userdanger'>[src] lifts you into the air, violently putting an end to your life!</span>")

			M.adjustBruteLoss(100)//Not tanking this without abuse of a specific mechanic. Bypasses armor.

		if(!ishuman(M) || M.health <= 0)
			src.drop_all_held_items()
			src.stop_pulling()
	..()

/*
	var/charging = FALSE
*/
/mob/living/simple_animal/hostile/deathclaw/playable
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 2 //can smash walls
	wander = FALSE

// Mother death claw
/mob/living/simple_animal/hostile/deathclaw/mother
	name = "mother deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one is an angry mother."
	gender = FEMALE
	maxHealth = 800
	health = 800
	stat_attack = UNCONSCIOUS
	melee_damage_lower = 50
	melee_damage_upper = 55
	armour_penetration = 0.4
	footstep_type = FOOTSTEP_MOB_HEAVY
	color = rgb(95,104,94)
	can_execute = TRUE
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 6,
							/obj/item/stack/sheet/animalhide/deathclaw = 3)

//Legendary Deathclaw
/mob/living/simple_animal/hostile/deathclaw/legendary
	name = "legendary deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. This one is a legendary enemy."
	maxHealth = 1500
	health = 1500
	color = "#FFFF00"
	stat_attack = UNCONSCIOUS
	melee_damage_lower = 55
	melee_damage_upper = 55
	armour_penetration = 0.5
	footstep_type = FOOTSTEP_MOB_HEAVY
	can_execute = TRUE
	execute_threshold = 0 //This guy hurts
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/deathclaw = 6)

/mob/living/simple_animal/hostile/deathclaw/legendary/Initialize()
	. = ..()
	if(prob(37))
		guaranteed_butcher_results = list(/obj/item/melee/unarmed/deathclawgauntlet = 1)


//Power Armor Deathclaw the tankest and the scariest deathclaw in the West. One mistake will end you. May the choice be with you.
/mob/living/simple_animal/hostile/deathclaw/power_armor
	name = "power armored deathclaw"
	desc = "A massive, reptilian creature with powerful muscles, razor-sharp claws, and aggression to match. Someone had managed to put power armor on him."
	icon_state = "combatclaw"
	icon_living = "combatclaw"
	icon_dead = "combatclaw_dead"
	maxHealth = 2500
	health = 2500
	stat_attack = UNCONSCIOUS
	melee_damage_lower = 55
	melee_damage_upper = 65
	armour_penetration = 0.75
	footstep_type = FOOTSTEP_MOB_HEAVY
	can_execute = TRUE
	execute_threshold = 10 //Can be executed easier.
