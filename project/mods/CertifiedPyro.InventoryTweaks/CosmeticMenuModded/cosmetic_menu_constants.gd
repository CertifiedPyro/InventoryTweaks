extends Reference

const COSMETIC_ORDER := PoolStringArray([
	# -- BODY --
	# Species (skip)
	# Pattern (skip)
	# Primary color
	"pcolor_white",  # Default color
	"pcolor_salmon",
	"pcolor_pink_special",
	"pcolor_red",
	"pcolor_maroon",
	"pcolor_orange",
	"pcolor_yellow",
	"pcolor_olive",
	"pcolor_west",
	"pcolor_green",
	"pcolor_teal",
	"pcolor_blue",
	"pcolor_purple",
	"pcolor_tan",
	"pcolor_brown",
	"pcolor_grey",
	"pcolor_stone_special",
	"pcolor_black",
	"pcolor_midnight_special",
	# Secondary color
	"scolor_white",  # Default color
	"scolor_salmon",
	"scolor_pink_special",
	"scolor_red",
	"scolor_maroon",
	"scolor_orange",
	"scolor_yellow",
	"scolor_olive",
	"scolor_west",
	"scolor_green",
	"scolor_teal",
	"scolor_blue",
	"scolor_purple",
	"scolor_tan",
	"scolor_brown",
	"scolor_grey",
	"scolor_stone_special",
	"scolor_black",
	"scolor_midnight_special",
	# Tail (skip)
	
	# -- FACE --
	# Eyes
	"eye_halfclosed",  # Default eyes + variants
	"eye_dreaming",
	"eye_herbal",
	"eye_bagged",  # Unused??
	"eye_drained",  # Half-circle eyes
	"eye_annoyed",
	"eye_sassy",
	"eye_angry",
	"eye_focused",  # Focused + pleading eyes
	"eye_catsoup",
	"eye_plead",
	"eye_sad",
	"eye_alien",
	"eye_distraught",  # Animal eyes
	"eye_goat",
	"eye_froggy",
	"eye_dispondant",  # Cross-eyed eyes
	"eye_almond",
	"eye_harper",
	"eye_squared",  # Fierce-looking(?) eyes
	"eye_fierce",
	"eye_wings",
	"eye_serious",
	"eye_glance",  # Side eyes
	"eye_sideeye",
	"eye_glamor",  # Glamorous eyes
	"eye_glare",
	"eye_starlight",
	"eye_haunted",  # Spooky eyes
	"eye_possessed",
	"eye_inverted",
	"eye_closed",  # Line eyes
	"eye_lenny",
	"eye_jolly",
	"eye_x",
	"eye_spiral",
	"eye_scribble",
	"eye_dot",  # Dot eyes
	"eye_tired",
	"eye_wobble",
	# Nose
	"nose_none",
	"nose_cat",  # Filled noses
	"nose_dog",
	"nose_button",
	"nose_whisker",
	"nose_round",
	"nose_booger",
	"nose_pierced",
	"nose_pink",
	"nose_nostril",  # Line noses
	"nose_v",
	"nose_long",
	"nose_clown",  # Misc noses
	# Mouth
	"mouth_none",
	"mouth_default",  # Default mouth + variants
	"mouth_toothy",
	"mouth_sabertooth",
	"mouth_bucktoothed",
	"mouth_fishy",
	"mouth_animal",  # Animal mouths
	"mouth_toothier",
	"mouth_distraught",  # "Normal" line mouths
	"mouth_aloof",
	"mouth_smirk",
	"mouth_glad",
	"mouth_happy",
	"mouth_stitch",  # Weird line mouths?
	"mouth_squiggle",
	"mouth_chewing",
	"mouth_fangs",  # Fang mouths?
	"mouth_bite",
	"mouth_monster",
	"mouth_tongue",  # Tongue mouths
	"mouth_dead",
	"mouth_hymn",  # Open mouths
	"mouth_shocked",
	"mouth_drool",
	"mouth_grin",  # Teeth-showing mouths
	"mouth_grimace",
	"mouth_rabid",
	"mouth_braces",
	"mouth_jaws",
	
	# -- CLOTHES --
	# Hat
	"hat_none",
	"hat_baseball_cap_sports",  # Baseball caps
	"hat_baseball_cap_orange",
	"hat_baseball_cap_big",
	"hat_baseball_cap_green",
	"hat_baseball_cap_missing",
	"hat_baseball_cap_pee",
	"hat_baseball_cap_size",
	"hat_baseball_cap_exclaim",
	"hat_baseball_cap_mcd",
	"hat_bucket_green",  # Bucket hats
	"hat_bucket_tan",
	"hat_cowboyhat_pink",  # Cowboy hats
	"hat_cowboyhat_brown",
	"hat_cowboyhat_black",
	"hat_beanie_maroon",  # Beanies
	"hat_beanie_yellow",
	"hat_beanie_green",
	"hat_beanie_teal",
	"hat_beanie_blue",
	"hat_beanie_white",
	"hat_beanie_black",
	"hat_crown",  # Special hats
	"hat_tophat",
	# Undershirt
	"shirt_none",
	"undershirt_graphic_tshirt_soup",  # Graphic T-shirts
	"undershirt_graphic_tshirt_smokemon",
	"undershirt_graphic_tshirt_goodboy",
	"undershirt_graphic_tshirt_anchor",
	"undershirt_graphic_tshirt_dare",
	"undershirt_graphic_tshirt_hooklite",
	"undershirt_graphic_tshirt_burger",
	"undershirt_graphic_tshirt_milf",
	"undershirt_graphic_tshirt_threewolves",
	"undershirt_graphic_tshirt_nobait",
	"undershirt_graphic_tshirt_soscary",
	"undershirt_graphic_tshirt_gay",  # Graphic T-shirts (LGBT)
	"undershirt_graphic_tshirt_lesbian",
	"undershirt_graphic_tshirt_bi",
	"undershirt_graphic_tshirt_trans",
	"undershirt_graphic_tshirt_ace",
	"undershirt_graphic_tshirt_mlm",
	"undershirt_graphic_tshirt_nonbinary",
	"undershirt_graphic_tshirt_pan",
	"undershirt_tshirt_salmon",  # T-shirts
	"undershirt_tshirt_red",
	"undershirt_tshirt_maroon",
	"undershirt_tshirt_orange",
	"undershirt_tshirt_yellow",
	"undershirt_tshirt_olive",
	"undershirt_tshirt_green",
	"undershirt_tshirt_teal",
	"undershirt_tshirt_blue",
	"undershirt_tshirt_purple",
	"undershirt_tshirt_tan",
	"undershirt_tshirt_brown",
	"undershirt_tshirt_white",
	"undershirt_tshirt_grey",
	"undershirt_tshirt_black",
	"undershirt_tanktop_salmon",  # Tank tops
	"undershirt_tanktop_red",
	"undershirt_tanktop_maroon",
	"undershirt_tanktop_orange",
	"undershirt_tanktop_yellow",
	"undershirt_tanktop_olive",
	"undershirt_tanktop_green",
	"undershirt_tanktop_teal",
	"undershirt_tanktop_blue",
	"undershirt_tanktop_purple",
	"undershirt_tanktop_tan",
	"undershirt_tanktop_brown",
	"undershirt_tanktop_white",
	"undershirt_tanktop_grey",
	"undershirt_tanktop_black",
	# Overshirt
	"overshirt_none",  # Default
	"overshirt_flannel_open_salmon",  # Flannels (open)
	"overshirt_flannel_open_red",
	"overshirt_flannel_open_yellow",	
	"overshirt_flannel_open_olive",
	"overshirt_flannel_open_green",
	"overshirt_flannel_open_teal",
	"overshirt_flannel_open_blue",
	"overshirt_flannel_open_purple",
	"overshirt_flannel_open_white",
	"overshirt_flannel_open_black",
	"overshirt_flannel_closed_salmon",  # Flannels (closed)
	"overshirt_flannel_closed_red",
	"overshirt_flannel_closed_yellow",	
	"overshirt_flannel_closed_olive",
	"overshirt_flannel_closed_green",
	"overshirt_flannel_closed_teal",
	"overshirt_flannel_closed_blue",
	"overshirt_flannel_closed_purple",
	"overshirt_flannel_closed_white",
	"overshirt_flannel_closed_black",
	"overshirt_sweatshirt_salmon",  # Hoodies
	"overshirt_sweatshirt_red",
	"overshirt_sweatshirt_maroon",
	"overshirt_sweatshirt_orange",
	"overshirt_sweatshirt_yellow",
	"overshirt_sweatshirt_olive",
	"overshirt_sweatshirt_green",
	"overshirt_sweatshirt_teal",
	"overshirt_sweatshirt_blue",
	"overshirt_sweatshirt_purple",
	"overshirt_sweatshirt_tan",
	"overshirt_sweatshirt_brown",
	"overshirt_sweatshirt_white",
	"overshirt_sweatshirt_grey",
	"overshirt_sweatshirt_black",
	"overshirt_vest_olive",  # Vests
	"overshirt_vest_green",
	"overshirt_vest_tan",
	"overshirt_vest_grey",
	"overshirt_vest_black",
	"overshirt_overall_yellow",  # Overalls
	"overshirt_overall_olive",
	"overshirt_overall_green",
	"overshirt_overall_tan",
	"overshirt_overall_brown",
	"overshirt_overall_grey",
	"overshirt_labcoat",  # Misc
	"overshirt_trenchcoat",
	# Legs
	"legs_none",
	"legs_pants_long_salmon",  # Long pants
	"legs_pants_long_red",
	"legs_pants_long_maroon",
	"legs_pants_long_orange",
	"legs_pants_long_yellow",
	"legs_pants_long_olive",
	"legs_pants_long_green",
	"legs_pants_long_teal",
	"legs_pants_long_blue",
	"legs_pants_long_purple",
	"legs_pants_long_tan",
	"legs_pants_long_brown",
	"legs_pants_long_white",
	"legs_pants_long_grey",
	"legs_pants_long_black",
	"legs_pants_short_salmon",  # Short pants
	"legs_pants_short_red",
	"legs_pants_short_maroon",
	"legs_pants_short_orange",
	"legs_pants_short_yellow",
	"legs_pants_short_olive",
	"legs_pants_short_green",
	"legs_pants_short_teal",
	"legs_pants_short_blue",
	"legs_pants_short_purple",
	"legs_pants_short_tan",
	"legs_pants_short_brown",
	"legs_pants_short_white",
	"legs_pants_short_grey",
	"legs_pants_short_black",
	# Accessories
	"accessory_antlers",  # Head
	"accessory_glasses",
	"accessory_glasses_round",
	"accessory_shades",
	"accessory_shades_gold",
	"accessory_eyepatch",
	"accessory_monocle",
	"accessory_bandaid",
	"accessory_cig",
	"accessory_collar",
	"accessory_collar_bell",
	"accessory_gloves_black",  # Hand
	"accessory_hook",
	"accessory_ring",
	"accessory_watch",
	"accessory_sword",  # Waist
	"accessory_rain_boots_yellow",  # Feet
	"accessory_rain_boots_green",
	"accessory_shoes",
	"accessory_alien_particles",  # Particles
	"accessory_goldsparkle_particles",
	"accessory_heart_particles",
	"accessory_sparkle_particles",
	"accessory_stink_particles",
	
	# -- MISC --
	# Title
	"title_none",
	"title_rank_1",  # Rank titles
	"title_rank_5",
	"title_rank_10",
	"title_rank_15",
	"title_rank_20",
	"title_rank_25",
	"title_rank_30",
	"title_rank_35",
	"title_rank_40",
	"title_rank_45",
	"title_rank_50",
	"title_equalsthree",  # :3
	"title_ace",
	"title_ancient",
	"title_bi",
	"title_bipedalanimaldrawer",
	"title_cadaverdog",
	"title_catfisher",
	"title_cozy",
	"title_creature",
	"title_critter",
	"title_cryptid",
	"title_dude",
	"title_elite",
	"title_lamedev",  # Fake Lamedev
	"title_fishpilled",
	"title_freaky",
	"title_gay",
	"title_goober",
	"title_goodboy",
	"title_goodgirl",
	"title_iscool",
	"title_king",
	"title_kitten",
	"title_koiboy",
	"title_lamedev_real",
	"title_lesbian",
	"title_littlelad",
	"title_majestic",
	"title_musky",
	"title_nightcrawler",
	"title_nonbinary",
	"title_imnormal",  # Normal and Regular
	"title_pan",
	"title_pretty",
	"title_problematic",
	"title_pup",
	"title_puppy",
	"title_queer",
	"title_sharkbait",
	"title_shithead",
	"title_sillyguy",
	"title_soggy",
	"title_special",
	"title_stinkerdinker",
	"title_straight",
	"title_strongestwarrior",
	"title_stupididiotbaby",
	"title_trans",
	"title_goldenbass",  # Title for those...
	"title_goldenray",  # Title for those...
	"title_yapper",
	# Bobber
	"bobber_default",
	"bobber_slip",
	"bobber_ducky",
	"bobber_lilypad",
	"bobber_bomb",
])
