require '/SkillTreeGenerator/lib/Table';

local VanillaDBs = {};
function LoadVanillaDBs()
    print("\n\nLoading supported db files");
    -- Load the core vanilla files
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_level_to_effects_junctions_tables_data__.tsv", "character_skill_level_to_effects_junctions_tables");

    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_links_tables_data__.tsv", "character_skill_node_links_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_data__.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_data__.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ws_generic_lords.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skills_tables_data__.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skills__.loc.tsv", "character_skills_loc");
    LoadFile("SkillTreeGenerator/DB/Core/effects_tables_data__.tsv", "effects_tables");
    LoadFile("SkillTreeGenerator/DB/Core/effect_bonus_value_unit_ability_junctions_tables_data__.tsv", "effect_bonus_value_unit_ability_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/special_ability_group_parents_tables_data__.tsv", "special_ability_group_parents_tables");
    LoadFile("SkillTreeGenerator/DB/Core/special_ability_groups_tables_data__.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/special_ability_groups_to_unit_abilities_junctions_tables_data__.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/unit_abilities_tables_data__.tsv", "unit_abilities_tables");

    -- Kislev
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_level_to_effects_junctions_tables_mixu_ice_magic.tsv", "character_skill_level_to_effects_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_level_to_effects_junctions_tables_KisD_icewitch.tsv", "character_skill_level_to_effects_junctions_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effects_tables_KisD_icewitch.tsv", "effects_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effects_tables_mixu_katarin.tsv", "effects_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effect_bonus_value_unit_ability_junctions_tables_KisD_icewitch.tsv", "effect_bonus_value_unit_ability_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effect_bonus_value_unit_ability_junctions_tables_mixu_ice_magic.tsv", "effect_bonus_value_unit_ability_junctions_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_node_sets_tables_KisD_characters.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_node_sets_tables_mixu_katarin.tsv", "character_skill_node_sets_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_nodes_tables_KisD_witches.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_nodes_tables_mixu_katarin.tsv", "character_skill_nodes_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skills_tables_KisD_icewitch.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skills_tables_mixu_katarin.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/KisD_character_skills.loc.tsv", "character_skills_loc");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/KisD_character_skills_magic.loc.tsv", "character_skills_loc");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/mixu_ice_magic.loc.tsv", "character_skills_loc");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_tables_KisD_icewitch.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_tables_mixu_katarin.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_to_unit_abilities_junctions_tables_KisD_icewitch.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_to_unit_abilities_junctions_tables_mixu_katarin.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/unit_abilities_tables_KisD_icewitch.tsv", "unit_abilities_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/unit_abilities_tables_mixu_katarin.tsv", "unit_abilities_tables");

    -- Load the additional supported mod files
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_aa_mixu_ll_I_redux.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_ab_kouran_darkhand.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_mixu_ttl.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_AK_teb.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_AK_mages.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WezSpeshul/character_skill_node_sets_tables_ws_.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_node_sets_tables_mixu_mousillon.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Deco/character_skill_node_sets_tables_data__deco_beastmen_shaman.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Lichemaster/character_skill_node_sets_tables_AK_hobo.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/All Slann Lores/character_skill_node_sets_tables_obsidian_new_slann.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Xoudad - Dragon Mage/character_skill_node_sets_tables_xou_hef_dragon_mage.tsv", "character_skill_node_sets_tables");

    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_!_ab_mixu_le_override.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_hef_belannaer.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_bst_slugtongue.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_lzd_lord_huinitenuchli.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_lzd_tetto_eko.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_chs_egrimm_van_horstmann.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_skv_feskit.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_le_huss.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_wef_naeith.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_empire.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_greenskins.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_norsca.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_tomb_kings.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_wood_elves.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_AK_teb_LL_gashnag.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_AK_teb_LL_lucrezzia.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_AK_mages.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_!!!!!aa_mixu_red_duke.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_mixu_mousillon_bloodlines.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_mixu_mousillon_characters.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_mixu_mousillon_knights_of_mallobaude.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Deco/character_skill_nodes_tables_data__deco_beastmen_shaman.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Lichemaster/character_skill_nodes_tables_AAK_hobo_heroes.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WezSpeshul/character_skill_nodes_tables_ws_generic_lords.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/All Slann Lores/character_skill_nodes_tables_obsidian_new_slann.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Xoudad - Dragon Mage/character_skill_nodes_tables_!xou_hef_dragon_mage.tsv", "character_skill_nodes_tables");

    return VanillaDBs;
end

function LoadFile(fileName, addToFileName)
    print("Loading: "..fileName);
    local lineNumber = 1;
    local file = assert(io.open(fileName, "r"));
    local columnHeadingIndexes = {};
    local fileKey = fileName;
    if addToFileName ~= nil then
        fileKey = addToFileName;
    end
    for line in file:lines() do
        local fields = Split(line, "\t");
        if lineNumber == 1
        and VanillaDBs[fileKey] == nil then
            VanillaDBs[fileKey] = Table:new({
                Header = {},
                Columns = {},
                Data = {},
            });
            VanillaDBs[fileKey]:AddToHeader(fields);
        elseif lineNumber == 2 then
            for index, columnKey in pairs(fields) do
                columnHeadingIndexes[columnKey] = index;
            end
            if #VanillaDBs[fileKey].Header == 1 then
                VanillaDBs[fileKey]:AddToHeader(fields);
            end
            VanillaDBs[fileKey]:AddColumns(columnHeadingIndexes);
        elseif lineNumber > 2 then
            VanillaDBs[fileKey]:AddRows(fields);
        end
        lineNumber = lineNumber + 1;
    end
    file:close();
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      result[#result + 1] = match;
    end
    return result;
end