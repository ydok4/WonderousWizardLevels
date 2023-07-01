function GetMixuMousillonWizardsPoolData()
    return {
        -- Vampire Counts - Moussilon
        wh_main_sc_vmp_vampire_counts = {
            msl_dark_prophetess_heavens = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_heavens",
            },
            msl_dark_prophetess_beasts = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc03_lore_beasts",
            },
            msl_dark_prophetess_shadows = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            msl_dark_prophetess_death = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
            msl_lord = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_vampires",
            },
            msl_mallobaude = {
                DefaultWizardLevel = 3,
                RequiredTraits = {
                    mixu_msl_mallobaude_trait_black_grail_vampire = {
                        DefaultWizardLevel = 3,
                        Lore = "wh_dlc05_lore_shadows",
                        OverwriteNumberOfSpells = true,
                    },
                    mixu_msl_mallobaude_trait_arkhan_vampire = {
                        DefaultWizardLevel = 3,
                        Lore = "wh_main_lore_death",
                        OverwriteNumberOfSpells = true,
                    },
                    mixu_msl_mallobaude_trait_von_carstein_vampire= {
                        DefaultWizardLevel = 3,
                        Lore = "wh_main_lore_vampires",
                        OverwriteNumberOfSpells = true,
                    },
                },
            },
            msl_aucassin_de_hane = {
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc11_vmp_lore_von_carstein",
            },
            msl_nicolete_de_oisement = {
                DefaultWizardLevel = 1,
                Lore = "wh2_dlc11_vmp_lore_lahmian",
            },
            msl_damsel_heavens = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_heavens",
            },
            msl_damsel_beasts = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc03_lore_beasts",
            },
            msl_damsel_shadows = {
                DefaultWizardLevel = 1,
                Lore = "wh_dlc05_lore_shadows",
            },
            msl_damsel_death = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_death",
            },
            msl_lady_of_the_black_grail = {
                DefaultWizardLevel = 4,
                Lore = "wh_dlc05_lore_shadows",
            },
        },
    };
end