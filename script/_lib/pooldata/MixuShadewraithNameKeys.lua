-- We need this file so we can identify Legendary Lords by their names in the UI and
-- map them back to their subtype
function GetMixuShadewraithNameKeys()
    return {
        -- Vampire Coast
        wh2_dlc11_sc_cst_vampire_coast = {
            -- Tia Drowna
            names_name_882027 = {
                Surname = "names_name_882028",
                Subtype = "cst_bloodline_tia_drowna",
            },
            -- Khoskog, the Count of Beasts
            names_name_882025 = {
                Surname = "names_name_882026",
                Subtype = "cst_bloodline_khoskog",
            },
        },
    };
end