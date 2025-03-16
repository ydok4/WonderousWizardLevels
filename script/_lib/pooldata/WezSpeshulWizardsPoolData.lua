_G.IsIdeWezSpeshulLoaded = true;

function GetWezSpeshulWizardsPoolData()
    return {
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            ws_goblin_shaman = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_lil_waaagh",
            },
            ws_savage_orc_shaman = {
                DefaultWizardLevel = 1,
                Lore = "wh_main_lore_big_waaagh",
            },
            ws_night_goblin_great_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_lil_waaagh",
            },
            ws_orc_great_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_big_waaagh",
            },
            -- Removed in Omens of Destruction
            --[[ws_savage_orc_great_shaman = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_big_waaagh",
            },--]]
            ws_tinitt_foureyes = {
                DefaultWizardLevel = 3,
                Lore = "wh_main_lore_lil_waaagh",
            },
            --[[ws_forest_goblin_shaman = {
                DefaultWizardLevel = 1,
                --Lore = "ws_lore_spider",
                Lore = "wh_main_lore_lil_waaagh",
            },--]]
            --[[wh2_dlc15_grn_goblin_great_shaman_raknik = {
                DefaultWizardLevel = 4,
                Lore = "ws_lore_spider",
                -- Used for skill tree generation
                RowIndent = '2',
            },--]]
        },
    };
end