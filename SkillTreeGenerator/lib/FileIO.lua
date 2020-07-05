require '/SkillTreeGenerator/lib/Table';

local VanillaDBs = {};
function LoadVanillaDBs()
    print("\n\nLoading supported db files");
    -- Load the core vanilla files
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_level_to_effects_junctions_tables_data__.tsv", "character_skill_level_to_effects_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_links_tables_data__.tsv", "character_skill_node_links_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_data__.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_data__.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ws_sav_orc_great_shaman.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skills_tables_data__.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skills__.loc.tsv", "character_skills_loc");
    LoadFile("SkillTreeGenerator/DB/Core/effects_tables_data__.tsv", "effects_tables");
    LoadFile("SkillTreeGenerator/DB/Core/effect_bonus_value_unit_ability_junctions_tables_data__.tsv", "effect_bonus_value_unit_ability_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/special_ability_group_parents_tables_data__.tsv", "special_ability_group_parents_tables");
    LoadFile("SkillTreeGenerator/DB/Core/special_ability_groups_tables_data__.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/special_ability_groups_to_unit_abilities_junctions_tables_data__.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/unit_abilities_tables_data__.tsv", "unit_abilities_tables");
    -- Load the additional supported mod files
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_aa_mixu_ll_I_redux.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_ab_kouran_darkhand.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_mixu_ttl.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_AK_teb.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_AK_mages.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_ws_.tsv", "character_skill_node_sets_tables");

    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_!_ab_mixu_le_override.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_hef_belannaer.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_lzd_lord_huinitenuchli.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_lzd_tetto_eko.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_chs_egrimm_van_horstmann.tsv", "character_skill_nodes_tables");
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
                Colummns = {},
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