library(tidyverse)
library(readxl)
library(redcapAPI)
library(fastDummies)
setwd("C:/Users/timvigers/OneDrive - The University of Colorado Denver/Vigers/BDC/Janet Snell-Bergeon/PROMISE")
# Import FFQ data from REDCap
unlockREDCap(c(rcon = "The PROMISE Study"),
  keyring = "API_KEYs",
  envir = 1,
  url = "https://redcap.ucdenver.edu/api/"
)
ffqs <- exportReportsTyped(rcon, report_id = 119506)
# Import nutrient tables
cereal <- read_excel("./Data_Raw/CEREAL-NUTRIENT-TABLE-2022_Updated.xlsx")
food <- read_excel("./Data_Raw/Nutrient Tables/FOOD-NUTRIENT-TABLE-2022.xlsx")
marg <- read_excel("./Data_Raw/Nutrient Tables/Margarine-Nutrient-Table-2022.xlsx")
oil <- read_excel("./Data_Raw/Oil-Nutrient-Table-2022_Updated.xlsx")
oxalates <- read_excel("./Data_Raw/Nutrient Tables/OXALATE-TABLE.xlsx")
vitamins <- read_excel("./Data_Raw/Nutrient Tables/VITAMIN-NUTRIENT-TABLE-2022.xlsx")
#-------------------------------------------------------------------------------
# Vitamins
#-------------------------------------------------------------------------------
# Prepare the numeric columns
# I can't think of a more efficient way to do this, so for now it'll have to do
levels(ffqs$how_many_multi_vitamins_do) <- c(1 / 7, 4 / 7, 7.5 / 7, 10 / 7)
ffqs$how_many_multi_vitamins_do <-
  as.numeric(as.character(ffqs$how_many_multi_vitamins_do))
ffqs$how_many_multi_vitamins_do[is.na(ffqs$how_many_multi_vitamins_do)] <- 0
#-------------------------------------------------------------------------------
# Cereal
#-------------------------------------------------------------------------------
# Link the REDCap levels to the cereal nutrient data
cereal_map <- list(
  "b.40%.P" = "BRAN FLAKES, POST",
  "b.all" = "ALL BRAN, KELLOGGS",
  "basic4" = "BASIC 4 CEREAL",
  "c.chex" = "CORN CHEX",
  "c.flk.K" = "CORN FLAKES",
  "capn" = "CAP'N CRUNCH, QUAKER",
  "cheerio" = "CHEERIOS, GENERAL MILLS",
  "cheerio.hn" = "HONEY NUT CHEERIOS, GENERAL MILLS",
  "cheerio.mg" = "CHEERIOS MULTIGRAIN, GENERAL MILLS",
  "cintstcr" = "CINNAMON TOAST CRUNCH",
  "co.peb" = "COCOA PEBBLES",
  "co.puff" = "COCOA PUFFS CEREAL",
  "crack.o.b" = "CRACKLIN OAT BRAN",
  "cran.alm.cr" = "GREAT GRAINS CRANBERRY ALMOND CRUNCH",
  "crispix" = "CRISPIX,  KELLOGG'S",
  "fiber" = "FIBER ONE",
  "fiber.hon" = "FIBER ONE HONEY CLUSTERS",
  "fr.flk" = "FROSTED FLAKES",
  "fr.miniwht" = "FROSTED MINIWHEATS",
  "frt.loop" = "FROOT LOOPS CEREAL",
  "great.grainrzdp" = "GREAT GRAINS,RAISIN,DATE & PECAN, POST",
  "great.grains" = "GREAT GRAINS CRUNCHY PECAN, POST",
  "grpnut" = "GRAPE-NUTS, POST",
  "hon.bun.oat.a" = "HONEY BUNCHES OF OATS,W/ ALMONDS, POST",
  "hon.bun.oats" = "HONEY BUNCHES OF OATS, HONEY, POST",
  "kashi.aut.wht" = "KASHI AUTUMN WHEAT CEREAL",
  "kashi.go.lean" = "KASHI GO",
  "kashi.heart" = "KASHI HEART TO HEART",
  "krave" = "CHOCOLATE KRAVE",
  "life" = "QUAKER OAT LIFE, PLAIN",
  "lucky.ch" = "LUCKY CHARMS CEREAL",
  "natural.q" = "100% NAT GRANOLA,OATS,WHEAT & HONEY, QUAKER",
  "oatmeal.crisp" = "OATMEAL CRISP CRUNCHY ALMONDS, GENERAL MILLS",
  "oatsq" = "OATMEAL SQUARES, QUAKER",
  "puf.r" = "QUAKER PUFFED RICE",
  "puf.wht.q" = "PUFFED WHEAT CEREAL",
  "r.chex" = "RICE CHEX",
  "r.krisp" = "RICE KRISPIES",
  "reese.pb" = "REESE'S PUFFS CEREAL",
  "rz.b.k" = "RAISIN BRAN, KELLOGGS",
  "rz.nut.b" = "RAISIN NUT BRAN CEREAL",
  "sh.wht" = "SHREDDED WHEAT",
  "smart" = "SMART START",
  "spec.k" = "SPECIAL K CEREAL",
  "spec.k.red" = "SPECIAL K RED BERRIES",
  "su.c.pop" = "CORN POPS",
  "total" = "TOTAL WHOLE GRAIN CEREAL",
  "unc.sam" = "UNCLE SAM CEREAL",
  "weetabix" = "WEETABIX CEREAL",
  "wht.chex" = "WHEAT CHEX",
  "whties" = "WHEATIES",
  "other" = "OTHER"
)
# Make a dataframe for just cereal nutrients
ffq_cereal <- ffqs %>%
  select(record_id, do_you_eat_cold_breakfast:brand_cold_cereal)
ffq_cereal$name <- factor(ffq_cereal$brand_cold_cereal,
  levels = as.character(cereal_map),
  labels = names(cereal_map)
)
ffq_cereal <- left_join(ffq_cereal, cereal, by = join_by(name))
ffq_cereal <- ffq_cereal %>% select(record_id, amount:last_col(0))
#-------------------------------------------------------------------------------
# Margarine
#-------------------------------------------------------------------------------
ffq_marg <- ffqs %>%
  select(record_id, do_you_consume_margarine:margarine_type)
ffq_marg$name <- factor(ffq_marg$margarine_type,
  levels = c("Regular", "Light", "Nonfat"),
  labels = c("t.bel.bu.43", "t.bu.can.lol.36", NA)
)
ffq_marg <- left_join(ffq_marg, marg, by = join_by(name))
ffq_marg <- ffq_marg %>% select(record_id, amount:last_col(0))
#-------------------------------------------------------------------------------
# Food
#-------------------------------------------------------------------------------
food_map <- list(
  "skim_milk_8_oz_glass",
  "or_2_milk_8_oz_glass",
  "whole_milk_8_oz_glass",
  "soy_milk_8_oz_glass",
  "cream_e_g_coffee_sour_excl",
  "non_dairy_coffee_whitener",
  "frozen_yogurt_sherbet_sorb",
  "regular_ice_cream_1_cup",
  "pure_butter_spread",
  "margarine_e_g_country_croc",
  "spreadable_butter_butter_o",
  "plain_yogurt_4_6_oz",
  "artificially_sweetened_yog",
  "sweetened_yogurt_e_g_straw",
  "cottage_or_ricotta_cheese",
  "cream_cheese_1_oz",
  "other_cheese_e_g_american",
  "what_type_of_cheese_do_you",
  "raisins_1_oz_or_small_pack",
  "prunes_or_dried_plums_6_pr",
  "prune_juice_small_glass",
  "bananas_1",
  "cantaloupe_1_4_melon",
  "avocado_1_2_fruit_or_1_2_c",
  "fresh_apples_or_pears_1",
  "apple_juice_or_cider_small",
  "oranges_1",
  "calcium_or_vit_d_fortified",
  "regular_not_calcium_fortif",
  "grapefruit_1_2_or_grapefru",
  "other_fruit_juices_e_g_cra",
  "strawberries_fresh_frozen",
  "blueberries_fresh_frozen_o",
  "peaches_or_plums_1_fresh_o",
  "apricots_1_fresh_1_2_cup_c",
  "tomato",
  "v8",
  "tomato_sauce",
  "salsa",
  "string_beans",
  "beans_lentils",
  "soy",
  "peas",
  "broccoli",
  "cauliflower",
  "cabbage",
  "brussels_sprouts",
  "carrots",
  "carrots_cooked",
  "corn",
  "mixed_veg",
  "yams",
  "squash",
  "eggplant_zucchini",
  "kale",
  "spinach_cooked",
  "spinach_raw",
  "iceberg_lettuce",
  "romaine",
  "celery",
  "peppers",
  "onions_garnish",
  "onions",
  "eggs_1",
  "eggs_2",
  "beef_hotdog",
  "chicken_hotdog",
  "chicken_skin",
  "chicken_withoutskin",
  "bacon",
  "meat_sandwich",
  "processed_meat",
  "hamburger_lean",
  "hamburger_regular",
  "meat_mixed",
  "pork_main",
  "beef_main",
  "canned_tuna",
  "breaded_fish",
  "shrimp_main",
  "dark_meat_fish",
  "other_fish",
  "cold_breakfast_cereal",
  "cooked_oatmeal",
  "cooked_cereal",
  "bread_white",
  "bread_rye",
  "bread_wheat",
  "crackers_wheat",
  "crackers_other",
  "bagels_rolls",
  "muffins_biscuits",
  "pancakes_waffles",
  "brown_rice",
  "white_rice",
  "pasta",
  "tortillas",
  "french_fries",
  "potatoes",
  "potato_chips",
  "pizza",
  "low_calorie_caffeine",
  "other_low_cal_bev",
  "carbonated_bev_caffeine",
  "other_carbonated_bev",
  "other_sugared_bev",
  "beer_regular",
  "light_beer",
  "red_wine",
  "white_wine",
  "liquor",
  "plain_water",
  "decaffeinated_tea",
  "tea_caffeinated",
  "decaffeinated_coffee",
  "coffee_with_caffeine",
  "dairy_coffee",
  "milk_chocolate",
  "dark_chocolate",
  "candy_bars",
  "candy_without_choc",
  "fat_free_cookie",
  "readymade_cookie",
  "homebaked_cookies",
  "doughnuts",
  "cake_homemade",
  "pie_homemade",
  "jams_jellies",
  "peanut_butter",
  "popcorn_fat_free",
  "popcorn_regular",
  "roll_coffeecake",
  "breakfast_bars",
  "energy_bars",
  "protein_bars",
  "pretzels",
  "peanuts",
  "walnuts",
  "other_nuts",
  "oat_bran",
  "chowder",
  "ketchup",
  "flaxseed",
  "garlic",
  "olive_oil",
  "lowfat_mayo",
  "regular_mayo",
  "salad_dressing",
  "artificial_sweeteners",
  "type_of_salad_dressing",
  "type_of_artificial_sweet",
  "liver_beef_calf_pork",
  "liver_chicken_turkey",
  "fried_sauteed",
  "fat_used",
  "baking_fat",
  "cooking_oil_select",
  "cooking_oil",
  "deep_fried",
  "toasted_bread",
)
ffq_food <- ffqs %>%
  select(record_id, skim_milk_8_oz_glass:toasted_bread) %>%
  column_to_rownames("record_id") %>%
  t() %>%
  as.data.frame() %>%
  rownames_to_column()
