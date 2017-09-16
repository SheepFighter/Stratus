//KEEP IN MIND: These are different from gun/grenadelauncher. These are designed to shoot premade rocket and grenade projectiles, not flashbangs or chemistry casings etc.
//Put handheld rocket launchers here if someone ever decides to make something so hilarious ~Paprika

/obj/item/weapon/gun/projectile/revolver/grenadelauncher//this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	desc = "A break-operated grenade launcher."
	name = "grenade launcher"
	icon_state = "dshotgun-sawn"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	w_class = 3

/obj/item/weapon/gun/projectile/revolver/grenadelauncher/attackby(var/obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		chamber_round()
		update_icon()

/obj/item/weapon/gun/projectile/revolver/grenadelauncher/custom
	desc = "A break-operated grenade launcher."
	name = "grenade launcher"
	icon_state = "grenadelauncher"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher2
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/weapon/gun/projectile/revolver/grenadelauncher/custom/update_icon()
	icon_state = "[initial(icon_state)][chambered? "" : "-e"]"
	overlays.Cut()
	if(chambered)
		if(istype(chambered, /obj/item/ammo_casing/grenade/he))
			overlays += image(icon = icon, icon_state = "grenadeblue")
		else if(istype(chambered, /obj/item/ammo_casing/grenade/tear))
			overlays += image(icon = icon, icon_state = "grenadered")
		else
			overlays += image(icon = icon, icon_state = "grenadewhite")

/obj/item/weapon/gun/projectile/revolver/grenadelauncher/multi
	desc = "A revolving 6-shot grenade launcher."
	name = "multi grenade launcher"
	icon_state = "bulldog"
	item_state = "bulldog"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/grenadelauncher/multi

/obj/item/weapon/gun/projectile/revolver/grenadelauncher/multi/cyborg
	desc = "A 6-shot grenade launcher."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_grenadelnchr"

/obj/item/weapon/gun/projectile/revolver/grenadelauncher/multi/cyborg/attack_self()
	return

/obj/item/weapon/gun/projectile/automatic/gyropistol
	name = "gyrojet pistol"
	desc = "A prototype pistol designed to fire self propelled rockets."
	icon_state = "gyropistol"
	fire_sound = 'sound/effects/Explosion1.ogg'
	origin_tech = "combat=3"
	mag_type = /obj/item/ammo_box/magazine/m75
	burst_size = 1
	fire_delay = 0
	actions_types = list()

/obj/item/weapon/gun/projectile/automatic/gyropistol/isHandgun()
	return 1

/obj/item/weapon/gun/projectile/automatic/gyropistol/process_chamber(eject_casing = 0, empty_chamber = 1)
	..()

/obj/item/weapon/gun/projectile/automatic/gyropistol/update_icon()
	..()
	icon_state = "[initial(icon_state)][magazine ? "loaded" : ""]"
	return

/obj/item/weapon/gun/projectile/automatic/speargun
	name = "kinetic speargun"
	desc = "A weapon favored by carp hunters. Fires specialized spears using kinetic energy."
	icon_state = "speargun"
	item_state = "speargun"
	w_class = 4
	force = 10
	can_suppress = 0
	mag_type = /obj/item/ammo_box/magazine/internal/speargun
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	burst_size = 1
	fire_delay = 0
	select = 0
	actions_types = list()

/obj/item/weapon/gun/projectile/automatic/speargun/update_icon()
	return

/obj/item/weapon/gun/projectile/automatic/speargun/attack_self()
	return

/obj/item/weapon/gun/projectile/automatic/speargun/process_chamber(eject_casing = 0, empty_chamber = 1)
	..()

/obj/item/weapon/gun/projectile/automatic/speargun/attackby(obj/item/A, mob/user, params)
	var/num_loaded = magazine.attackby(A, user, params, 1)
	if(num_loaded)
		to_chat(user, "<span class='notice'>You load [num_loaded] spear\s into \the [src].</span>")
		update_icon()
		chamber_round()
/obj/item/weapon/gun/projectile/automatic/speargun/launcher
	desc = "A caseless front loading rocket launcher."
	name = "rocket launcher"
	icon_state = "launcher2"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/launcher
	w_class = WEIGHT_CLASS_BULKY
	origin_tech = "combat=4;engineering=4"


/obj/item/weapon/gun/projectile/automatic/speargun/launcher/attackby(obj/item/A, mob/user, params)
	if(!chambered)
		var/num_loaded = magazine.attackby(A, user, params, 1)
		if(num_loaded)
			to_chat(user, "<span class='notice'>You load [num_loaded] rockets\s into \the [src].</span>")
			chamber_round()
			update_icon()

/obj/item/weapon/gun/projectile/automatic/speargun/launcher/update_icon()
	overlays.Cut()
	if(chambered)
		if(istype(chambered, /obj/item/ammo_casing/rocket2/heat))
			overlays += image(icon = icon, icon_state = "rocketheat", pixel_x = 5)
		else if(istype(chambered, /obj/item/ammo_casing/rocket2/he))
			overlays += image(icon = icon, icon_state = "rocketblue", pixel_x = 5)
		else if(istype(chambered, /obj/item/ammo_casing/rocket2/emp))
			overlays += image(icon = icon, icon_state = "rocketemp", pixel_x = 5)
		else
			overlays += image(icon = icon, icon_state = "rocketplain", pixel_x = 5)

/obj/item/weapon/gun/projectile/automatic/speargun/launcher/attack_self(mob/living/user)
	var/num_unloaded = 0
	if(chambered)
		var/obj/item/ammo_casing/CB
		CB = chambered
		chambered = null
		CB.loc = get_turf(loc)
		CB.update_icon()
		num_unloaded++
	if(num_unloaded)
		to_chat(user, "<span class = 'notice'>You break open \the [src] and unload a rocket.</span>")
	else
		to_chat(user, "<span class='notice'>[src] is empty.</span>")
	update_icon()