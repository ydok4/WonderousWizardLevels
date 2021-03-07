function GetMagicLorePoolDataResources()
    return {
        -- Battle Lores
        wh_dlc03_lore_beasts = {
            InnateSkill = {"wh_dlc03_skill_magic_beasts_wild_heart",},
            SignatureSpell = {"wh_dlc03_skill_magic_beasts_wyssans_wildform", },
            Level1DefaultSpells = {"wh_dlc03_skill_magic_beasts_flock_of_doom", "wh_dlc03_skill_magic_beasts_panns_impenetrable_pelt", "wh_dlc03_skill_magic_beasts_the_amber_spear", },
            Level3DefaultSpells = {"wh_dlc03_skill_magic_beasts_the_curse_of_anraheir", "wh_dlc03_skill_magic_beasts_transformation_of_kadon", },    
        },
        wh2_dlc15_lore_beasts_eagle = {
            InnateSkill = {"wh_dlc03_skill_magic_beasts_wild_heart",},
            SignatureSpell = {"wh_dlc03_skill_magic_beasts_wyssans_wildform", },
            Level1DefaultSpells = {"wh_dlc03_skill_magic_beasts_flock_of_doom", "wh_dlc03_skill_magic_beasts_panns_impenetrable_pelt", "wh_dlc03_skill_magic_beasts_the_amber_spear", },
            Level3DefaultSpells = {"wh_dlc03_skill_magic_beasts_the_curse_of_anraheir", "wh2_dlc15_skill_magic_beasts_transformation_of_kadon", },    
        },
        wh_main_lore_death = {
            InnateSkill = {"wh_main_skill_all_magic_death_03_life_leeching",},
            SignatureSpell = {"wh_main_skill_all_magic_death_01_spirit_leech", },
            Level1DefaultSpells = {"wh_main_skill_all_magic_death_02_aspect_of_the_dreadknight", "wh_main_skill_all_magic_death_05_doom_and_darkness", "wh_main_skill_all_magic_death_04_soulblight", },
            Level3DefaultSpells = {"wh_main_skill_all_magic_death_09_the_fate_of_bjuna", "wh_main_skill_all_magic_death_10_the_purple_sun_of_xereus", },
        },
        wh_main_lore_fire = {
            InnateSkill = {"wh_main_skill_all_magic_fire_04_kindleflame",},
            SignatureSpell = {"wh_main_skill_all_magic_fire_01_fireball",},
            Level1DefaultSpells = {"wh_main_skill_all_magic_fire_02_cascading_fire-cloak", "wh_main_skill_all_magic_fire_03_flaming_sword_of_rhuin", "wh_main_skill_all_magic_fire_05_the_burning_head", },
            Level3DefaultSpells = {"wh_main_skill_all_magic_fire_09_piercing_bolts_of_burning", "wh_main_skill_all_magic_fire_10_flame_storm",},
        },
        wh_main_lore_heavens = {
            InnateSkill = {"wh_main_skill_all_magic_heavens_03_rolling_skies",},
            SignatureSpell = {"wh_main_skill_all_magic_heavens_01_harmonic_convergence",},
            Level1DefaultSpells = {"wh_main_skill_all_magic_heavens_02_wind_blast", "wh_main_skill_all_magic_heavens_04_curse_of_the_midnight_wind", "wh_main_skill_all_magic_heavens_05_urannons_thunderbolt", },
            Level3DefaultSpells = {"wh_main_skill_all_magic_heavens_09_comet_of_casandora", "wh_main_skill_all_magic_heavens_10_chain_lightning", },
        },
        wh_dlc05_lore_life = {
            InnateSkill = {"wh_dlc05_skill_magic_life_life_bloom",},
            SignatureSpell = {"wh_dlc05_skill_magic_life_wizard_awakening_of_the_wood", },
            Level1DefaultSpells = {"wh_dlc05_skill_magic_life_wizard_earth_blood", "wh_dlc05_skill_magic_life_wizard_shield_of_thorns", "wh_dlc05_skill_magic_life_wizard_flesh_to_stone", },
            Level3DefaultSpells = {"wh_dlc05_skill_magic_life_wizard_regrowth", "wh_dlc05_skill_magic_life_wizard_the_dwellers_below", },
        },
        wh_main_lore_light = {
            InnateSkill = {"wh_main_skill_all_magic_light_03_exorcism",},
            SignatureSpell = {"wh_main_skill_all_magic_light_01_shems_burning_gaze",},
            Level1DefaultSpells = {"wh_main_skill_all_magic_light_02_phas_protection", "wh_main_skill_all_magic_light_04_light_of_battle", "wh_main_skill_all_magic_light_05_net_of_amyntok"},
            Level3DefaultSpells = {"wh_main_skill_all_magic_light_09_banishment", "wh_main_skill_all_magic_light_10_bironas_timewarp", },
        },
        wh_main_lore_metal = {
            InnateSkill = {"wh_main_skill_all_magic_metal_03_metalshifting",},
            SignatureSpell = {"wh_main_skill_all_magic_metal_01_searing_doom",},
            Level1DefaultSpells = {"wh_main_skill_all_magic_metal_02_plague_of_rust", "wh_main_skill_all_magic_metal_04_glittering_robe", "wh_main_skill_all_magic_metal_05_gehennas_golden_hounds", },
            Level3DefaultSpells = {"wh_main_skill_all_magic_metal_09_transmutation_of_lead", "wh_main_skill_all_magic_metal_10_final_transmutation", },
        },
        wh_dlc05_lore_shadows = {
            InnateSkill = {"wh_dlc05_skill_magic_shadow_smoke_and_mirrors", },
            SignatureSpell = {"wh_dlc05_skill_magic_shadow_mystifying_miasma",},
            Level1DefaultSpells = {"wh_dlc05_skill_magic_shadow_enfeebling_foe",  "wh_dlc05_skill_magic_shadow_the_withering", "wh_dlc05_skill_magic_shadow_penumbral_pendulum", },
            Level3DefaultSpells = {"wh_dlc05_skill_magic_shadow_pit_of_shades", "wh_dlc05_skill_magic_shadow_okkams_mindrazor", },
        },
        -- Unique lores
        wh_main_lore_vampires = {
            InnateSkill = {"wh_main_skill_vmp_magic_vampires_03_the_curse_of_undeath",},
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", },
            Level1DefaultSpells = {"wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre", "wh_main_skill_vmp_magic_vampires_04_gaze_of_nagash", "wh_main_skill_vmp_magic_vampires_05_raise_dead"},
            Level3DefaultSpells = {"wh_main_skill_vmp_magic_vampires_09_curse_of_years", "wh_main_skill_vmp_magic_vampires_10_wind_of_death", },
        },
        wh2_dlc11_lore_vampire_pirates = {
            InnateSkill = {"wh_main_skill_vmp_magic_vampires_03_the_curse_of_undeath",},
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", },
            Level1DefaultSpells = {"wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre", "wh_main_skill_vmp_magic_vampires_04_gaze_of_nagash", "wh2_dlc11_skill_cst_magic_vampires_05_drowned_dead", },
            Level3DefaultSpells = {"wh_main_skill_vmp_magic_vampires_09_curse_of_years", "wh_main_skill_vmp_magic_vampires_10_wind_of_death", },
        },
        wh2_main_lore_high_magic = {
            InnateSkill = {"wh2_main_skill_all_magic_high_03_lore_attribute",},
            SignatureSpell = {"wh2_main_skill_all_magic_high_02_apotheosis", },
            Level1DefaultSpells = {"wh2_main_skill_all_magic_high_04_hand_of_glory", "wh2_main_skill_all_magic_high_01_soul_quench", "wh2_main_skill_all_magic_high_05_tempest",},
            Level3DefaultSpells = {"wh2_main_skill_all_magic_high_09_arcane_unforging", "wh2_main_skill_all_magic_high_10_fiery_convocation"},
        },
        wh2_main_lore_dark_magic = {
            InnateSkill = {"wh2_main_skill_magic_dark_lore_attribute",},
            SignatureSpell = {"wh2_main_skill_magic_dark_chillwind", },
            Level1DefaultSpells = {"wh2_main_skill_magic_dark_power_of_darkness", "wh2_main_skill_magic_dark_word_of_pain", "wh2_main_skill_magic_dark_bladewind", },
            Level3DefaultSpells = {"wh2_main_skill_magic_dark_doombolt", "wh2_main_skill_magic_dark_soul_stealer", },
        },
        wh2_dlc11_lore_deep = {
            InnateSkill = {"wh2_dlc11_skill_all_magic_deep_03_lore_attribute",},
            SignatureSpell = {"wh2_dlc11_skill_all_magic_deep_01_spiteful_shot",},
            Level1DefaultSpells = {"wh2_dlc11_skill_all_magic_deep_02_tidecall", "wh2_dlc11_skill_all_magic_deep_04_denizens_of_the_deep", "wh2_dlc11_skill_all_magic_deep_05_fog_of_the_damned", },
            Level3DefaultSpells = {"wh2_dlc11_skill_all_magic_deep_09_krakens_pull", "wh2_dlc11_skill_all_magic_deep_10_ghost_ship", },
        },
        wh2_dlc09_lore_nehekhara = {
            InnateSkill = {"wh2_dlc09_skill_tmb_nehekhara_lore_1_passive",},
            SignatureSpell = {"wh2_dlc09_skill_tmb_nehekhara_lore_0_djafs_incantation_of_cursed_blades", },
            Level1DefaultSpells = {"wh2_dlc09_skill_tmb_nehekhara_lore_2_nerus_incantation_of_protection", "wh2_dlc09_skill_tmb_nehekhara_lore_3_ptras_incantation_of_righteous_smiting", "wh2_dlc09_skill_tmb_nehekhara_lore_4_usirians_incantation_of_vengeance"},
            Level3DefaultSpells = {"wh2_dlc09_skill_tmb_nehekhara_lore_6_usekhps_incantation_of_desiccation", "wh2_dlc09_skill_tmb_nehekhara_lore_7_sakhmets_incantation_of_the_skullstorm"},
        },
        wh_main_lore_big_waaagh = {
            InnateSkill = {"wh_main_skill_grn_magic_big_waaagh_04_power_of_da_waaagh",},
            SignatureSpell = {"wh_main_skill_grn_magic_big_waaagh_01_gaze_of_mork",},
            Level1DefaultSpells = {"wh_main_skill_grn_magic_big_waaagh_02_brain_bursta", "wh_main_skill_grn_magic_big_waaagh_03_fists_of_gork", "wh_main_skill_grn_magic_big_waaagh_05_eadbutt", },
            Level3DefaultSpells = {"wh_main_skill_grn_magic_big_waaagh_10_foot_of_gork", "wh_main_skill_grn_magic_big_waaagh_09_ere_we_go"},
        },
        wh_main_lore_lil_waaagh = {
            InnateSkill = {"wh_main_skill_grn_magic_little_waaagh_03_sneaky_stealin", },
            SignatureSpell = {"wh_main_skill_grn_magic_little_waaagh_01_sneaky_stabbin",},
            Level1DefaultSpells = {"wh_main_skill_grn_magic_little_waaagh_02_vindictive_glare", "wh_main_skill_grn_magic_little_waaagh_04_itchy_nuisance", "wh_main_skill_grn_magic_little_waaagh_05_gorkll_fix_it", },
            Level3DefaultSpells = {"wh_main_skill_grn_magic_little_waaagh_09_night_shroud", "wh_main_skill_grn_magic_little_waaagh_10_curse_of_da_bad_moon", },
        },
        wh_dlc03_lore_wild = {
            InnateSkill = {"wh_dlc03_skill_magic_wild_bestial_surge", },
            SignatureSpell = {"wh_dlc03_skill_magic_wild_viletide", },
            Level1DefaultSpells = {"wh_dlc03_skill_magic_wild_devolve", "wh_dlc03_skill_magic_wild_bray_scream", "wh_dlc03_skill_magic_wild_traitor_kin", },
            Level3DefaultSpells = {"wh_dlc03_skill_magic_wild_mantle_of_ghorok", "wh_dlc03_skill_magic_wild_savage_dominion", },
        },
        wh2_main_lore_plague = {
            InnateSkill = {"wh2_main_skill_all_magic_plague_03_lore_attribute",},
            SignatureSpell = {"wh2_main_skill_all_magic_plague_01_pestilent_breath",},
            Level1DefaultSpells = {"wh2_main_skill_all_magic_plague_02_bless_with_filth", "wh2_main_skill_all_magic_plague_04_wither", "wh2_main_skill_all_magic_plague_05_vermintide", },
            Level3DefaultSpells = {"wh2_main_skill_all_magic_plague_09_plague", "wh2_main_skill_all_magic_plague_11_pestilent_birth", },
        },
        wh2_main_lore_grey_seer_plague = {
            InnateSkill = {"wh2_main_skill_all_magic_plague_03_lore_attribute",},
            SignatureSpell = {"wh2_main_skill_all_magic_plague_01_pestilent_breath",},
            Level1DefaultSpells = {"wh2_main_skill_all_magic_plague_02_bless_with_filth", "wh2_main_skill_all_magic_plague_04_wither", "wh2_main_skill_all_magic_plague_05_vermintide", },
            Level3DefaultSpells = {"wh2_main_skill_all_magic_plague_09_plague", "wh2_main_skill_all_magic_plague_10_dreaded_thirteenth", },
        },
        wh2_main_lore_ruin = {
            InnateSkill = {"wh2_main_skill_all_magic_ruin_03_lore_attribute", },
            SignatureSpell = {"wh2_main_skill_all_magic_ruin_01_warp_lightning", },
            Level1DefaultSpells = {"wh2_main_skill_all_magic_ruin_02_howling_warpgale_warlock", "wh2_main_skill_all_magic_ruin_04_death_frenzy_warlock", "wh2_main_skill_all_magic_ruin_05_skaven_scorch_warlock", },
            Level3DefaultSpells = {"wh2_main_skill_all_magic_ruin_09_cracks_call_warlock", "wh2_main_skill_all_magic_ruin_10_skitterleap_warlock", },
        },
        wh2_main_lore_grey_seer_ruin = {
            InnateSkill = {"wh2_main_skill_all_magic_ruin_03_lore_attribute", },
            SignatureSpell = {"wh2_main_skill_all_magic_ruin_01_warp_lightning", },
            Level1DefaultSpells = {"wh2_main_skill_all_magic_ruin_02_howling_warpgale_warlock", "wh2_main_skill_all_magic_ruin_04_death_frenzy_warlock", "wh2_main_skill_all_magic_ruin_05_skaven_scorch_warlock", },
            Level3DefaultSpells = {"wh2_main_skill_all_magic_ruin_09_cracks_call_warlock", "wh2_main_skill_all_magic_plague_10_dreaded_thirteenth", },
        },
        Slann = {
            InnateSkill = {},
            SignatureSpell = {},
            Level1DefaultSpells = {},
            Level1DefaultSpellsLord = {},
            Level3DefaultSpells = {},
            Level3DefaultSpellsLord = {},
        },
        wh2_main_lore_loremaster = {
            InnateSkill = {},
            SignatureSpell = {"wh_dlc03_skill_magic_beasts_wyssans_wildform", "wh_main_skill_all_magic_death_01_spirit_leech", "wh_main_skill_all_magic_fire_01_fireball", "wh_main_skill_all_magic_heavens_01_harmonic_convergence", "wh_dlc05_skill_magic_life_wizard_awakening_of_the_wood", "wh_main_skill_all_magic_light_01_shems_burning_gaze", "wh_main_skill_all_magic_metal_01_searing_doom", "wh_dlc05_skill_magic_shadow_mystifying_miasma", },
            Level1DefaultSpells = {},
            Level1DefaultSpellsLord = {},
            Level3DefaultSpells = {},
            Level3DefaultSpellsLord = {},
        },
        Teclis = {
            InnateSkill = {},
            SignatureSpell = { },
            Level1DefaultSpells = {},
            Level1DefaultSpellsLord = {},
            Level3DefaultSpells = {},
            Level3DefaultSpellsLord = {},
        },
        wh_dlc05_lore_branchwraith = {
            InnateSkill = {"wh_dlc05_skill_magic_shadow_smoke_and_mirrors", },
            SignatureSpell = {"wh_dlc05_skill_magic_shadow_mystifying_miasma", },
            Level1DefaultSpells = {"wh_dlc05_skill_magic_life_wizard_awakening_of_the_wood", "wh_dlc05_skill_magic_shadow_the_withering", "wh_dlc05_skill_magic_shadow_penumbral_pendulum", },
            Level3DefaultSpells = {"wh_dlc05_skill_magic_life_wizard_earth_blood", "wh_dlc05_skill_magic_life_wizard_shield_of_thorns", },
        },
        wh_dlc04_lore_helman_ghorst = {
            InnateSkill = {"wh_main_skill_vmp_magic_vampires_helman_03_the_curse_of_undeath", },
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre", },
            Level1DefaultSpells = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", "wh_main_skill_vmp_magic_vampires_04_gaze_of_nagash", "wh_main_skill_vmp_magic_vampires_05_helman_raise_dead", },
            Level3DefaultSpells = {"wh_main_skill_vmp_magic_vampires_09_curse_of_years", "wh_main_skill_vmp_magic_vampires_10_wind_of_death", },
        },
        wh_dlc04_lore_strigoi = {
            InnateSkill = {"wh_main_skill_vmp_magic_vampires_03_the_curse_of_undeath",},
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", },
            Level1DefaultSpells = {"wh_main_skill_all_magic_death_01_spirit_leech", "wh_main_skill_vmp_magic_vampires_04_gaze_of_nagash", "wh_dlc04_skill_vmp_magic_strigoi_05_raise_dead", },
            Level3DefaultSpells = {"wh_main_skill_all_magic_death_04_soulblight", "wh_main_skill_all_magic_death_05_doom_and_darkness", },
        },
        wh2_dlc11_vmp_lore_von_carstein = {
            InnateSkill = {"wh2_dlc11_skill_vmp_bloodline_von_carstein_magic_curse_of_undeath",},
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", },
            Level1DefaultSpells = { "wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre", "wh_dlc03_skill_magic_beasts_flock_of_doom", "wh_main_skill_vmp_magic_vampires_05_raise_dead", },
            Level3DefaultSpells = { "wh2_dlc11_skill_vmp_bloodline_von_carstein_magic_transformation_of_kadon", "wh_main_skill_vmp_magic_vampires_10_wind_of_death", },
        },
        wh2_dlc11_vmp_lore_lahmian = {
            InnateSkill = { "wh2_dlc11_skill_vmp_bloodline_lahmian_magic_curse_of_undeath",},
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", },
            Level1DefaultSpells = { "wh_dlc05_skill_magic_shadow_enfeebling_foe", "wh_dlc05_skill_magic_shadow_penumbral_pendulum", "wh_main_skill_vmp_magic_vampires_05_raise_dead", },
            Level3DefaultSpells = { "wh_dlc05_skill_magic_shadow_okkams_mindrazor", "wh_main_skill_vmp_magic_vampires_10_wind_of_death", },
        },
        wh2_dlc11_vmp_lore_necrarch = {
            InnateSkill = {"wh2_dlc11_skill_vmp_bloodline_necrarch_magic_curse_of_undeath",},
            SignatureSpell = {"wh_main_skill_vmp_magic_vampires_01_invocation_of_nehek", },
            Level1DefaultSpells = { "wh_main_skill_all_magic_death_01_spirit_leech", "wh_dlc03_skill_magic_beasts_panns_impenetrable_pelt", "wh_main_skill_vmp_magic_vampires_05_raise_dead", },
            Level3DefaultSpells = { "wh_dlc03_skill_magic_beasts_the_curse_of_anraheir", "wh_main_skill_all_magic_death_10_the_purple_sun_of_xereus", },
        },
        wh2_dlc14_lore_stealth = {
            InnateSkill = {"wh2_dlc14_skill_all_magic_stealth_02_toxic_rain_lore_attribute",},
            SignatureSpell = {"wh2_dlc14_skill_all_magic_stealth_01_warp_stars", },
            Level1DefaultSpells = {"wh2_dlc14_skill_all_magic_stealth_03_skitterleap", "wh2_dlc14_skill_all_magic_stealth_04_armour_of_darkness", "wh2_dlc14_skill_all_magic_stealth_05_veil_of_shadows", },
            Level3DefaultSpells = {"wh2_dlc14_skill_all_magic_stealth_06_brittle_bone", "wh2_dlc14_skill_all_magic_stealth_07_black_whirlwind", },
        },
        --[[wh_pro03_lore_kemmler = {

        },--]]
        -- TBD
        --[[wh_dlc08_lore_arzik = {
            InnateSkill = {},
            SignatureSpell = { },
            Level1DefaultSpells = {},
            Level3DefaultSpells = {},
        },
        wh_dlc08_lore_kihar = {
            InnateSkill = {},
            SignatureSpell = {},
            Level1DefaultSpells = {},
            Level3DefaultSpells = {},
        },--]]
        -- Non Vanilla
        mixu_lore_of_ice = {
            InnateSkill = {"mixu_all_lord_spell_lore_of_ice_passive",},
            SignatureSpell = {"mixu_all_lord_spell_lore_of_ice_glacial_barrier", },
            Level1DefaultSpells = { "mixu_all_lord_spell_lore_of_ice_shield_of_cold", "mixu_all_lord_spell_lore_of_ice_midwinters_kiss", "mixu_all_lord_spell_lore_of_ice_wind_of_ice", },
            Level3DefaultSpells = { "mixu_all_lord_spell_lore_of_ice_shardstorm", "mixu_all_lord_spell_lore_of_ice_invocation_of_the_ice_storm", },
        },
        deco_lore_of_ice = {
            InnateSkill = {"skill_all_deco_ice_winter",},
            SignatureSpell = {"deco_ice_ice_shards", },
            Level1DefaultSpells = { "deco_ice_storm_strike", "deco_ice_chill_blast", "deco_ice_ice_blizzard", },
            Level3DefaultSpells = { "deco_ice_tempest", "deco_ice_hailstorm", },
        },
        deco_lore_of_hags = {
            InnateSkill = { "skill_all_deco_ice_cold", },
            SignatureSpell = {"deco_ice_shield_of_cold", },
            Level1DefaultSpells = { "deco_ice_frost_blade", "deco_ice_crisping_cold", "deco_ice_shattering_frost", },
            Level3DefaultSpells = { "deco_ice_chill", "deco_ice_blinding_blizzard", },
        },
    };
end