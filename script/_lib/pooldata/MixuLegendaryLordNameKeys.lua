-- We need this file so we can identify Legendary Lords by their names in the UI and
-- map them back to their subtype
function GetMixuLegendaryLordNameKeys()
    return {
        -- Chaos
        wh_main_sc_chs_chaos = {
            -- Egrimm van Horstmann
            names_name_6450684033 = {
                Surname = "names_name_6450684034n",
                Subtype = "chs_egrimm_van_horstmann",
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {
            -- Elspeth von Draken
            names_name_4870156026 = {
                Surname = "names_name_4870156027",
                Subtype = "mixu_elspeth_von_draken",
            },
            -- Katarin Bokha
            names_name_4870156028 = {
                Surname = "names_name_4870156029",
                Subtype = "mixu_katarin_the_ice_queen",
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            -- Belannaer the Wise
            names_name_2147359994 = {
                Surname = "",
                Subtype = "wh2_main_hef_teclis",
            },
        },
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = {
            -- Tetto’eko
            names_name_6450684015 = {
                Surname = "",
                Subtype = "lzd_tetto_eko",
            },
            -- Lord Huinitenuchli
            names_name_2147360736 = {
                Surname = "",
                Subtype = "lzd_lord_huinitenuchli",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            -- Drycha
            names_name_4870156031 = {
                Surname = "",
                Subtype = "wef_drycha",
            },
            -- Naieth the Prophetess
            names_name_6450684035 = {
                Surname = "names_name_6450684036",
                Subtype = "wef_naieth_the_prophetess",
            },
        },
    };
end