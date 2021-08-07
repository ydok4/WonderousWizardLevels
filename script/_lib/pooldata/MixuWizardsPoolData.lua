function GetMixuWizardsPoolData()
    return {
        -- Beastmen
        wh_dlc03_sc_bst_beastmen = {
            bst_slugtongue = {
                DefaultWizardLevel = 2,
                Lore = { "wh_dlc03_lore_wild", "wh_dlc05_lore_shadows", },
            },
        },

        -- Chaos
        wh_main_sc_chs_chaos = {
            chs_egrimm_van_horstmann = {
                DefaultWizardLevel = 4,
                Lore = "wh_main_lore_light",
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {
            emp_wizard_lord_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            emp_wizard_lord_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            emp_wizard_lord_fire = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_fire",
            },
            emp_wizard_lord_heavens = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_heavens",
            },
            emp_wizard_lord_life = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_life",
            },
            emp_wizard_lord_light = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_light",
            },
            emp_wizard_metal = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
            emp_wizard_lord_metal = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
            emp_wizard_lord_shadow = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            -- LL1
            mixu_elspeth_von_draken = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_vmp_lord_unique_mannfred_loremaster_lore_of_death",
                LoremasterCharacterNodeSkillKey = "wwl_upgraded_wizard_level_mixu_elspeth_von_draken",
                Lore = "wh_main_lore_death",
            },
            -- Replaced by Deco's Kislev
            --[[mixu_katarin_the_ice_queen = {
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "mixu_ksl_katarin_bokha_unique_loremaster_of_ice_magic",
                LoremasterCharacterNodeSkillKey = "wwl_diviner_mixu_katarin_the_ice_queen",
                Lore = "Ice",
            },--]]
        },
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            grn_savage_orc_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_big_waaagh",
            },
            grn_orc_great_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_big_waaagh",
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            hef_belannaer = {
                DefaultWizardLevel = 4,
                Lore = { "wh2_dlc15_lore_beasts_eagle", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", "wh2_main_lore_high_magic", },
            },
        },
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = {
            -- LL2
            lzd_tetto_eko = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_heavens",
            },
            lzd_lord_huinitenuchli = {
                DefaultWizardLevel = 5,
                Lore = { "wh_dlc03_lore_beasts", "wh_main_lore_death", "wh_main_lore_fire", "wh_main_lore_heavens", "wh_dlc05_lore_life", "wh_main_lore_light", "wh_main_lore_metal", "wh_dlc05_lore_shadows", "wh2_main_lore_high_magic", },
            },
        },
        -- Norsca
        wh_main_sc_nor_norsca = {
            nor_shaman_sorcerer_lord_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            nor_shaman_sorcerer_lord_fire = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_fire",
            },
            nor_shaman_sorcerer_lord_metal = {
                   DefaultWizardLevel = 3,
                Lore = "wh_main_lore_metal",
            },
        },
        -- Skaven
        wh2_main_sc_skv_skaven = {
            skv_grey_seer_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
        },
        -- Tomb Kings
        wh2_dlc09_sc_tmb_tomb_kings = {
            tmb_liche_high_priest_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            tmb_liche_high_priest_light = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_light",
            },
            tmb_liche_high_priest_nehekhara = {
                DefaultWizardLevel = 3,
                Lore = "wh2_dlc09_lore_nehekhara",
            },
            tmb_liche_high_priest_shadow = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
        },
        -- Vampire Counts
        wh_main_sc_vmp_vampire_counts = {
            vmp_damsel_heavens = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            vmp_damsel_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            vmp_damsel_life = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_life",
            },
            vmp_bloodline_dark_prophetess = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            vmp_nicolete_de_oisement = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_vampires",
            },
            vmp_aucassin_de_hane = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            --[[wef_darkweaver = {
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_dark_magic",
            },
            wef_highweaver = {
                DefaultWizardLevel = 3,
                Lore = "wh2_main_lore_high_magic",
            },
            wef_spellweaver = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },--]]
            wef_shadowdancer = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            -- LL1
            --[[wef_drycha = {
                DefaultWizardLevel = 2,
                Lore = "wh_dlc05_lore_shadows",
            },--]]
            -- LL2
            wef_naieth_the_prophetess = {
                DefaultWizardLevel = 4,
                Lore = { "wh_main_lore_heavens", "wh_dlc05_lore_life", },
            },
        },
    };
end