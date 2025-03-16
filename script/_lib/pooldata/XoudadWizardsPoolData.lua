function GetXoudadWizardsPoolData()
    return {
        -- High Elves
        --[[wh2_main_sc_hef_high_elves = {
            hef_dragon_mage = {
                DefaultWizardLevel = 1,
                --Lore = "wh_main_lore_fire",
                Lore = "lore_fire_dragon_mage",
            },
        },--]]
        wh_main_sc_emp_empire = {
            emp_gold_wizard = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_metal",
            },
        },
    };
end

function GetXoudadUgliesWizardsPoolData()
    return {
        -- Nurgle - Tamurkhan
        wh3_main_sc_nur_nurgle = {
            wh3_dlc25_nur_skin_wolf_werekin_chieftain = {
                DefaultWizardLevel = 2,
                Lore = { "wh_dlc05_lore_shadows", "wh_main_lore_heavens", },
            },
        },
        
    };
end

function GetXoudadDragonMagePoolData()
    return {
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            hef_dragon_mage = {
                DefaultWizardLevel = 1,
                Lore = "lore_fire_dragon_mage",
                BaseLore = "wh_main_lore_fire",
            },
        },
        
    };
end
