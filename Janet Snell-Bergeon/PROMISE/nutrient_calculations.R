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
food_map <- read_excel("C:/Users/timvigers/OneDrive - The University of Colorado Denver/Vigers/BDC/Janet Snell-Bergeon/PROMISE/Data_Raw/Gram Weight Servings Completed.xlsx")

food_map <- list(
  "apple" = "fresh_apples_or_pears_1",
  "beer" = "beer_regular",
  "cake.frost" = "cake_homemade",
  "chix.no" = "chicken_withoutskin",
  "chowder" = "chowder",
  "brownie.home and coox.home.cc" = "homebaked_cookies",
  "coox.rte and brownie.rte" = "readymade_cookie",
  "cr.ch" = "cream_cheese_1_oz",
  "crax.oth" = "crackers_other",
  "dk.fish" = "dark_meat_fish",
  "energy.bar" = "energy_bars",
  "eng.muff" = "bagels_rolls",
  "grfrt and grfrt.j" = "grapefruit_1_2_or_grapefru",
  "hamb" = "hamburger_regular",
  "jam" = "jams_jellies",
  "kale.raw" = "kale",
  "biscuit and muff" = "muffins_biscuits",
  "nuts" = "peanuts",
  "oat.bran and oatmeal.swt" = "cooked_oatmeal",
  "oat.bran" = "oat_bran",
  "oth.ch" = "other_cheese_e_g_american",
  "haddock and halibut" = "other_fish",
  "p.bu" = "peanut_butter",
  "peach, plums" = "peaches_or_plums_1_fresh_o",
  "peas, lima.beans" = "peas",
  "peppers, peppers.red" = "peppers",
  "pork" = "pork_main",
  "pot+skin" = "potatoes",
  "dr.prune" = "prunes_or_dried_plums_6_pr",
  "sug.ice.tea" = "other_sugared_bev",
  "rais and grapes" = "raisins_1_oz_or_small_pack",
  "shrimp.ckd" = "shrimp_main",
  "ff.pot.swt, swt.pot" = "yams",
  "tofu" = "soy",
  "tortillas, tortillas.fl" = "tortillas",
  "tuna.all" = "canned_tuna",
  "wh.br" = "bread_white",
  "yogurt.frozen.lf" = "frozen_yogurt_sherbet_sorb",
  "a.j" = "apple_juice_or_cider_small",
  "apricot" = "apricots_1_fresh_1_2_cup_c",
  "avocado" = "avocado_1_2_fruit_or_1_2_c",
  "bacon" = "bacon",
  "ban" = "bananas_1",
  "blue" = "blueberries_fresh_frozen_o",
  "br.rice" = "brown_rice",
  "broc" = "broccoli",
  "brusl" = "brussels_sprouts",
  "bu" = "pure_butter_spread",
  "cabb" = "cabbage",
  "candy" = "candy_without_choc",
  "candy.&.nuts" = "candy_bars",
  "cant" = "cantaloupe_1_4_melon",
  "carrot.c" = "carrots_cooked",
  "carrot.r" = "carrots",
  "caul" = "cauliflower",
  "chix.liver" = "liver_chicken_turkey",
  "choc" = "milk_chocolate",
  "choc.dark" = "dark_chocolate",
  "coff" = "coffee_with_caffeine",
  "coff.drink" = "dairy_coffee",
  "corn" = "corn",
  "cot.ch" = "cottage_or_ricotta_cheese",
  "crax.ww" = "crackers_wheat",
  "cream" = "cream_e_g_coffee_sour_excl",
  "decaf" = "decaffeinated_coffee",
  "dietsoda.caf" = "low_calorie_caffeine",
  "dietsoda.nocaf" = "other_low_cal_bev",
  "donut" = "doughnuts",
  "eggs" = "eggs_2",
  "eggs.omega" = "eggs_1",
  "ff.pot.fast" = "french_fries",
  "flax  " = "flaxseed",
  "fr.fish.kids" = "breaded_fish",
  "garlic2   " = "garlic",
  "h2o" = "plain_water",
  "hotdog" = "beef_hotdog",
  "ice.cr." = "regular_ice_cream_1_cup",
  "ice.let" = "iceberg_lettuce",
  "liq " = "liquor",
  "liver " = "liver_beef_calf_pork",
  "mayo     " = "regular_mayo",
  "mayo.d  " = "lowfat_mayo",
  "milk" = "whole_milk_8_oz_glass",
  "milk1%" = "or_2_milk_8_oz_glass",
  "mix.veg" = "mixed_veg",
  "o.j" = "regular_not_calcium_fortif",
  "o.j.ca.d" = "calcium_or_vit_d_fortified",
  "onions" = "onions",
  "orang" = "oranges_1",
  "oth.f.j" = "other_fruit_juices_e_g_cra",
  "pancak.all " = "pancakes_waffles",
  "pasta" = "pasta",
  "pie.comm" = "pie_homemade",
  "pizza.f.r " = "pizza",
  "popc " = "popcorn_regular",
  "pretzel" = "pretzels",
  "r.wine" = "red_wine",
  "rom.let" = "romaine",
  "rye.br" = "bread_rye",
  "salad.dress.oth " = "salad_dressing",
  "salsa" = "salsa",
  "skim.kids" = "skim_milk_8_oz_glass",
  "snack.bar " = "breakfast_bars",
  "snack.chip" = "potato_chips",
  "soda.nocaf  " = "other_carbonated_bev",
  "soymilk.fort" = "soy_milk_8_oz_glass",
  "spin.ckd" = "spinach_cooked",
  "spin.raw" = "spinach_raw",
  "st.beans" = "string_beans",
  "straw" = "strawberries_fresh_frozen",
  "t.bel.bu.43 (margarine)" = "margarine_e_g_country_croc",
  "tea " = "tea_caffeinated",
  "tom" = "tomato",
  "tom.s" = "tomato_sauce",
  "w.wine  " = "white_wine",
  "walnuts  " = "walnuts",
  "wh.rice " = "white_rice",
  "wheat.br" = "bread_wheat",
  "yel.sqs" = "squash",
  "yog.lt" = "artificially_sweetened_yog",
  "yog.plain.whl" = "plain_yogurt_4_6_oz",
  "zuke" = "eggplant_zucchini"
)
ffq_food <- ffqs %>%
  select(record_id, skim_milk_8_oz_glass:toasted_bread) %>%
  select(-what_type_of_cheese_do_you)
# Convert to numeric frequencies
ffq_food[, 2:ncol(ffq_food)] <- lapply(
  ffq_food[, 2:ncol(ffq_food)],
  function(c) {
    c <- factor(c,
      levels = c(
        "Never or less than once per month", "1-3 month",
        "1 per week", "2-4 per week", "5-6 per week", "1 per day",
        "2-3 per day", "4-5 per day", "6+ per day",
        "Never", "Less than 1 per month", "1 per month", "2-3 per month",
        "1 per week or more",
        "Less than once a week", "1-3 times per week", "4-6 times per week",
        "Daily", "2+ times/day"
      ),
      labels = c(
        0, 2 / 30, 1 / 7, 3 / 7, 5.5 / 7, 1, 2.5, 4.5, 6, 0, 0, 1 / 30,
        2.5 / 30, 1 / 7, 0.5 / 7, 2 / 7, 5 / 7, 1, 2
      )
    )
    return(c)
  }
)
# Get nutrients

