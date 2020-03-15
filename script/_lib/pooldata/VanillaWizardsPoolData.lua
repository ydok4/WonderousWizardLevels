function GetVanillaWizardsPoolDataResources()
    return {
        wh_dlc03_sc_bst_beastmen = {
            -- Beastmen
            dlc03_bst_bray_shaman_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            dlc03_bst_bray_shaman_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            dlc03_bst_bray_shaman_shadows = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            dlc03_bst_bray_shaman_wild = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Wild",
            },
            dlc03_bst_malagor = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = {"Wild", "Death", "Shadows", "Beasts", },
            },
        },
        -- Bretonnia
        wh_main_sc_brt_bretonnia = {
            brt_damsel = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Heavens",
            },
            brt_damsel_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            brt_damsel_life = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Life",
            },
            dlc07_brt_prophetess_beasts = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Beasts",
            },
            dlc07_brt_prophetess_heavens = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Heavens",
            },
            dlc07_brt_prophetess_life = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Life",
            },
            -- Fay enchantress
            dlc07_brt_fay_enchantress = {
                IsLord = true,
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_dlc07_skill_brt_lord_unique_fay_enchantress_loremaster_lore_of_life",
                LoremasterCharacterNodeSkillKey = "wh_dlc07_skill_node_brt_fay_enchantress_unique_05",
                Lore = {"Life", "Beasts", "Heavens", },
            },
        },
        -- Chaos
        wh_main_sc_chs_chaos = {
            chs_archaon = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Fire",
            },
            chs_chaos_sorcerer_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            chs_chaos_sorcerer_fire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Fire",
            },
            chs_chaos_sorcerer_metal = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Metal",
            },
            dlc07_chs_chaos_sorcerer_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            chs_sorcerer_lord_death = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Death",
            },
            chs_sorcerer_lord_fire = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Fire",
            },
            chs_sorcerer_lord_metal = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Metal",
            },
            dlc07_chs_sorcerer_lord_shadow = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Shadows",
            },
        },
        -- Dark Elves
        wh2_main_sc_def_dark_elves = {
            wh2_main_def_sorceress_dark = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Dark",
            },
            wh2_main_def_sorceress_fire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Fire",
            },
            wh2_main_def_sorceress_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            wh2_dlc10_def_sorceress_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            wh2_dlc10_def_sorceress_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            wh2_dlc10_def_supreme_sorceress_beasts = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Beasts",
            },
            wh2_dlc10_def_supreme_sorceress_dark = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Dark",
            },
            wh2_dlc10_def_supreme_sorceress_death = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Death",
            },
            wh2_dlc10_def_supreme_sorceress_fire = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Fire",
            },
            wh2_dlc10_def_supreme_sorceress_shadow = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Shadows",
            },
            wh2_main_def_morathi = {
                IsLord = true,
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh2_main_def_morathi_loremaster_lore_of_dark_magic",
                LoremasterCharacterNodeSkillKey = "wwl_upgraded_wizard_level_wh2_main_def_morathi",
                Lore = {"Dark", "Death", "Shadows",},
            },
            wh2_main_def_malekith = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Dark",
            },
        },
        -- Dwarfs
        wh_main_sc_dwf_dwarfs = {

        },
        -- Empire
        wh_main_sc_emp_empire = {
            dlc05_emp_grey_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            dlc05_emp_jade_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Life",
            },
            emp_bright_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Fire",
            },
            emp_celestial_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Heavens",
            },
            wh2_pro07_emp_amethyst_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            dlc03_emp_amber_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            emp_light_wizard = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Light",
            },
            emp_balthasar_gelt = {
                IsLord = true,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_emp_lord_unique_balthasar_loremaster_lore_of_metal",
                LoremasterCharacterNodeSkillKey = "wh_main_skill_node_emp_balthasar_unique_05",
                DefaultWizardLevel = 4,
                Lore = "Metal",
            },
        },
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            grn_orc_shaman = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "BigWaaagh",
            },
            grn_night_goblin_shaman = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "LilWaaagh",
            },
            grn_goblin_great_shaman = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "LilWaaagh",
            },
            dlc06_grn_wurrzag_da_great_prophet = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "BigWaaagh",
            },
            grn_azhag_the_slaughterer = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Azhag",
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            wh2_main_hef_loremaster_of_hoeth = {
                IsLord = false,
                DefaultWizardLevel = 2,
                Lore = "LoremasterOfHoeth",
            },
            wh2_main_hef_mage_high = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "High",
            },
            wh2_main_hef_mage_life = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Life",
            },
            wh2_main_hef_mage_light = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Light",
            },
            wh2_dlc10_hef_mage_heavens = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Heavens",
            },
            wh2_dlc10_hef_mage_shadows = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            wh2_main_hef_teclis = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Teclis",
            },
            wh2_dlc10_hef_alarielle = {
                IsLord = true,
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh2_dlc10_hef_alarielle_loremaster_lore_of_light_magic",
                LoremasterCharacterNodeSkillKey = "wwl_upgraded_wizard_level_wh2_dlc10_skill_node_hef_alarielle",
                Lore = {"Light", "Life", "High"},
            },
        },
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = {
            wh2_dlc12_lzd_tlaqua_skink_priest_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            wh2_dlc12_lzd_tlaqua_skink_priest_heavens = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Heavens",
            },
            wh2_main_lzd_skink_priest_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            wh2_main_lzd_skink_priest_heavens = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Heavens",
            },
            wh2_dlc12_lzd_tehenhauin = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Beasts",
            },
            wh2_main_lzd_lord_mazdamundi = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_main_lzd_slann_mage_priest = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_main_lzd_slann_mage_priest_horde = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_dlc13_lzd_slann_mage_priest_fire_horde = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_dlc13_lzd_slann_mage_priest_high = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_dlc13_lzd_slann_mage_priest_high_horde = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_dlc13_lzd_slann_mage_priest_life = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
            wh2_dlc13_lzd_slann_mage_priest_life_horde = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
        },
        -- Norsca
        wh_main_sc_nor_norsca = {
            wh_dlc08_nor_fimir_balefiend_fire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Fire",
            },
            wh_dlc08_nor_fimir_balefiend_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            wh_dlc08_nor_shaman_sorcerer_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            wh_dlc08_nor_shaman_sorcerer_fire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Fire",
            },
            wh_dlc08_nor_shaman_sorcerer_metal = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Metal",
            },
        },
        -- Skaven
        wh2_main_sc_skv_skaven = {
            wh2_main_skv_plague_priest = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Plague",
            },
            wh2_main_skv_warlock_engineer = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Ruin",
            },
            wh2_dlc14_skv_eshin_sorcerer = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Stealth",
            },
            wh2_dlc12_skv_warlock_master = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Ruin",
            },
            wh2_dlc12_skv_ikit_claw = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Ruin",
            },
            wh2_main_skv_grey_seer_plague = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "GreySeerPlague",
            },
            wh2_main_skv_grey_seer_ruin = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "GreySeerRuin",
            },
            wh2_main_skv_lord_skrolk = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Plague",
            },
        },
        -- Tomb Kings
        wh2_dlc09_sc_tmb_tomb_kings = {
            wh2_dlc09_tmb_liche_priest_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            wh2_dlc09_tmb_liche_priest_light = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Light",
            },
            wh2_dlc09_tmb_liche_priest_nehekhara = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Nehekhara",
            },
            wh2_dlc09_tmb_liche_priest_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            wh2_dlc09_tmb_arkhan = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Death",
            },
            wh2_dlc09_tmb_khatep = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Nehekhara",
            },
            wh2_dlc09_tmb_settra = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "Nehekhara",
            },
        },
        -- Vampire Coast
        wh2_dlc11_sc_cst_vampire_coast = {
            wh2_dlc11_cst_fleet_captain = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "VampiresDeeps",
            },
            wh2_dlc11_cst_fleet_captain_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            wh2_dlc11_cst_fleet_captain_deep = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Deep",
            },
            wh2_dlc11_cst_admiral = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "VampiresDeeps",
            },
            wh2_dlc11_cst_admiral_death = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Death",
            },
            wh2_dlc11_cst_admiral_deep = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Deep",
            },
            wh2_dlc11_cst_admiral_fem = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "VampiresDeeps",
            },
            wh2_dlc11_cst_admiral_fem_death = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Death",
            },
            wh2_dlc11_cst_admiral_fem_deep = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Deep",
            },
            wh2_dlc11_cst_admiral_tech_01 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "VampiresDeeps",
            },
            wh2_dlc11_cst_admiral_tech_02 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Deep",
            },
            wh2_dlc11_cst_admiral_tech_03 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Death",
            },
            wh2_dlc11_cst_admiral_tech_04 = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Deep",
            },
            wh2_dlc11_cst_noctilus = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = {"VampiresDeeps", "Shadows", },
            },
            wh2_dlc11_cst_cylostra = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Deep",
            },
        },
        -- Vampire Counts
        wh_main_sc_vmp_vampire_counts = {
            vmp_necromancer = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Vampires",
            },
            vmp_vampire = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            wh_dlc05_vmp_vampire_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            vmp_master_necromancer = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Vampires",
            },
            vmp_lord = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "Vampires",
            },
            dlc04_vmp_strigoi_ghoul_king = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "Vampires",
            },
            wh2_dlc11_vmp_bloodline_blood_dragon = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Vampires",
            },
            wh2_dlc11_vmp_bloodline_lahmian = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Vampires",
            },
            wh2_dlc11_vmp_bloodline_necrarch = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Vampires",
            },
            wh2_dlc11_vmp_bloodline_strigoi = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Vampires",
            },
            wh2_dlc11_vmp_bloodline_von_carstein = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Vampires",
            },
            dlc04_vmp_helman_ghorst = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "GhorstLoreVampires",
            },
            vmp_mannfred_von_carstein = {
                IsLord = true,
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wwl_skill_mannfred_dual_loremaster",
                LoremasterCharacterNodeSkillKey = "wwl_upgraded_wizard_level_vmp_mannfred",
                Lore = "Mannfred",
            },
            vmp_heinrich_kemmler = {
                IsLord = true,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_vmp_lord_unique_loremaster_lore_of_vampires",
                LoremasterCharacterNodeSkillKey = "wh_main_skill_node_vmp_heinrich_unique_04",
                DefaultWizardLevel = 4,
                Lore = "Vampires",
            },
            dlc04_vmp_vlad_con_carstein = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Vampires",
            },
            wh_dlc05_vmp_red_duke = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Vampires",
            },
            pro02_vmp_isabella_von_carstein = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "Vampires",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            dlc05_wef_spellsinger_beasts = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
            dlc05_wef_spellsinger_life = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Life",
            },
            dlc05_wef_spellsinger_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            dlc05_wef_ancient_treeman = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Life",
            },
            wh_dlc05_wef_branchwraith = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "BranchWraith",
            },
            -- Durthu
            dlc05_wef_durthu = {
                IsLord = true,
                DefaultWizardLevel = 1,
                Lore = "Beasts",
            },
        },
    };
end