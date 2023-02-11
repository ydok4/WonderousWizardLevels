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
        -- Note: TEB now has several subcultures, potentially:
        -- mixer_teb_southern_realms
        -- wh2_main_emp_new_world_colonies_CB
        -- wh_main_sc_teb_teb
        -- wh_main_teb_border_princes_CB
        -- wh_main_teb_estalia_CB
        -- wh_main_teb_tilea_CB
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