-- We need this file so we can identify Legendary Lords by their names in the UI and
-- map them back to their subtype
function GetVanillaLegendaryLordNameKeys()
    return {
        -- All
        all = {
            -- Be'lakor
            names_name_1088515835 = {
                Surname = "names_name_1088515835",
                Subtype = "wh3_main_dae_belakor",
            },
        },
        -- Beastmen
        wh_dlc03_sc_bst_beastmen = {
            -- Malagor
            names_name_2147357619 = {
                Surname = "names_name_2147358923",
                Subtype = "dlc03_bst_malagor",
            },
        },
        -- Bretonnia
        wh_main_sc_brt_bretonnia = {
            -- The Fay Enchantress
            names_name_2147358931 = {
                Surname = "",
                Subtype = "dlc07_brt_fay_enchantress",
            },
        },
        -- Chaos
        wh_main_sc_chs_chaos = {
            -- Archaon
            names_name_2147343903 = {
                Surname = "names_name_2147357364",
                Subtype = "chs_archaon",
            },
        },
        -- Daemons of Chaos
        wh3_main_sc_dae_daemons = {
            -- The daemon prince won't actually show up in the Generals panel
            -- so we don't need to come up with a solution (phew).
        },
        -- Cathay
        wh3_main_sc_cth_cathay = {
            -- Miao Ying, the Storm Dragon
            names_name_1909115770 = {
                Surname = "",
                Subtype = "wh3_main_cth_miao_ying",
            },
            -- Zhao Ming, the Iron Dragon
            names_name_806936419 = {
                Surname = "",
                Subtype = "wh3_main_cth_zhao_ming",
            },
        },
        -- Dark Elves
        wh2_main_sc_def_dark_elves = {
            -- Morathi
            names_name_2147359274 = {
                Surname = "",
                Subtype = "wh2_main_def_morathi",
            },
            -- Malekith
            names_name_2147359265 = {
                Surname = "",
                Subtype = "wh2_main_def_malekith",
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {
            -- Balthasar Gelt
            names_name_2147343922 = {
                Surname = "names_name_2147343928",
                Subtype = "emp_balthasar_gelt",
            },
        },
        -- Greenskins
        wh_main_sc_grn_greenskins = {
            -- Wurrzagg Da Great Green Prophet
            names_name_2147358023 = {
                Surname = "names_name_2147358027",
                Subtype = "dlc06_grn_wurrzag_da_great_prophet",
            },
            -- Azhag the Slaughterer
            names_name_2147345906 = {
                Surname = "names_name_2147357356",
                Subtype = "grn_azhag_the_slaughterer",
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            -- Teclis
            names_name_2147359256 = {
                Surname = "",
                Subtype = "wh2_main_hef_teclis",
            },
            -- Alarielle the Radiant
            names_name_898828143 = {
                Surname = "",
                Subtype = "wh2_dlc10_hef_alarielle",
            },
        },
        -- Kislev
        wh3_main_sc_ksl_kislev = {
            -- Tzarina Katarin
            names_name_651938448 = {
                Surname = "",
                Subtype = "wh3_main_ksl_katarin",
            },
        },
        -- Lizardmen
        wh2_main_sc_lzd_lizardmen = {
            -- Tehenhauin
            names_name_1247571489 = {
                Surname = "",
                Subtype = "wh2_dlc12_lzd_tehenhauin",
            },
            -- Lord Mazdamundi
            names_name_871739041 = {
                Surname = "",
                Subtype = "wh2_main_lzd_lord_mazdamundi",
            },
        },
        -- Ogre Kingdoms
        wh3_main_sc_ogr_ogre_kingdoms = {
            -- Skrag the Slaughterer
            names_name_699708189 = {
                Surname = "",
                Subtype = "wh3_main_ogr_skrag_the_slaughterer",
            },
        },
        -- Norsca
        wh_main_sc_nor_norsca = {

        },
        -- Nurgle
        wh3_main_sc_nur_nurgle = {
            -- Ku'gath Plaguefather
            names_name_2059659072 = {
                Surname = "",
                Subtype = "wh3_main_nur_kugath",
            },
        },
        -- Skaven
        wh2_main_sc_skv_skaven = {
            -- Ikit Clawk
            names_name_1400581194 = {
                Surname = "names_name_1574593534",
                Subtype = "wh2_dlc12_skv_ikit_claw",
            },
            -- Lord Skrolk
            names_name_2147359289 = {
                Surname = "names_name_2147359296",
                Subtype = "wh2_main_skv_lord_skrolk",
            },
        },
        -- Slaanesh
        wh3_main_sc_sla_slaanesh = {
            -- N'Kari
            names_name_1637310637 = {
                Surname = "",
                Subtype = "wh3_main_lore_slaanesh",
            },
        },
        -- Tzeentch
        wh3_main_sc_tze_tzeentch = {
            -- Kairos Fateweaver
            names_name_2107401518 = {
                Surname = "",
                Subtype = "wh3_main_tze_kairos",
            },
        },
        -- TEB
        wh_main_sc_teb_teb = {

        },
        -- Tomb Kings
        wh2_dlc09_sc_tmb_tomb_kings = {
            -- Arkhan the Black
            names_name_1543395740 = {
                Surname = "",
                Subtype = "wh2_dlc09_tmb_arkhan",
            },
            -- Grand Hierophant Khatep
            names_name_743554178 = {
                Surname = "",
                Subtype = "wh2_dlc09_tmb_khatep",
            },
            -- Settra the Imperishable
            names_name_1906048114 = {
                Surname = "",
                Subtype = "wh2_dlc09_tmb_settra",
            },
        },
        -- Vampire Coast
        wh2_dlc11_sc_cst_vampire_coast = {
            -- Count Noctilus
            names_name_227765640 = {
                Surname = "",
                Subtype = "wh2_dlc11_cst_noctilus",
            },
            -- Cylostra Direfin
            names_name_143098456 = {
                Surname = "names_name_758220496",
                Subtype = "wh2_dlc11_cst_cylostra",
            },
        },
        -- Vampire Counts
        wh_main_sc_vmp_vampire_counts = {
            -- Helman Ghorst
            names_name_2147358044 = {
                Surname = "names_name_2147345294",
                Subtype = "dlc04_vmp_helman_ghorst",
            },
            -- Mannfred von Carstein
            names_name_2147357490 = {
                Surname = "",
                Subtype = "vmp_mannfred_von_carstein",
            },
            -- Heinrich Kemmler
            names_name_2147345320 = {
                Surname = "names_name_2147345313",
                Subtype = "vmp_heinrich_kemmler",
            },
            -- Vlad von Carstein
            names_name_2147345130 = {
                Surname = "names_name_2147343895",
                Subtype = "dlc04_vmp_vlad_con_carstein",
            },
            -- The Red Duke
            names_name_2147359236 = {
                Surname = "",
                Subtype = "wh_dlc05_vmp_red_duke",
            },
            -- Isabella von Carstein
            names_name_2147345124 = {
                Surname = "names_name_2147343895",
                Subtype = "pro02_vmp_isabella_von_carstein",
            },
        },
        -- Wood Elves
        wh_dlc05_sc_wef_wood_elves = {
            -- Durthu
            names_name_2147352813 = {
                Surname = "",
                Subtype = "dlc05_wef_durthu",
            },
            -- Ariel
            names_name_671478894 = {
                Surname = "",
                Subtype = "wh2_dlc16_wef_ariel",
            },
            -- Drycha
            names_name_252873721 = {
                Surname = "",
                Subtype = "wh2_dlc16_wef_drycha",
            },
            -- Coedill
            names_name_1535812850 = {
                Surname = "",
                Subtype = "wh2_dlc16_wef_coeddil",
            },
        },
    };
end