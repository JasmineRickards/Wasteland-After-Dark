//CONTROLS FACTION-UNIQUE DESIGNS AND TECHWEBS. _TECHWEB.DM IS WHERE THE NEW TECHWEB DATUMS ARE HANDLED\\
//THESE ARE VERY POWERFUL AND MUST BE BALANCED AS SUCH; AS THESE DESIGN DISKS CAN GIVE ANYONE THE ABILITY TO PRINT UNIQUE GEAR\\
//COMBAT MECHS, COMBAT MECH ITEMS/ETC GO THROUGH THIS!!\\

/datum/design/a40_grenade
	name = "40mm Grenades"
	id = "40mmgrenades"
	build_type = PROTOLATHE
	build_path = /obj/item/ammo_box/a40mm
	materials = list(/datum/material/iron = 20000, /datum/material/plasma = 5000)
	category = list("Ammo")

/datum/techweb_node/enclavetech //YOU ARE OUT OF UNIFORM SOLDIER, WHERE IS YOUR POWER ARMOR?!!
	id = "enclavetech"
	display_name = "Enclave Technology" //Yeah er, this is reason 2 get faction wiped for having
	description = "The cutting edge of pre-war and post-war technology. You have a feeling holding these designs as anyone other than the Enclave will lead to a bad time."
	hidden = TRUE
	design_ids = list("marauder_chassis", "marauder_torso", "marauder_head", "marauder_left_arm", "marauder_right_arm", "marauder_left_leg", "marauder_right_leg", "marauder_main",
	"marauder_peri", "marauder_targ", "marauder_armor", "40mmgrenades", "kickstart_nanites","factory_nanites","tinker_nanites","offline_nanites","synergy_nanites", "mech_pulse_rifle", "mech_breaching_missile_rack", "mech_missile_rack", "mech_breaching_missile_rack_ammo", "mech_missile_rack_ammo", "durand_chassis", "durand_torso", "durand_head", "durand_left_arm", "durand_right_arm", "durand_left_leg", "durand_right_leg", "durand_main",
	"durand_peri", "durand_targ", "durand_armor", "gygax_chassis", "gygax_torso", "gygax_head", "gygax_left_arm", "gygax_right_arm", "gygax_left_leg", "gygax_right_leg", "gygax_main",
	"gygax_peri", "gygax_targ", "gygax_armor", "fluxcap", "focusedlenses", "superconductor", "advreceiver", "preassembly", "superalloys") //Powerful. Losing this disk is massive.

/datum/techweb_node/bostech //BoStech for mechs/etc
	id = "bostech"
	display_name = "Brotherhood of Steel Technology" //Yeah er, this is reason 2 get faction wiped for having
	description = "A well-rounded and far-explored technological set of advancements. This is rather rare to have."
	hidden = TRUE
	design_ids = list("40mmgrenades", "mech_pulse_rifle", "mech_breaching_missile_rack", "mech_missile_rack", "mech_breaching_missile_rack_ammo", "mech_missile_rack_ammo", "durand_chassis", "durand_torso", "durand_head", "durand_left_arm", "durand_right_arm", "durand_left_leg", "durand_right_leg", "durand_main",
	"durand_peri", "durand_targ", "durand_armor", "gygax_chassis", "gygax_torso", "gygax_head", "gygax_left_arm", "gygax_right_arm", "gygax_left_leg", "gygax_right_leg", "gygax_main",
	"gygax_peri", "gygax_targ", "gygax_armor", "focusedlenses", "superconductor", "advreceiver", "superalloys") //BoS get less than the Enclave due to the fact they aren't 'as' advanced with pre-war replication.

/obj/item/disk/tech_disk/enclave
	name = "Enclave technology disk"
	desc = "This disk is patterned with the markings of the Central Intelligence Agency. You feel like having this is a dangerous idea."
	custom_materials = null

/obj/item/disk/tech_disk/abductor/Initialize()
	. = ..()
	stored_research = new /datum/techweb/enclave

/obj/item/disk/tech_disk/bostech
	name = "BoS technology disk"
	desc = "This disk is patterned with the markings of the Midwestern Brotherhood. You feel like having this is a dangerous idea."
	custom_materials = null

/obj/item/disk/tech_disk/abductor/Initialize()
	. = ..()
	stored_research = new /datum/techweb/bos

