/datum/job/bos/f13protectoratecivilian
	title = "Protectorate Civilian"
	flag = F13PROTECTORATECIVI
	total_positions = 3 //Do not give this area more than 10 people max. We do not want it taking away players from other roles.
	spawn_positions = 3
	description = "While you may be either apart of the Brotherhood, or merely apart of the dominion they rule over; you are still a civilian! You are not required nor encouraged to participate in bunker duties nor raids. You should only be acting in self-defense."
	supervisors = "Yourself, the Town Guard, and the Brotherhood."
	selection_color = "#95a5a6"
	roleplay_exclusive_notify = 1
	exp_requirements = 100 //Barely need any, as this is equivalent to a townie.
	outfit = /datum/outfit/job/bos/f13protectoratecivilian
	access = list(ACCESS_BOS_CIVILIAN,ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR)
	minimal_access = list(ACCESS_BOS_CIVILIAN,ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR)

/datum/outfit/job/bos/f13protectoratecivilian
	name = "Protectorate Civilian"
	jobtype = /datum/job/bos/f13protectoratecivilian
	backpack = /obj/item/storage/backpack/satchel
	ears = 			/obj/item/radio/headset
	uniform =		/obj/item/clothing/under/syndicate
	belt = 			/obj/item/storage/belt/military/army
	shoes = 		/obj/item/clothing/shoes/combat
	gloves = 		/obj/item/clothing/gloves/combat
	id = 			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1,
		/obj/item/encryptionkey/headset_bos_civi=1,
		/obj/item/melee/onehanded/knife/survival=1
		)

/datum/job/bos/f13protectorateshopkeep
	title = "Protectorate Shopkeeper"
	flag = F13PROTECTORATESHOP
	total_positions = 1
	spawn_positions = 1
	description = "While you may be either apart of the Brotherhood, or merely apart of the dominion they rule over; you are still a shopkeep! You are not required nor encouraged to participate in bunker duties nor raids. You should only be acting in self-defense."
	supervisors = "Yourself, the Town Guard, and the Brotherhood."
	selection_color = "#95a5a6"
	roleplay_exclusive_notify = 1
	exp_requirements = 150 //Higher, as this gets shop access..
	outfit = /datum/outfit/job/bos/f13protectorateshopkeep
	access = list(ACCESS_BOS_CIVILIAN,ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_CARGO_BOT)
	minimal_access = list(ACCESS_BOS_CIVILIAN,ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_CARGO_BOT)

/datum/outfit/job/bos/f13protectorateshopkeep
	name = "Protectorate Shopkeep"
	jobtype = /datum/job/bos/f13protectorateshopkeep
	backpack = /obj/item/storage/backpack/satchel
	ears = 			/obj/item/radio/headset
	uniform =		/obj/item/clothing/under/syndicate
	belt = 			/obj/item/storage/belt/military/army
	shoes = 		/obj/item/clothing/shoes/combat
	gloves = 		/obj/item/clothing/gloves/combat
	id = 			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1,
		/obj/item/encryptionkey/headset_bos_civi=1,
		/obj/item/melee/onehanded/knife/survival=1
		)

/datum/outfit/job/bos/f13protectorateshopkeep/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE) //Copy + Paste of regular shopkeep stuff cuz no loadout suggestions
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policepistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steelbib/heavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/armyhelmetheavy)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/trail_carbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lever_action)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/a180)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/varmintrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingshotgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/thatgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/uzi)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/smg10mm)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/frag_shrapnel)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/concussion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/explosive/shrapnelmine)


/datum/job/bos/f13protectoratedoctor
	title = "Protectorate Doctor"
	flag = F13PROTECTORATEDOC
	total_positions = 2
	spawn_positions = 2
	description = "While you may be either apart of the Brotherhood, or merely apart of the dominion they rule over; you are still a Doctor! You are a noncombative, and should only act in immediate self defense."
	supervisors = "Yourself, the Town Guard, and the Brotherhood."
	selection_color = "#95a5a6"
	roleplay_exclusive_notify = 1
	exp_requirements = 200 //Ditto
	outfit = /datum/outfit/job/bos/f13protectoratedoctor
	access = list(ACCESS_BOS_CIVILIAN,ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_MEDICAL, ACCESS_MEDICAL_F13)
	minimal_access = list(ACCESS_BOS_CIVILIAN,ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_MEDICAL, ACCESS_MEDICAL_F13)

/datum/outfit/job/bos/f13protectoratedoctor
	name = "Protectorate Doctor"
	jobtype = /datum/job/bos/f13protectoratedoctor
	backpack = /obj/item/storage/backpack/medic
	ears = 			/obj/item/radio/headset
	uniform =		/obj/item/clothing/under/syndicate
	suit = 			/obj/item/clothing/suit/toggle/labcoat
	belt = 			/obj/item/storage/belt/military/army
	shoes = 		/obj/item/clothing/shoes/combat
	mask =	/obj/item/clothing/mask/surgical
	gloves =	/obj/item/clothing/gloves/color/latex/nitrile
	glasses =	/obj/item/clothing/glasses/hud/health
	id = 			/obj/item/card/id/dogtag
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 2,
		/obj/item/reagent_containers/medspray/synthflesh = 1,
		/obj/item/storage/firstaid = 1,
		/obj/item/encryptionkey/headset_bos_civi=1,
		)

/datum/outfit/job/bos/f13protectoratedoctor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_MEDICALGRADUATE, src)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_RESEARCHER, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)

/datum/job/bos/f13protectoratescribe
	title = "Protectorate Scribe"
	flag = F13PROTECTORATESCRIBE
	total_positions = 3
	spawn_positions = 3
	description = "You answer directly to the Brotherhood Scribes, and are tasked with assisting in their duties, bar combatative interactions."
	supervisors = "Brotherhood Scribes, The Librarian."
	selection_color = "#95a5a6"

	exp_requirements = 150

	outfit = /datum/outfit/job/bos/f13protectoratescribe
	access = list(ACCESS_BOS_CIVILIAN, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_ROBOTICS)
	minimal_access = list(ACCESS_BOS_CIVILIAN, ACCESS_HYDROPONICS, ACCESS_KITCHEN, ACCESS_BAR, ACCESS_ROBOTICS)

/datum/outfit/job/bos/f13protectoratescribe
	name = "Protectorate Scribe"
	jobtype = /datum/job/bos/f13protectoratescribe
	chemwhiz = TRUE
	uniform =		/obj/item/clothing/under/syndicate/brotherhood
	shoes = 		/obj/item/clothing/shoes/combat
	belt = 			/obj/item/storage/belt/utility/full/engi
	suit = 			/obj/item/clothing/suit/f13/scribe
	id = 			/obj/item/card/id/dogtag
	glasses =		/obj/item/clothing/glasses/sunglasses/big
	backpack_contents = list(
		/obj/item/storage/firstaid/regular=1,
		/obj/item/encryptionkey/headset_bos_civi=1,
		)

/datum/outfit/job/bos/f13protectoratescribe/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)
	ADD_TRAIT(H, TRAIT_MEDICALGRADUATE, src)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_RESEARCHER, src)
	//ADD_TRAIT(H, TRAIT_POOR_AIM, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/AER9)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/AEP7)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/dks)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/R93)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
