function GetCataphWizardsPoolData()
    return {
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            AK_hef_dragonmage = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Fire",
            },
        },
        -- TEB
        wh_main_sc_emp_empire = {
            teb_gashnag = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Shadows",
            },
            teb_lucrezzia_belladonna = {
                IsLord = true,
                DefaultWizardLevel = 3,
                Lore = "Death",
            },
        },
    };
end