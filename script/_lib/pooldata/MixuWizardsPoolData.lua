function GetMixuWizardsPoolData()
    return {
        -- Chaos
        wh_main_sc_chs_chaos = {
            chs_egrimm_van_horstmann = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Light",
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {
            emp_wizard_metal = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Metal",
            },
            emp_wizard_lord_beasts = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Beasts",
            },
            emp_wizard_lord_light = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Light",
            },
            emp_wizard_lord_fire = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Fire",
            },
            emp_wizard_lord_shadow = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Shadows",
            },
            emp_wizard_lord_heavens = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Heavens",
            },
            -- LL1
            mixu_elspeth_von_draken = {
                IsLord = true,
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "wh_main_skill_vmp_lord_unique_mannfred_loremaster_lore_of_death",
                LoremasterCharacterNodeSkillKey = "wwl_upgraded_wizard_level_mixu_elspeth_von_draken",
                Lore = "Death",
            },
            mixu_katarin_the_ice_queen = {
                IsLord = true,
                DefaultWizardLevel = 4,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "mixu_ksl_katarin_bokha_unique_loremaster_of_ice_magic",
                LoremasterCharacterNodeSkillKey = "wwl_diviner_mixu_katarin_the_ice_queen",
                Lore = "Ice",
            },
        },
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            grn_savage_orc_shaman = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "BigWaaagh",
            },
            grn_orc_great_shaman = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "BigWaaagh",
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            hef_belannaer = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = "Teclis",
            },
        },
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = {
            -- LL2
            lzd_tetto_eko = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Heavens",
            },
            lzd_lord_huinitenuchli = {
                IsLord = true,
                DefaultWizardLevel = 5,
                Lore = "Slann",
            },
        },
        -- Norsca
        wh_main_sc_nor_norsca = {
            nor_shaman_sorcerer_lord_death = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Death",
            },
            nor_shaman_sorcerer_lord_fire = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Fire",
            },
            nor_shaman_sorcerer_lord_metal = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Metal",
            },
        },
        -- Tomb Kings
        wh2_dlc09_sc_tmb_tomb_kings = {
            tmb_liche_high_priest_death = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Death",
            },
            tmb_liche_high_priest_light = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Light",
            },
            tmb_liche_high_priest_nehekhara = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Nehekhara",
            },
            tmb_liche_high_priest_shadow = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Shadows",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            wef_darkweaver = {
                DefaultWizardLevel = 3,
                Lore = "Dark",
            },
            wef_highweaver = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "High",
            },
            wef_spellweaver = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Beasts",
            },
            wef_shadowdancer = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            -- LL1
            wef_drycha = {
                IsLord = true,
                DefaultWizardLevel = 2,
                Lore = "Shadows",
            },
            -- LL2
            wef_naieth_the_prophetess = {
                IsLord = true,
                DefaultWizardLevel = 4,
                Lore = { "Heavens", "Life", },
            },
        },
    };
end