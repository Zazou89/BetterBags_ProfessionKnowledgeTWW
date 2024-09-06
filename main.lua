---@class BetterBags: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon("BetterBags")

---@class Categories: AceModule
local categories = addon:GetModule('Categories')

-- Table of profession IDs
local professionIDs = {
    [164] = "Blacksmithing",
    [165] = "Leatherworking",
    [171] = "Alchemy",
    [182] = "Herbalism",
    [185] = "Cooking",
    [186] = "Mining",
    [197] = "Tailoring",
    [202] = "Engineering",
    [333] = "Enchanting",
    [755] = "Jewelcrafting",
    [773] = "Inscription",
    [794] = "Archaeology",
    [356] = "Fishing",
    [393] = "Skinning",
}

-- Localization table
local locales = {
    ["enUS"] = {
        ["KnowledgePoint"] = "KP",
    },
    ["frFR"] = {
        ["KnowledgePoint"] = "PdC",
    },
    ["deDE"] = {},
    ["esES"] = {},
    ["itIT"] = {},
    ["ptBR"] = {}
}

-- Detects current language
local currentLocale = GetLocale()

-- Function to get the translation
local function L(key)
    return locales[currentLocale] and locales[currentLocale][key] or locales["enUS"][key]
end

-- Function to get localized profession names
local function GetLocalizedProfessionNames()
    local localizedProfessionNames = {}
    for id, _ in pairs(professionIDs) do
        local professionName = C_TradeSkillUI.GetTradeSkillDisplayName(id)
        if professionName then
            localizedProfessionNames[id] = professionName
        end
    end
    return localizedProfessionNames
end

-- Get all localized profession names
local localizedProfessionNames = GetLocalizedProfessionNames()

-- Example items for different professions
local itemsByProfession = {
    Alchemy = {
        id = 171,
        items = {
            -- Hidden treasures
            226270, -- Sanctified Mortar and Pestle
            226271, -- Nerubian Mixing Salts
            226265, -- Earthen Iron Powder
            226266, -- Metal Dornogal Frame
            226267, -- Reinforced Beaker
            226268, -- Engraved Stirring Rod
            226269, -- Chemist's Purified Water
            226272, -- Dark Apothecary's Vial
            --Treatise
            222546, -- Algari Treatise on Alchemy
        }
    },

    Blacksmithing = {
        id = 164,
        items = {
            -- Hidden treasures
            226282, -- Nerubian Smith's Kit
            226277, -- Dornogal Hammer
            226279, -- Earthen Chisels
            226281, -- Radiant Tongs
            226283, -- Spiderling's Wire Brush
            226276, -- Ancient Earthen Anvil
            226278, -- Ringing Hammer Vise
            226280, -- Holy Flame Forge
            --Treatise
            222554, -- Algari Treatise on Blacksmithing 
        }
    },  

    Enchanting = {
        id = 333,
        items = {
            -- Hidden treasures
            226284, -- Grinded Earthen Gem
            226285, -- Silver Dornogal Rod
            226286, -- Soot-Coated Orb
            226287, -- Animated Enchanting Dust
            226288, -- Essence of Holy Fire
            226289, -- Enchanted Arathi Scroll
            226290, -- Book of Dark Magic
            226291, -- Void Shard            
            --Treatise
            222550, -- Algari Treatise on Enchanting
        }
    },

    Engineering = {
        id = 202,
        items = {
            -- Hidden treasures
            226298, -- Puppeted Mechanical Spider
            226299, -- Emptied Venom Canister
            226293, -- Dornogal Spectacles
            226294, -- Inert Mining Bomb
            226295, -- Earthen Construct Blueprints
            226296, -- Holy Firework Dud
            226297, -- Arathi Safety Gloves
            226292, -- Rock Engineer's Wrench
            --Treatise
            222621, -- Algari Treatise on Engineering
        }
    },

    Herbalism = {
        id = 182,
        items = {
            -- Hidden treasures
            226305, -- Arathi Herb Pruner
            226306, -- Web-Entangled Lotus
            226300, -- Ancient Flower
            226301, -- Dornogal Gardening Scythe
            226302, -- Earthen Digging Fork
            226303, -- Fungarian Slicer's Knife
            226304, -- Arathi Garden Trowel
            226307, -- Tunneler's Shovel
            --Treatise
            222552, -- Algari Treatise on Herbalism
        }
    },

    Inscription = {
        id = 773,
        items = {
            -- Hidden treasures
            226312, -- Informant's Fountain Pen
            226313, -- Calligrapher's Chiseled Marker
            226314, -- Nerubian Texts
            226308, -- Dornogal Scribe's Quill
            226309, -- Historian's Dip Pen
            226310, -- Runic Scroll
            226311, -- Blue Earthen Pigment
            226315, -- Venomancer's Ink Well
            --Treatise
            222548, -- Algari Treatise on Inscription
        }
    },

    Jewelcrafting = {
        id = 755,
        items = {
            -- Hidden treasures
            226319, -- Jeweler's Delicate Drill
            226320, -- Arathi Sizing Gauges
            226321, -- Librarian's Magnifiers
            226322, -- Ritual Caster's Crystal
            226316, -- Gentle Jewel Hammer
            226317, -- Earthen Gem Pliers
            226318, -- Carved Stone File
            226323, -- Nerubian Bench Blocks
            --Treatise
            222551, -- Algari Treatise on Jewelcrafting
        }
    },

    Leatherworking = {
        id = 165,
        items = {
            -- Hidden treasures
            226326, -- Underground Stropping Compound
            226327, -- Earthen Awl
            226328, -- Arathi Beveler Set
            226329, -- Arathi Leather Burnisher
            226330, -- Nerubian Tanning Mallet
            226324, -- Earthen Lacing Tools
            226325, -- Dornogal Craftsman's Flat Knife
            226331, -- Curved Nerubian Skinning Knife
            --Treatise   
            222549, -- Algari Treatise on Leatherworking         
        }
    },

    Mining = {
        id = 186,
        items = {
            -- Hidden treasures
            226333, -- Dornogal Chisel
            226334, -- Earthen Excavator's Shovel
            226335, -- Regenerating Ore
            226336, -- Arathi Precision Drill
            226337, -- Devout Archaeologist's Excavator
            226338, -- Heavy Spider Crusher
            226339, -- Nerubian Mining Supplies
            226332, -- Earthen Miner's Gavel
            --Treatise
            222553, -- Algari Treatise on Mining
        }
    },

    Skinning = {
        id = 393,
        items = {
            -- Hidden treasures
            226340, -- Dornogal Carving Knife
            226341, -- Earthen Worker's Beams
            226342, -- Artisan's Drawing Knife
            226343, -- Fungarian's Rich Tannin
            226345, -- Arathi Craftsman's Spokeshave
            226344, -- Arathi Tanning Agent
            226347, -- Carapace Shiner
            226346, -- Nerubian's Slicking Iron
            --Treatise
            222649, -- Algari Treatise on Skinning
        }
    },
    
    Tailoring = {
        id = 197,
        items = {
            -- Hidden treasures
            226354, -- Nerubian Quilt
            226355, -- Nerubian's Pincushion
            226349, -- Earthen Tape Measure
            226350, -- Runed Earthen Pins
            226351, -- Earthen Stitcher's Snips
            226352, -- Arathi Rotary Cutter
            226353, -- Royal Outfitter's Protractor
            226348, -- Dornogal Seam Ripper
            --Treatise
            222547, -- Algari Treatise on Tailoring
        }
    },
}

-- Loop through all items and add them to categories
for professionName, professionData in pairs(itemsByProfession) do
    local professionID = professionData.id
    local itemList = professionData.items
    local localizedProfessionName = localizedProfessionNames[professionID]
    if localizedProfessionName then
        for _, itemID in pairs(itemList) do
            categories:AddItemToCategory(itemID, L("KnowledgePoint") .. " : " .. localizedProfessionName)
        end
    end
end