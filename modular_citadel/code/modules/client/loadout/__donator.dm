//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/belt/holster/ranger45
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	cost = 0

/datum/gear/donator/kits/tessa
    name ="Scourge custom whip"
    path = /obj/item/storage/box/large/custom_kit/sadismbox
    ckeywhitelist = list ("abelshift")

/obj/item/storage/box/large/custom_kit/sadismbox/PopulateContents()
    new /obj/item/melee/onehanded/scourge(src)

/datum/gear/donator/kits/abel
    name ="modified NCRCF jacket"
    path = /obj/item/storage/box/large/custom_kit/ncrcfbox
    ckeywhitelist = list ("abelshift")

/obj/item/storage/box/large/custom_kit/ncrcfbox/PopulateContents()
    new /obj/item/clothing/suit/toggle/labcoat/abeljacket(src)

/datum/gear/donator/kits/bella
    name ="Bella's Fieldcoat"
    path = /obj/item/storage/box/large/custom_kit/bellacoatbox
    ckeywhitelist = list ("abelshift")

/obj/item/storage/box/large/custom_kit/bellacoatbox/PopulateContents()
    new /obj/item/clothing/suit/armor/f13/ncrarmor/bellacoat(src)

/datum/gear/donator/kits/kemble
    name = "Trinity Kemble's belongings"
    path = /obj/item/storage/box/large/custom_kit/kemble
    ckeywhitelist = list("yeehawguvnah")

/obj/item/storage/box/large/custom_kit/kemble/PopulateContents()
    new /obj/item/modkit/kemblevest(src)
    new /obj/item/modkit/kemblehat(src)
    new /obj/item/storage/belt/holster/kemble(src)