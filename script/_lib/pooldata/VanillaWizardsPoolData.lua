function GetVanillaWizardsPoolDataResources()
    -- Used by the skill node generator
    if _G.IgnoreVanillaWizards == true then
        return {

        };
    end
    return {
        -- Beastmen
        wh_dlc03_sc_bst_beastmen = {
            wh_dlc03_bst_bray_shaman_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh_dlc03_bst_bray_shaman_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh_dlc03_bst_bray_shaman_shadows = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_dlc03_bst_bray_shaman_wild = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_wild",
            },
            wh2_twa04_bst_great_bray_shaman_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_twa04_bst_great_bray_shaman_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            wh2_twa04_bst_great_bray_shaman_shadows = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_twa04_bst_great_bray_shaman_wild = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_wild",
            },
            wh_dlc03_bst_malagor = {
                DefaultWizardLevel = 4,
                Lore = {"wh_dlc03_lore_wild", "wh_main_lore_death", "wh_dlc05_lore_shadows", "wh_dlc03_lore_beasts", },
            },
        },
        -- Bretonnia
        wh_main_sc_brt_bretonnia = {
            wh_main_brt_damsel_heavens = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh_dlc07_brt_damsel_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh_dlc07_brt_damsel_life = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            wh_dlc07_brt_prophetess_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh_dlc07_brt_prophetess_heavens = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_heavens",
            },
            wh_dlc07_brt_prophetess_life = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_life",
            },
            -- Fay enchantress
            wh_dlc07_brt_fay_enchantress = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_dlc07_skill_brt_lord_unique_fay_enchantress_loremaster_lore_of_life",
                Lore = {"wh_dlc05_lore_life", "wh_dlc03_lore_beasts", "wh_main_lore_heavens", },
            },
        },
        -- Cathay
        wh3_main_sc_cth_cathay = {
            wh3_main_cth_alchemist = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
            wh3_main_cth_astromancer = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh3_main_cth_dragon_blooded_shugengan_yang = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_of_yang",
            },
            wh3_main_cth_dragon_blooded_shugengan_yin = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_of_yin",
            },
            wh3_main_cth_miao_ying = {
                DefaultWizardLevel = 4,
                Lore = { "wh_dlc05_lore_life", "wh3_main_lore_of_yin", },
            },
            wh3_main_cth_zhao_ming = {
                DefaultWizardLevel = 4,
                Lore = { "wh_main_lore_metal", "wh3_main_lore_of_yang", },
            },
        },
        -- Chaos
        wh_main_sc_chs_chaos = {
            wh_main_chs_archaon = {
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_fire",
            },
            wh_main_chs_chaos_sorcerer_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh_main_chs_chaos_sorcerer_fire = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh_main_chs_chaos_sorcerer_metal = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
            wh_dlc07_chs_chaos_sorcerer_shadow = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_dlc01_chs_sorcerer_lord_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            wh_dlc01_chs_sorcerer_lord_fire = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_fire",
            },
            wh_dlc01_chs_sorcerer_lord_metal = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
            wh_dlc07_chs_sorcerer_lord_shadow = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_main_chs_lord_of_change = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
        },
        -- Daemons of Chaos
        wh3_main_sc_dae_daemons = {
            --wh3_main_dae_daemon_prince
            -- Belakor isn't exclusive to any faction but needs to be defined somewhere
            -- Because he will always exist when he is spawned, it doesn't matter what subculture he is in
            -- Keeping him in Undivided Daemons because he is one
            wh3_main_dae_belakor = {
                DefaultWizardLevel = 4,
                Lore = "wh_dlc05_lore_shadows",
            },
            -- Also draws from Khorne, Nurgle, Slaanesh and Tzeentch
            -- These overwrites are defined in the loader script

        },
        -- Dark Elves
        wh2_main_sc_def_dark_elves = {
            wh2_main_def_sorceress_dark = {
                DefaultWizardLevel = 1,
                Lore = "wh2_main_lore_dark_magic",
            },
            wh2_main_def_sorceress_fire = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh2_main_def_sorceress_shadow = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_dlc10_def_sorceress_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_dlc10_def_sorceress_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc10_def_supreme_sorceress_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_dlc10_def_supreme_sorceress_dark = {
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_dark_magic",
            },
            wh2_dlc10_def_supreme_sorceress_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc10_def_supreme_sorceress_fire = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_fire",
            },
            wh2_dlc10_def_supreme_sorceress_shadow = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_main_def_morathi = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh2_main_def_morathi_loremaster_lore_of_dark_magic",
                Lore = {"wh2_main_lore_dark_magic", "wh_main_lore_death", "wh_dlc05_lore_shadows",},
            },
            wh2_main_def_malekith = {
                DefaultWizardLevel = 4,
                Lore = "wh2_main_lore_dark_magic",
            },
        },
        -- Dwarfs
        wh_main_sc_dwf_dwarfs = {
            wh2_dlc17_dwf_thorek = {
                DefaultWizardLevel = 4,
                Lore = "wh2_dlc17_lore_rune",
            },
            wh_dlc06_dwf_runelord = {
                DefaultWizardLevel = 3,
                Lore = "wh2_dlc17_lore_rune",
            },
            wh_main_dwf_runesmith = {
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc17_lore_rune",
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {
            wh_dlc05_emp_grey_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_dlc05_emp_jade_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            wh_main_emp_bright_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh_main_emp_celestial_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh2_pro07_emp_amethyst_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh_dlc03_emp_amber_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh_main_emp_light_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_light",
            },
            wh_main_emp_balthasar_gelt = {
                IsLord = true,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_emp_lord_unique_balthasar_loremaster_lore_of_metal",
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_metal",
            },
        },
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            wh_main_grn_orc_shaman = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_big_waaagh",
            },
            wh_main_grn_night_goblin_shaman = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_lil_waaagh",
            },
            wh_main_grn_goblin_great_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_lil_waaagh",
            },
            wh2_dlc15_grn_goblin_great_shaman_raknik = {
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_lil_waaagh",
            },
            wh_dlc06_grn_wurrzag_da_great_prophet = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_big_waaagh",
            },
            wh_main_grn_azhag_the_slaughterer = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc15_grn_river_troll_hag = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            wh2_main_hef_loremaster_of_hoeth = {
                DefaultWizardLevel = 2,
                Lore = "wh2_main_lore_loremaster",
            },
            wh2_main_hef_mage_high = {
                DefaultWizardLevel = 1,
                Lore = "wh2_main_lore_high_magic",
            },
            wh2_main_hef_mage_life = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            wh2_main_hef_mage_light = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_light",
            },
            wh2_dlc10_hef_mage_heavens = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh2_dlc10_hef_mage_shadows = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_dlc15_hef_mage_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            wh2_dlc15_hef_mage_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc15_hef_mage_fire = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh2_dlc15_hef_mage_metal = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
            wh2_main_hef_teclis = {
                DefaultWizardLevel = 4,
                Lore = { "wh2_main_lore_high_magic", "wh2_dlc15_lore_beasts_eagle", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", },
            },
            wh2_dlc10_hef_alarielle = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh2_dlc10_hef_alarielle_loremaster_lore_of_light_magic",
                Lore = {"wh_main_lore_light", "wh_dlc05_lore_life", "wh2_main_lore_high_magic"},
            },
            wh2_dlc15_hef_eltharion = {
                DefaultWizardLevel = 2,
                Lore = "wh2_main_lore_high_magic",
            },
            wh2_dlc15_hef_archmage_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            wh2_dlc15_hef_archmage_death = {
                  DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc15_hef_archmage_fire = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_fire",
            },
            wh2_dlc15_hef_archmage_heavens = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_heavens",
            },
            wh2_dlc15_hef_archmage_high = {
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_high_magic",
            },
            wh2_dlc15_hef_archmage_life = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_life",
            },
            wh2_dlc15_hef_archmage_light = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_light",
            },
            wh2_dlc15_hef_archmage_metal = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
            wh2_dlc15_hef_archmage_shadows = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
        },
        -- Kislev
        wh3_main_sc_ksl_kislev = {
            wh3_main_ksl_frost_maiden_ice = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_of_ice",
            },
            wh3_main_ksl_frost_maiden_tempest = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_of_tempest",
            },
            wh3_main_ksl_ice_witch_ice = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_of_ice",
            },
            wh3_main_ksl_ice_witch_tempest = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_of_tempest",
            },
            wh3_main_ksl_katarin = {
                DefaultWizardLevel = 4,
                Lore = "wh3_main_lore_of_ice",
            },
        },
        -- Khorne
        wh3_main_sc_kho_khorne = {
            -- KHORNE HATES MAGIC!!!
        },
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = {
            wh2_dlc12_lzd_tlaqua_skink_priest_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_dlc12_lzd_tlaqua_skink_priest_heavens = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh2_main_lzd_skink_priest_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_main_lzd_skink_priest_heavens = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh2_dlc17_lzd_skink_oracle_troglodon = {
                DefaultWizardLevel = 1,
                Lore = { "wh2_dlc17_lore_oracle_beasts", "wh2_dlc17_lore_oracle_fire", "wh2_dlc17_lore_oracle_heavens", "wh2_dlc17_lore_oracle_life", },
            },
            wh2_dlc12_lzd_tehenhauin = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_main_lzd_lord_mazdamundi = {
                DefaultWizardLevel = 5,
                Lore = { "wh2_main_lore_high_magic", "wh_dlc03_lore_beasts", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", },
            },
            wh2_main_lzd_slann_mage_priest = {
                DefaultWizardLevel = 5,
                Lore = "wh_main_lore_light",
            },
            wh2_main_lzd_slann_mage_priest_horde = {
                DefaultWizardLevel = 5,
                Lore = "wh_main_lore_light",
            },
            wh2_dlc13_lzd_slann_mage_priest_fire = {
                DefaultWizardLevel = 5,
                Lore = "wh_main_lore_fire",
            },
            wh2_dlc13_lzd_slann_mage_priest_fire_horde = {
                DefaultWizardLevel = 5,
                Lore = "wh_main_lore_fire",
            },
            wh2_dlc13_lzd_slann_mage_priest_high = {
                DefaultWizardLevel = 5,
                Lore = "wh2_main_lore_high_magic",
            },
            wh2_dlc13_lzd_slann_mage_priest_high_horde = {
                DefaultWizardLevel = 5,
                Lore = "wh2_main_lore_high_magic",
            },
            wh2_dlc13_lzd_slann_mage_priest_life = {
                DefaultWizardLevel = 5,
                Lore = "wh_dlc05_lore_life",
            },
            wh2_dlc13_lzd_slann_mage_priest_life_horde = {
                DefaultWizardLevel = 5,
                Lore = "wh_dlc05_lore_life",
            },
        },
        -- Ogre Kingdoms
        wh3_main_sc_ogr_ogre_kingdoms = {
            wh3_main_ogr_butcher_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh3_main_ogr_butcher_great_maw = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_of_great_maw",
            },
            wh3_main_ogr_firebelly = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh3_main_ogr_slaughtermaster_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh3_main_ogr_slaughtermaster_great_maw = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_of_great_maw",
            },
            wh3_main_ogr_skrag_the_slaughterer = {
                DefaultWizardLevel = 4,
                Lore = "wh3_main_lore_of_great_maw",
            },
        },
        -- Norsca
        wh_main_sc_nor_norsca = {
            wh_dlc08_nor_fimir_balefiend_fire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh_dlc08_nor_fimir_balefiend_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_dlc08_nor_shaman_sorcerer_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh_dlc08_nor_shaman_sorcerer_fire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            wh_dlc08_nor_shaman_sorcerer_metal = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
        },
        -- Nurgle
        wh3_main_sc_nur_nurgle = {
            wh3_main_nur_plagueridden_death = {
                DefaultWizardLevel = 0,
                Lore = "wh_main_lore_death",
            },
            wh3_main_nur_plagueridden_nurgle = {
                DefaultWizardLevel = 0,
                Lore = "wh3_main_lore_nurgle",
            },
            wh3_main_nur_herald_of_nurgle_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh3_main_nur_herald_of_nurgle_nurgle = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_nurgle",
            },
            wh3_main_nur_exalted_great_unclean_one_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            wh3_main_nur_exalted_great_unclean_one_nurgle = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_nurgle",
            },
            wh3_main_nur_kugath = {
                DefaultWizardLevel = 2,
                Lore = "wh3_main_lore_nurgle",
            },
        },
        -- Skaven
        wh2_main_sc_skv_skaven = {
            wh2_main_skv_plague_priest = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_main_lore_plague",
            },
            wh2_main_skv_warlock_engineer = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_main_lore_ruin",
            },
            wh2_dlc14_skv_eshin_sorcerer = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc14_lore_stealth",
            },
            wh2_dlc12_skv_warlock_master = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_ruin",
            },
            wh2_dlc12_skv_ikit_claw = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_ruin",
            },
            wh2_main_skv_grey_seer_plague = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "wh2_main_lore_grey_seer_plague",
            },
            wh2_main_skv_grey_seer_ruin = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "wh2_main_lore_grey_seer_ruin",
            },
            wh2_main_skv_lord_skrolk = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_plague",
            },
        },
        -- Slaanesh
        wh3_main_sc_sla_slaanesh = {
            wh3_main_sla_alluress_shadow = {
                DefaultWizardLevel = 0,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh3_main_sla_alluress_slaanesh = {
                DefaultWizardLevel = 0,
                Lore = "wh3_main_lore_slaanesh",
            },
            wh3_main_sla_herald_of_slaanesh_shadow = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh3_main_sla_herald_of_slaanesh_slaanesh = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_slaanesh",
            },
            wh3_main_sla_exalted_keeper_of_secrets_shadow = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh3_main_sla_exalted_keeper_of_secrets_slaanesh = {
                DefaultWizardLevel = 3,
                Lore = "wh3_main_lore_slaanesh",
            },
            wh3_main_sla_nkari = {
                DefaultWizardLevel = 2,
                Lore = "wh3_main_lore_slaanesh",
            },
        },
        -- Tomb Kings
        wh2_dlc09_sc_tmb_tomb_kings = {
            wh2_dlc09_tmb_liche_priest_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc09_tmb_liche_priest_light = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_light",
            },
            wh2_dlc09_tmb_liche_priest_nehekhara = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc09_lore_nehekhara",
            },
            wh2_dlc09_tmb_liche_priest_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_dlc09_tmb_arkhan = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc09_tmb_khatep = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "wh2_dlc09_lore_nehekhara",
            },
            wh2_dlc09_tmb_settra = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc09_lore_nehekhara",
            },
        },
        -- Tzeentch
        wh3_main_sc_tze_tzeentch = {
            wh3_main_tze_cultist = {
                DefaultWizardLevel = 0,
                Lore = "wh_main_lore_fire",
            },
            wh3_main_tze_iridescent_horror_metal = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
            wh3_main_tze_iridescent_horror_tzeentch = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_tzeentch",
            },
            wh3_main_tze_herald_of_tzeentch_metal = {
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_metal",
            },
            wh3_main_tze_herald_of_tzeentch_tzeentch = {
                DefaultWizardLevel = 2,
                Lore = "wh3_main_lore_tzeentch",
            },
            wh3_main_tze_exalted_lord_of_change_metal = {
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_metal",
            },
            wh3_main_tze_exalted_lord_of_change_tzeentch = {
                DefaultWizardLevel = 4,
                Lore = "wh3_main_lore_tzeentch",
            },
            wh3_main_tze_kairos = {
                DefaultWizardLevel = 4,
                Lore = { "wh3_main_lore_tzeentch", "wh_dlc03_lore_beasts", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", },
                HasAccessToFragements = true,
            },
        },
        -- Vampire Coast
        wh2_dlc11_sc_cst_vampire_coast = {
            wh2_dlc11_cst_fleet_captain_vampires = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc11_lore_vampire_pirates",
            },
            wh2_dlc11_cst_fleet_captain_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc11_cst_fleet_captain_deep = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc11_lore_deep",
            },
            wh2_dlc11_cst_admiral_vampires = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_vampire_pirates",
            },
            wh2_dlc11_cst_admiral_death = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc11_cst_admiral_deep = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_deep",
            },
            wh2_dlc11_cst_admiral_fem_vampires = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_vampire_pirates",
            },
            wh2_dlc11_cst_admiral_fem_death = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc11_cst_admiral_fem_deep = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_deep",
            },
            wh2_dlc11_cst_admiral_tech_01 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_vampire_pirates",
            },
            wh2_dlc11_cst_admiral_tech_02 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_deep",
            },
            wh2_dlc11_cst_admiral_tech_03 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_death",
            },
            wh2_dlc11_cst_admiral_tech_04 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_lore_deep",
            },
            wh2_dlc11_cst_noctilus = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = {"wh2_dlc11_lore_vampire_pirates", "wh_dlc05_lore_shadows", },
            },
            wh2_dlc11_cst_cylostra = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "wh2_dlc11_lore_deep",
            },
        },
        -- Vampire Counts
        wh_main_sc_vmp_vampire_counts = {
            wh_main_vmp_necromancer = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
            wh_main_vmp_vampire_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh_dlc05_vmp_vampire_shadow = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_main_vmp_master_necromancer = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_vampires",
            },
            wh_main_vmp_lord = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
            wh_dlc04_vmp_strigoi_ghoul_king = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc04_lore_strigoi",
            },
            wh2_dlc11_vmp_bloodline_blood_dragon = {
                 DefaultWizardLevel = 2,
                Lore = "wh_main_lore_vampires",
            },
            wh2_dlc11_vmp_bloodline_lahmian = {
                DefaultWizardLevel = 3,
                Lore = "wh2_dlc11_vmp_lore_lahmian",
            },
            wh2_dlc11_vmp_bloodline_necrarch = {
                DefaultWizardLevel = 4,
                Lore = "wh2_dlc11_vmp_lore_necrarch",
            },
            wh2_dlc11_vmp_bloodline_strigoi = {
                DefaultWizardLevel = 2,
                Lore = "wh_dlc04_lore_strigoi",
            },
            wh2_dlc11_vmp_bloodline_von_carstein = {
                DefaultWizardLevel = 2,
                Lore = "wh2_dlc11_vmp_lore_von_carstein",
            },
            wh_dlc04_vmp_helman_ghorst = {
                DefaultWizardLevel = 2,
                Lore = "wh_dlc04_lore_helman_ghorst",
            },
            wh_main_vmp_mannfred_von_carstein = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wwl_skill_mannfred_dual_loremaster",
                Lore = { "wh_main_lore_vampires", "wh_main_lore_death", },
            },
            wh_main_vmp_heinrich_kemmler = {
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_vmp_lord_unique_loremaster_lore_of_vampires",
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_vampires",
            },
            wh_dlc04_vmp_vlad_con_carstein = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_vampires",
            },
            wh_dlc05_vmp_red_duke = {
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_vampires",
            },
            wh_pro02_vmp_isabella_von_carstein = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            wh_dlc05_wef_spellsinger_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            wh_dlc05_wef_spellsinger_life = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            wh_dlc05_wef_spellsinger_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_dlc05_wef_ancient_treeman = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_dlc05_lore_life",
            },
            wh_dlc05_wef_branchwraith = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_branchwraith",
            },
            wh2_dlc16_wef_spellweaver_beasts = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            wh2_dlc16_wef_spellweaver_dark = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_dark_magic",
            },
            wh2_dlc16_wef_spellweaver_high = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_high_magic",
            },
            wh2_dlc16_wef_spellweaver_life = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_life",
            },
            wh2_dlc16_wef_spellweaver_shadows = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh_dlc05_wef_durthu = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            wh2_dlc16_wef_ariel = {
                IsLord = false,
                DefaultWizardLevel = 4,
                Lore = { "wh2_main_lore_high_magic", "wh_dlc05_lore_life", "wh2_main_lore_dark_magic", },
            },
            wh2_dlc16_wef_drycha = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_dlc16_wef_coeddil = {
                IsLord = false,
                DefaultWizardLevel = 3,
                Lore = { "wh2_main_lore_dark_magic", "wh_dlc03_lore_beasts", },
            },
            wh2_dlc16_wef_malicious_ancient_treeman_beasts = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_dlc16_wef_malicious_ancient_treeman_life = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_dlc05_lore_life",
            },
            wh2_dlc16_wef_malicious_ancient_treeman_shadows = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "wh_dlc05_lore_shadows",
            },
            wh2_dlc16_wef_malicious_branchwraith_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            wh2_dlc16_wef_malicious_branchwraith_life = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            wh2_dlc16_wef_malicious_branchwraith_shadows = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
        },
    };
end