function GetVanillaWizardsPoolDataResources()
    -- Used by the skill node generator
    if _G.IgnoreVanillaWizards == true then
        return {

        };
    end
    return {
        -- Beastmen
        wh_dlc03_sc_bst_beastmen = {
            dlc03_bst_bray_shaman_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            dlc03_bst_bray_shaman_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            dlc03_bst_bray_shaman_shadows = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            dlc03_bst_bray_shaman_wild = {
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
            dlc03_bst_malagor = {
                DefaultWizardLevel = 4,
                Lore = {"wh_dlc03_lore_wild", "wh_main_lore_death", "wh_dlc05_lore_shadows", "wh_dlc03_lore_beasts", },
            },
        },
        -- Bretonnia
        wh_main_sc_brt_bretonnia = {
            brt_damsel = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            brt_damsel_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            brt_damsel_life = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            dlc07_brt_prophetess_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            dlc07_brt_prophetess_heavens = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_heavens",
            },
            dlc07_brt_prophetess_life = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_life",
            },
            -- Fay enchantress
            dlc07_brt_fay_enchantress = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_dlc07_skill_brt_lord_unique_fay_enchantress_loremaster_lore_of_life",
                Lore = {"wh_dlc05_lore_life", "wh_dlc03_lore_beasts", "wh_main_lore_heavens", },
            },
        },
        -- Chaos
        wh_main_sc_chs_chaos = {
            chs_archaon = {
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_fire",
            },
            chs_chaos_sorcerer_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            chs_chaos_sorcerer_fire = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            chs_chaos_sorcerer_metal = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
            dlc07_chs_chaos_sorcerer_shadow = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            chs_sorcerer_lord_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            chs_sorcerer_lord_fire = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_fire",
            },
            chs_sorcerer_lord_metal = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
            dlc07_chs_sorcerer_lord_shadow = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            chs_lord_of_change = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
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
            dlc06_dwf_runelord = {
                DefaultWizardLevel = 3,
                Lore = "wh2_dlc17_lore_rune",
            },
            dwf_runesmith = {
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc17_lore_rune",
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {
            dlc05_emp_grey_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            dlc05_emp_jade_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            emp_bright_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_fire",
            },
            emp_celestial_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            wh2_pro07_emp_amethyst_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            dlc03_emp_amber_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            emp_light_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_light",
            },
            emp_balthasar_gelt = {
                IsLord = true,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_emp_lord_unique_balthasar_loremaster_lore_of_metal",
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_metal",
            },
        },
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            grn_orc_shaman = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_big_waaagh",
            },
            grn_night_goblin_shaman = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_lil_waaagh",
            },
            grn_goblin_great_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_lil_waaagh",
            },
            wh2_dlc15_grn_goblin_great_shaman_raknik = {
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_lil_waaagh",
            },
            dlc06_grn_wurrzag_da_great_prophet = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_big_waaagh",
            },
            grn_azhag_the_slaughterer = {
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
                Lore = { "wh2_dlc15_lore_beasts_eagle", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", "wh2_main_lore_high_magic", },
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
                Lore = { "wh_dlc03_lore_beasts", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", "wh2_main_lore_high_magic", },
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
        -- Vampire Coast
        wh2_dlc11_sc_cst_vampire_coast = {
            wh2_dlc11_cst_fleet_captain = {
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
            wh2_dlc11_cst_admiral = {
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
            wh2_dlc11_cst_admiral_fem = {
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
            vmp_necromancer = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
            vmp_vampire = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            wh_dlc05_vmp_vampire_shadow = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            vmp_master_necromancer = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_vampires",
            },
            vmp_lord = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
            dlc04_vmp_strigoi_ghoul_king = {
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
            dlc04_vmp_helman_ghorst = {
                DefaultWizardLevel = 2,
                Lore = "wh_dlc04_lore_helman_ghorst",
            },
            vmp_mannfred_von_carstein = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wwl_skill_mannfred_dual_loremaster",
                Lore = { "wh_main_lore_vampires", "wh_main_lore_death", },
            },
            vmp_heinrich_kemmler = {
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_vmp_lord_unique_loremaster_lore_of_vampires",
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_vampires",
            },
            dlc04_vmp_vlad_con_carstein = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_vampires",
            },
            wh_dlc05_vmp_red_duke = {
                DefaultWizardLevel = 2,
                Lore = "wh_main_lore_vampires",
            },
            pro02_vmp_isabella_von_carstein = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            dlc05_wef_spellsinger_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            dlc05_wef_spellsinger_life = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            dlc05_wef_spellsinger_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            dlc05_wef_ancient_treeman = {
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
            dlc05_wef_durthu = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc15_lore_beasts_eagle",
            },
            wh2_dlc16_wef_ariel = {
                IsLord = false,
                DefaultWizardLevel = 4,
                Lore = { "wh_dlc05_lore_life", "wh2_main_lore_dark_magic", "wh2_main_lore_high_magic", },
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