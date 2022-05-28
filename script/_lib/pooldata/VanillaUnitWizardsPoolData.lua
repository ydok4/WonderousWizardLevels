-- Note: This is disabled. The idea didn't work out.
function GetVanillaUnitWizardPoolDataResources()
    return {
        wh3_main_sc_tze_tzeentch = {
            wh3_main_tze_mon_lord_of_change_0 = {
                DefaultWizardLevel = 2,
                Lore = "wh3_main_lore_tzeentch",
            },
        },
        wh3_main_sc_sla_slaanesh = {
            wh3_main_sla_mon_keeper_of_secrets_0 = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_slaanesh",
            },
        },
        wh3_main_sc_nur_nurgle = {
            wh3_main_nur_mon_great_unclean_one_0 = {
                DefaultWizardLevel = 1,
                Lore = "wh3_main_lore_nurgle",
            },
        },
        wh3_main_sc_dae_daemons = {
            -- Daemons will load all the above
        },
    };
end