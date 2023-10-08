/obj/item/stock_parts/fc
	name = "Fusion Core"
	desc = "A heavy duty power core for heavy machinery. Rechargeable, but over lengthy durations."
	icon = 'icons/fallout/objects/powercore.dmi'
	icon_state = "f_core"
	item_state = "cell"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	force = 5
	throwforce = 5
	rating = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/charge = 0	// note %age converted to actual charge in New
	var/maxcharge = 50000
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=200, /datum/material/uranium=5000)
	var/start_charged = TRUE
	grind_results = list(/datum/reagent/uranium = 100, /datum/reagent/iron = 25, /datum/reagent/silicon = 25)
	var/rigged = FALSE	// true if rigged to explode
	var/chargerate = 10 //how much power is given every tick in a recharger
	var/cancharge = 1 //set to 0 if you do not want this battery to be able to charge
	var/self_recharge = 0 //does it self recharge, over time, or not?
	var/ratingdesc = TRUE
	var/grown_battery = FALSE // If it's a grown that acts as a battery, add a wire overlay to it.
	rad_flags = RAD_NO_CONTAMINATE // Prevent the same cheese as with the stock parts

/obj/item/stock_parts/fc/get_cell()
	return src

/obj/item/stock_parts/fc/Initialize(mapload, override_maxcharge)
	. = ..()
	START_PROCESSING(SSobj, src)
	create_reagents(5, INJECTABLE | DRAINABLE)
	if (override_maxcharge)
		maxcharge = override_maxcharge
	if(start_charged)
		charge = maxcharge
	if(ratingdesc)
		desc += " This one has a rating of [DisplayEnergy(maxcharge)], and you should not swallow it."
	update_icon()

/obj/item/stock_parts/fc/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stock_parts/fc/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, self_recharge))
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/stock_parts/fc/process()
	if(self_recharge)
		give(chargerate * 0.25)
	else
		return PROCESS_KILL

/obj/item/stock_parts/fc/update_icon()
	cut_overlays()
	if(grown_battery)
		add_overlay(image('icons/obj/power.dmi',"grown_wires"))
	if(charge < 0.01)
		return
	else if (maxcharge == 1000 || maxcharge == 2500 || maxcharge == 5000)
		if(charge/maxcharge >=0.995)
			add_overlay("cell-o2")
		else
			add_overlay("cell-o1")

/obj/item/stock_parts/fc/proc/percent()		// return % charge of cell
	return 100*charge/maxcharge

// use power from a cell
/obj/item/stock_parts/fc/use(amount, can_explode = TRUE)
	if(rigged && amount > 0 && can_explode)
		explode()
		return 0
	if(charge < amount)
		return 0
	charge = (charge - amount)
	if(!istype(loc, /obj/machinery/power/apc))
		SSblackbox.record_feedback("tally", "cell_used", 1, type)
	return 1

// recharge the cell
/obj/item/stock_parts/fc/proc/give(amount)
	if(rigged && amount > 0)
		explode()
		return 0
	if(maxcharge < amount)
		amount = maxcharge
	var/power_used = min(maxcharge-charge,amount)
	charge += power_used
	return power_used

/obj/item/stock_parts/fc/examine(mob/user)
	. = ..()
	if(rigged)
		to_chat(user, "<span class='danger'>This power cell seems to be faulty!</span>")
	else
		to_chat(user, "The charge meter reads [round(src.percent() )]%.")

/obj/item/stock_parts/fc/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is licking the electrodes of [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (FIRELOSS)

/obj/item/stock_parts/fc/on_reagent_change(changetype)
	..()
	rigged = reagents?.has_reagent(/datum/reagent/toxin/plasma, 5) ? TRUE : FALSE //has_reagent returns the reagent datum

/obj/item/stock_parts/fc/proc/explode()
	var/turf/T = get_turf(src.loc)
	if (charge==0)
		return
	var/devastation_range = -1 //round(charge/11000)
	var/heavy_impact_range = round(sqrt(charge)/60)
	var/light_impact_range = round(sqrt(charge)/30)
	var/flash_range = light_impact_range
	if (light_impact_range==0)
		rigged = FALSE
		corrupt()
		return
	//explosion(T, 0, 1, 2, 2)
	explosion(T, devastation_range, heavy_impact_range, light_impact_range, flash_range)
	qdel(src)

/obj/item/stock_parts/fc/proc/corrupt()
	charge /= 2
	maxcharge = max(maxcharge/2, chargerate)
	if (prob(10))
		rigged = TRUE //broken batterys are dangerous

/obj/item/stock_parts/fc/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	charge -= 10 * severity
	if(charge < 0)
		charge = 0

/obj/item/stock_parts/fc/ex_act(severity, target)
	..()
	if(!QDELETED(src))
		switch(severity)
			if(2)
				if(prob(50))
					corrupt()
			if(3)
				if(prob(25))
					corrupt()

/obj/item/stock_parts/fc/attack_self(mob/user)
	if(isethereal(user))
		var/mob/living/carbon/human/H = user
		if(charge < 100)
			to_chat(H, "<span class='warning'>The [src] doesn't have enough power!</span>")
			return
		var/obj/item/organ/stomach/ethereal/stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
		if(stomach.crystal_charge > 146)
			to_chat(H, "<span class='warning'>Your charge is full!</span>")
			return
		to_chat(H, "<span class='notice'>You clumsily channel power through the [src] and into your body, wasting some in the process.</span>")
		if(do_after(user, 5, target = src))
			if((charge < 100) || (stomach.crystal_charge > 146))
				return
			if(istype(stomach))
				to_chat(H, "<span class='notice'>You receive some charge from the [src].</span>")
				stomach.adjust_charge(3)
				charge -= 100 //you waste way more than you receive, so that ethereals cant just steal one cell and forget about hunger
			else
				to_chat(H, "<span class='warning'>You can't receive charge from the [src]!</span>")
		return

/obj/item/stock_parts/fc/blob_act(obj/structure/blob/B)
	ex_act(EXPLODE_DEVASTATE)

/obj/item/stock_parts/fc/proc/get_electrocute_damage()
	if(charge >= 1000)
		return clamp(round(charge/10000), 10, 90) + rand(-5,5)
	else
		return 0

/obj/item/stock_parts/fc/get_part_rating()
	return rating * maxcharge

/obj/item/stock_parts/fc/empty
	start_charged = FALSE

/obj/item/stock_parts/fc/high
	name = "Expanded Fusion Core"
	icon_state = "hcell"
	maxcharge = 70000
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=200, /datum/material/uranium=5000)
	chargerate = 1500

/obj/item/stock_parts/fc/high/empty
	start_charged = FALSE