function GetKislevWizardsPoolData()
    return {
        -- Kislev
        -- Note: Kislev does have it's own subculture (wh_main_sc_ksl_kislev)
        -- but in vanilla they reuse empire data.
        -- Rather than trying to detect this, I just lump this with Empire
        wh_main_sc_emp_empire = {
            mixu_katarin_the_ice_queen = {
                DefaultWizardLevel = 4,
                Lore = "mixu_lore_of_ice",
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "mixu_ksl_katarin_bokha_unique_loremaster_of_ice_magic",
            },
            wh2_deco_icewitch = {
                DefaultWizardLevel = 1,
                Lore = "deco_lore_of_ice",
            },
            wh2_deco_hag = {
                DefaultWizardLevel = 1,
                Lore = "deco_lore_of_hags",
            },
        },
    };
end