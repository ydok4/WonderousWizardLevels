function GetCataphWizardsPoolData()
    return {
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            AK_hef_dragonmage = {
                DefaultWizardLevel = 1,
                --Lore = "wh_main_lore_fire",
                Lore = "lore_fire_dragon_mage",
            },
        },
        -- TEB
        -- Note: TEB does have it's own subculture (wh_main_sc_teb_teb)
        -- but in vanilla they reuse empire data.
        -- Rather than trying to detect this, I just lump this with Empire.
        wh_main_sc_emp_empire = {
            teb_gashnag = {
                DefaultWizardLevel = 3,
                Lore = "wh_dlc05_lore_shadows",
            },
            teb_lucrezzia_belladonna = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_death",
            },
        },
    };
end