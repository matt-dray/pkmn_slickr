# Prepare Pokemon data and sprites
# Matt Dray, February 2020

# Packages ----------------------------------------------------------------

library(dplyr)

# Table of Pokemon --------------------------------------------------------

# Table of first gen Pokemon with numbers, names, link to Bulbapedia and source
# for sprite images

pkmn <- tibble(
  ndex_num = 1:151,
  ndex_char = c(
    "001", "002", "003", "004", "005", "006", "007", "008", "009", "010",
    "011", "012", "013", "014", "015", "016", "017", "018", "019", "020",
    "021", "022", "023", "024", "025", "026", "027", "028", "029", "030",
    "031", "032", "033", "034", "035", "036", "037", "038", "039", "040",
    "041", "042", "043", "044", "045", "046", "047", "048", "049", "050",
    "051", "052", "053", "054", "055", "056", "057", "058", "059", "060",
    "061", "062", "063", "064", "065", "066", "067", "068", "069", "070",
    "071", "072", "073", "074", "075", "076", "077", "078", "079", "080",
    "081", "082", "083", "084", "085", "086", "087", "088", "089", "090",
    "091", "092", "093", "094", "095", "096", "097", "098", "099", "100",
    "101", "102", "103", "104", "105", "106", "107", "108", "109", "110",
    "111", "112", "113", "114", "115", "116", "117", "118", "119", "120",
    "121", "122", "123", "124", "125", "126", "127", "128", "129", "130",
    "131", "132", "133", "134", "135", "136", "137", "138", "139", "140",
    "141", "142", "143", "144", "145", "146", "147", "148", "149", "150",
    "151"
  ),
  name = c(
    "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon",
    "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod",
    "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto",
    "Pidgeot", "Rattata", "Raticate", "Spearow", "Fearow", "Ekans", "Arbok",
    "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran♀", "Nidorina",
    "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking", "Clefairy", "Clefable",
    "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff", "Zubat", "Golbat",
    "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat",
    "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck",
    "Golduck", "Mankey", "Primeape", "Growlithe", "Arcanine", "Poliwag",
    "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop",
    "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel",
    "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta",
    "Rapidash", "Slowpoke", "Slowbro", "Magnemite", "Magneton", "Farfetch'd",
    "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk", "Shellder",
    "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno",
    "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor",
    "Cubone", "Marowak", "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing",
    "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan",
    "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime",
    "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp",
    "Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon",
    "Porygon", "Omanyte", "Omastar", "Kabuto", "Kabutops", "Aerodactyl",
    "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini", "Dragonair",
    "Dragonite", "Mewtwo", "Mew"
  )
) %>% 
  mutate(
    url = paste0("https://bulbapedia.bulbagarden.net/wiki/", name, "_(Pok%C3%A9mon)"),
    sprite_front_src = paste0("data/sprites/front/", ndex_num, ".png"),
    sprite_back_src = paste0("data/sprites/back/", ndex_num, ".png"),
  )

# Organise evolutionary chains --------------------------------------------

# Within each 'page' I want to show each evolutionary chain. This means I'll
# be showing three Pokemon maximum, since this is the longest chain (e.g. 
# Bulbasaur, Ivysaur, Venusaur). But some chains are length one or two, so
# I'm gong to introduce a 'blank' to pad these 'pages'.

# Blank for padding evolutionary chains of length < 3
blank <- tibble(
  ndex_num = NA_integer_,
  ndex_char = "",
  name = "",
  url = NA_character_,
  sprite_src = NA_character_
)

# Create second version of the main data set where blanks are introduced to pad
# each evolutionary chain to length 3.
pkmn2 <- bind_rows(
  slice(pkmn, 1:3),  # Bulbasaur, Ivysaur, Venusaur
  slice(pkmn, 4:6),
  slice(pkmn, 7:9),
  slice(pkmn, 10:12),
  slice(pkmn, 13:15),
  slice(pkmn, 16:18),
  slice(pkmn, 19:20), blank,  # Rattata, Raticate, [blank]
  slice(pkmn, 21:22), blank,
  slice(pkmn, 23:24), blank,
  slice(pkmn, 25:26), blank,
  slice(pkmn, 27:28), blank,
  slice(pkmn, 29:31),
  slice(pkmn, 32:34),
  slice(pkmn, 35:36), blank,
  slice(pkmn, 37:38), blank,
  slice(pkmn, 39:40), blank,
  slice(pkmn, 41:42), blank,
  slice(pkmn, 43:45),
  slice(pkmn, 46:47), blank,
  slice(pkmn, 48:49), blank,
  slice(pkmn, 50:51), blank,
  slice(pkmn, 52:53), blank,
  slice(pkmn, 54:55), blank,
  slice(pkmn, 56:57), blank,
  slice(pkmn, 58:59), blank,
  slice(pkmn, 60:62),
  slice(pkmn, 63:65),
  slice(pkmn, 66:68),
  slice(pkmn, 69:71),
  slice(pkmn, 72:73), blank,
  slice(pkmn, 74:76),
  slice(pkmn, 77:78), blank,
  slice(pkmn, 79:80), blank,
  slice(pkmn, 81:82), blank,
  slice(pkmn, 83), blank, blank,  # Farfetch'd, [blank], [blank]
  slice(pkmn, 84:85), blank,
  slice(pkmn, 86:87), blank,
  slice(pkmn, 88:89), blank,
  slice(pkmn, 90:91), blank,
  slice(pkmn, 92:94),
  slice(pkmn, 95), blank, blank,
  slice(pkmn, 96:97), blank,
  slice(pkmn, 98:99), blank,
  slice(pkmn, 100:101), blank,
  slice(pkmn, 102:103), blank,
  slice(pkmn, 104:105), blank,
  slice(pkmn, 106), blank, blank,
  slice(pkmn, 107), blank, blank,
  slice(pkmn, 108), blank, blank,
  slice(pkmn, 109:110), blank,
  slice(pkmn, 111:112), blank,
  slice(pkmn, 113), blank, blank,
  slice(pkmn, 114), blank, blank,
  slice(pkmn, 115), blank, blank,
  slice(pkmn, 116:117), blank,
  slice(pkmn, 118:119), blank,
  slice(pkmn, 120:121), blank,
  slice(pkmn, 122), blank, blank,
  slice(pkmn, 123), blank, blank,
  slice(pkmn, 124), blank, blank,
  slice(pkmn, 125), blank, blank,
  slice(pkmn, 126), blank, blank,
  slice(pkmn, 127), blank, blank,
  slice(pkmn, 128), blank, blank,
  slice(pkmn, 129:130), blank,
  slice(pkmn, 131), blank, blank,
  slice(pkmn, 132), blank, blank,
  slice(pkmn, 133:134), blank, 
  slice(pkmn, c(133, 135)), blank, 
  slice(pkmn, c(133, 136)), blank, 
  slice(pkmn, 137), blank, blank,
  slice(pkmn, 138:139), blank,
  slice(pkmn, 140:141), blank,
  slice(pkmn, 142), blank, blank,
  slice(pkmn, 143), blank, blank,
  slice(pkmn, 144), blank, blank,
  slice(pkmn, 145), blank, blank,
  slice(pkmn, 146), blank, blank,
  slice(pkmn, 147:149),
  slice(pkmn, 150), blank, blank,
  slice(pkmn, 151), blank, blank
)

# Numbers for the first evolution in each chain. The front-sprite will be used
# as 'page dots' so users can jumo to the evolutionary chain starting with that
# Pokemon. 
start_evo_sprite <- pkmn[c(
  1, 4, 7, 10, 13, 16, 19, 21, 23, 25, 27, 29, 32, 35, 37, 39, 41, 43, 46, 48,
  50, 52, 54, 56, 58, 60, 63, 66, 69, 72, 74, 77, 79, 81, 83, 84, 86, 88, 90, 92,
  95, 96, 98, 100, 102, 104, 106, 107, 108, 109, 111, 113, 114, 115, 116, 118,
  120, 122, 123, 124, 125, 126, 127, 128, 129, 131, 132, 133, 133, 133, 137, 138,
  140, 142, 143, 144, 145, 146, 147, 150, 151
), "sprite_front_src"][[1]]

