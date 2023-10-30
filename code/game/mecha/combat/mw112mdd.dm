/*	MW-115mdd
*/

/obj/mecha/combat/mw112mdd
	name = "\improper MW t-112mdd"
	desc = "A versatile midwestern vehicle designed to provide fire support regardless of terrain."
	icon_state = "mw_112mdd"
	step_in = 2.5
	dir_in = 1 //Facing North.
	max_integrity = 350
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 25, "bomb" = 15, "bio" = 0, "rad" = 75, "fire" = 100, "acid" = 100)
	wreckage = /obj/structure/mecha_wreckage/mw112mdd
	internal_damage_threshold = 20
	step_energy_drain = 30
	canstrafe = TRUE
//	base_color = "#837A43"