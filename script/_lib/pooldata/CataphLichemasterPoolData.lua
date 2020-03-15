function GetCataphLichemasterPoolData()
    return {
        wh_main_sc_vmp_vampire_counts = {
            vmp_heinrich_kemmler = {
                IsLord = true,
                IsLoremaster = true,
                LoremasterCharacterSkillKey = "AK_hobo_loremaster_lichemaster",
                LoremasterCharacterNodeSkillKey = "AK_hobo_loremaster_lichemaster",
                DefaultWizardLevel = 4,
                Lore = "Vampires",
            },
            AK_hobo_druid_shadow = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Shadows",
            },
            AK_hobo_druid_death = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Death",
            },
            AK_hobo_druid_heavens = {
                IsLord = false,
                DefaultWizardLevel = 1,
                Lore = "Heavens",
            },
        },
    };
end