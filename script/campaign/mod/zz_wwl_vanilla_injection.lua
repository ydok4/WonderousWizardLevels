-- CUS is defined in a vanilla script.
-- The script is wh3_campaign_character_upgrading.
if CUS then
    out("WWL: Loading new Daemon Prince Traits");
    local cusTraits = CUS.subtype_to_bonus_traits;

    cusTraits["wh_dlc01_chs_sorcerer_lord_death"]["wh3_dlc20_chs_daemon_prince_undivided"] = "wwl_trait_generic_daemon_prince_fire";
    cusTraits["wh_dlc01_chs_sorcerer_lord_fire"]["wh3_dlc20_chs_daemon_prince_undivided"] = "wwl_trait_generic_daemon_prince_death";
    cusTraits["wh_dlc01_chs_sorcerer_lord_metal"]["wh3_dlc20_chs_daemon_prince_undivided"] = "wwl_trait_generic_daemon_prince_metal";
    cusTraits["wh_dlc07_chs_sorcerer_lord_shadow"]["wh3_dlc20_chs_daemon_prince_undivided"] = "wwl_trait_generic_daemon_prince_shadows";

    cusTraits["wh_dlc07_chs_sorcerer_lord_shadow"]["wh3_dlc20_chs_daemon_prince_slaanesh"] = "wwl_trait_generic_daemon_prince_shadows";
else
    out("WWL: ERROR: Missing campaign upgrades script");
end