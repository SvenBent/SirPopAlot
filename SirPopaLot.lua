--[[

Copyright © 2020, DaneBlood
Copyright 2020, DaneBlood

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'SirPopaLot'
_addon.author = 'Daneblood'
_addon.version = '26.03.24c'
_addon.command = 'pop'

require('coroutine')
require('sets')


local KiProtection = true
local res = nil
local chatColor = 207




--[[
KeyItem = xxx   : Checks for KeyItem and only execute CMD if the key item is NOT present
OpenMenu = true : Opens the menu of the npc object before passing on CMD defined commands
cmd = xxx       : Executes xxx as a command
msg = xxx       : Show the xxx as a message in chatlog
Trades = xxx    : Looks up the trades list for trades
]]--


--------  ||==========================||  --------
--------  || NAME BASED TRADE TABLES  ||  --------
--------  ||==========================||  --------


-- ========================
-- Escha / Geas Fete
-- ========================

local escha_zitah_trades = {
    -- Tier I
	{ keyItem = 2895, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Wepwawet's tooth
	{ keyItem = 2896, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Lydia's vine
	{ keyItem = 2897, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Aglaophotis bud
	{ keyItem = 2898, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Tangata's wing
	{ keyItem = 2899, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Vidala's claw
	{ keyItem = 2900, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Gestalt's retina
	{ keyItem = 2901, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Angrboda's necklace
	{ keyItem = 2902, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Cunnast's talon
	{ keyItem = 2903, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Revetaur's horn
	{ keyItem = 2904, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Ferrodon's scale
	{ keyItem = 2905, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Gulltop's shell
	{ keyItem = 2906, cmd = 'TradeNPC 6 "Fish Mithkabob"' }, -- Vyala's prey

    -- Tier II
    { keyItem = 2911, cmd = 'input /item "Ayapec\'s Shell" <t>' }, -- Ionos's webbing
    { keyItem = 2912, cmd = 'input /item "Ethereal Incense" <t>' }, -- Sandy's lasher
    { keyItem = 2913, cmd = 'input /item "Ayapec\'s Shell" <t>' }, -- Nosoi's feather
    { keyItem = 2914, cmd = 'input /item "Ethereal Incense" <t>' }, -- Brittlis's ring
    { keyItem = 2915, cmd = 'input /item "Ayapec\'s Shell" <t>' }, -- Kamohoalii's fin
    { keyItem = 2916, cmd = 'input /item "Ethereal Incense" <t>' }, -- Umdhlebi's flower

    -- Tier III
	{ keyItem = 2917, cmd = 'TradeNPC 5 "Riftborn Boulder"' }, -- Fleetstalker's claw
	{ keyItem = 2918, cmd = 'TradeNPC 5 "Beitetsu"' }, -- Shockmaw's blubber
	{ keyItem = 2919, cmd = 'TradeNPC 5 "Pluton"' }, -- Urmahlullu's armor

    -- HELM
    { keyItem = 2907, cmd = 'TradeNPC 1 "Duskcrawler" 1 "Gravewood Log"' }, -- Blazewing's pincer
    { keyItem = 2908, cmd = 'TradeNPC 1 "Ashweed" 1 "Gravewood Log"' }, -- Coven's dust
    { keyItem = 2909, cmd = 'TradeNPC 1 "Ashweed" 1 "Duskcrawler"' }, -- Pazuzu's blade hilt
    { keyItem = 2910, cmd = 'TradeNPC 1 "Ashweed" 1 "Duskcrawler" 1 "Gravewood Log"' }, -- Wrathare's carrot
}

local escha_ruan_trades = {
    -- Tier I
	{ keyItem = 2927, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Bia
	{ keyItem = 2928, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Ruea
	{ keyItem = 2929, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Ma
	{ keyItem = 2930, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Khon
	{ keyItem = 2931, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Met
	{ keyItem = 2932, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Khun
	{ keyItem = 2933, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Wasserspeier
	{ keyItem = 2934, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Emputa
	{ keyItem = 2935, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Peirithoos
	{ keyItem = 2936, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Asida
	{ keyItem = 2937, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Tenodera
	{ keyItem = 2938, cmd = 'TradeNPC 2 "Ebony Lumber"' }, -- Sava Savanovic

    -- Tier II
	{ keyItem = 2939, cmd = 'TradeNPC 5 "Vidmapire\'s Claw"' }, -- Palila's Talon
	{ keyItem = 2940, cmd = 'TradeNPC 5 "Azrael\'s Eye"' }, -- Hanbi's Nail
	{ keyItem = 2941, cmd = 'TradeNPC 5 "Centurio\'s Armor"' }, -- Yilan's Scale
	{ keyItem = 2942, cmd = 'TradeNPC 5 "Mhuufya\'s Beak"' }, -- Amymone's Tooth
	{ keyItem = 2943, cmd = 'TradeNPC 5 "Tuft of Camahueto\'s Fur"' }, -- Naphula's Bracelet
	{ keyItem = 2944, cmd = 'TradeNPC 5 "Vedrfolnir\'s Wing"' }, -- Kammavaca's Binding

    -- Tier III
	{ keyItem = 2945, cmd = 'input /item "Waktza Crest" <t>' }, -- Pakecet's Blubber
	{ keyItem = 2946, cmd = 'input /item "Yggdreant Root" <t>' }, -- Duke Vepar's Signet
	{ keyItem = 2947, cmd = 'input /item "Cehuetzi Pelt" <t>' }, -- Vir'ava's Stalk

    -- Gods
	{ keyItem = 2948, cmd = 'TradeNPC 3 "Byakko Scrap"' }, -- Byakko's Pride
	{ keyItem = 2949, cmd = 'TradeNPC 3 "Genbu Scrap"' }, -- Genbu's Honor
	{ keyItem = 2950, cmd = 'TradeNPC 3 "Seiryu Scrap"' }, -- Seiryu's Nobility
	{ keyItem = 2951, cmd = 'TradeNPC 3 "Suzaku Scrap"' }, -- Suzaku's Benefaction
    { keyItem = 2952, cmd = 'TradeNPC 5 "Byakko Scrap" 5 "Genbu Scrap" 5 "Seiryu Scrap" 5 "Suzaku Scrap"' }, -- Kirin's Fervor

    -- Angels
    { keyItem = 2953, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Ashweed" 1 "Gravewood Log"' }, -- Ark Angel HM
    { keyItem = 2954, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Gravewood Log" 1 "Duskcrawler"' }, -- Ark Angel TT
    { keyItem = 2955, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Duskcrawler" 1 "Ashen Crayfish"' }, -- Ark Angel MR
    { keyItem = 2956, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Ashweed" 1 "Ashen Crayfish"' }, -- Ark Angel EV
    { keyItem = 2957, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Ashen Crayfish" 1 "Gravewood Log"' }, -- Ark Angel GK
}

local reisenjima_trades = {
    -- Tier I
    { keyItem = 2991, cmd = 'input /item "Behemoth Leather" <t>' }, -- Crom Dubh
    { keyItem = 2992, cmd = 'input /item "Behemoth Leather" <t>' }, -- Golden Kist
    { keyItem = 2993, cmd = 'input /item "Behemoth Leather" <t>' }, -- Mauve-wristed Gomberry
    { keyItem = 2994, cmd = 'input /item "Behemoth Leather" <t>' }, -- Dazzling Dolores
    { keyItem = 2995, cmd = 'input /item "Behemoth Leather" <t>' }, -- Taelmoth
    { keyItem = 2996, cmd = 'input /item "Behemoth Leather" <t>' }, -- Belphegor
    { keyItem = 2997, cmd = 'input /item "Behemoth Leather" <t>' }, -- Kabandha
    { keyItem = 2998, cmd = 'input /item "Behemoth Leather" <t>' }, -- Selkit
    { keyItem = 2999, cmd = 'input /item "Behemoth Leather" <t>' }, -- Sang Buaya
    { keyItem = 3000, cmd = 'input /item "Behemoth Leather" <t>' }, -- Sabotender Royal
    { keyItem = 3001, cmd = 'input /item "Behemoth Leather" <t>' }, -- Zduhac
    { keyItem = 3002, cmd = 'input /item "Behemoth Leather" <t>' }, -- Oryx

    -- Tier II
    { keyItem = 3003, cmd = 'TradeNPC 2 "Ymmr-Ulvid\'s Grand Coffer"' }, -- Strophadia
    { keyItem = 3004, cmd = 'TradeNPC 2 "Ignor-Mnt\'s Grand Coffer"' }, -- Gajasimha
    { keyItem = 3005, cmd = 'TradeNPC 2 "Durs-Vike\'s Grand Coffer"' }, -- Ironside
    { keyItem = 3006, cmd = 'TradeNPC 2 "Tryl-Wuj\'s Grand Coffer"' }, -- Sarsaok
    { keyItem = 3007, cmd = 'TradeNPC 2 "Liij-Vok\'s Grand Coffer"' }, -- Old Shuck
    { keyItem = 3008, cmd = 'input /item "Gramk-Droog\'s Grand Coffer" <t>' }, -- Bashmu

    -- Tier III
    { keyItem = 3009, cmd = 'input /item "Sovereign Behemoth\'s Hide" <t>' }, -- Maju
    { keyItem = 3010, cmd = 'input /item "Hidhaegg\'s Scale" <t>' }, -- Yakshi
    { keyItem = 3011, cmd = 'input /item "Tolba\'s Shell" <t>' }, -- Neak

    -- HELM
    { keyItem = 3012, cmd = 'TradeNPC 3 "Void Crystal" 3 "Voidsnapper" 1 "Siren\'s Hair" 1 "Scroll of Maiden\'s Virelai"' }, -- Teles
    { keyItem = 3013, cmd = 'TradeNPC 3 "Void Grass" 3 "Ashen Crayfish" 10 "Flan Meat" 1 "Black Pudding"' }, -- Zerde
    { keyItem = 3014, cmd = 'TradeNPC 3 "Void Crystal" 3 "Duskcrawler" 10 "Bone Chip" 1 "Scarletite Ingot"' }, -- Vinipata
    { keyItem = 3015, cmd = 'TradeNPC 3 "Voidsnapper" 3 "Gravewood Log" 1 "Bztavian Stinger" 1 "Leafslit"' }, -- Schah
    { keyItem = 3016, cmd = 'TradeNPC 3 "Ashweed" 3 "Void Grass" 1 "Vermihumus" 1 "Coalition Humus"' }, -- Albumen
    { keyItem = 3017, cmd = 'TradeNPC 3 "Void Crystal" 3 "Void Grass" 10 "Titanite" 1 "Worm Mulch"' }, -- Onychophora
    { keyItem = 3018, cmd = 'TradeNPC 3 "Voidsnapper" 3 "Ashweed" 1 "Mistmelt" 1 "Scroll of Tornado"' }, -- Erinys
}


-- ========================
-- Delve
-- ========================

local delve_trades = {
    { keyItem = 2296, cmd = 'input /item "Celadon Yggrete" <t>' },
    { keyItem = 2297, cmd = 'input /item "Zaffre Yggrete" <t>' },
    { keyItem = 2298, cmd = 'input /item "Alizarin Yggrete" <t>' },
    { keyItem = 2529, cmd = 'input /item "Phlox Yggrete" <t>' },
    { keyItem = 2530, cmd = 'input /item "Russet Yggrete" <t>' },
    { keyItem = 2531, cmd = 'input /item "Aster Yggrete" <t>' },
}





--------  ||===============================||  --------
--------  || CORDINATES BASED TRADE TABLES ||  --------
--------  ||===============================||  --------


local coordinate_trade_tables = {
    -- ========================
    -- Abyssea
    -- ========================

	['Cavernous Maw:*:*:*']     = { cmd = 'Superwarp ab enter' },	
    ['Sturdy Pyxis:*:*:*']      = { cmd = 'input /item "Forbidden Key" <t>'},
    ['Cruor Prospector:*:*:*']  = { OpenMenu = true, cmd = 'setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.2;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.2;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Atma Infusionist:*:*:*']  = { OpenMenu = true, cmd = 'setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3' },	
	
    -- Abyssea - Konschtat (15)
    ['???:15:54:*']    = { keyItem = 1464, cmd = 'input /item "Giant Bugard Tusk" <t>' }, -- Kukulkan
    ['???:15:-135:*']  = { keyItem = 1465, cmd = 'input /item "Armored Dragonhorn" <t>' },
    ['???:15:438:*']   = { keyItem = 1466, cmd = 'input /item "Clouded Lens" <t>' },
    ['???:15:-156:*']  = { cmd = 'input /item "Eft Blood" <t>' }, -- Fistule
    ['???:15:-249:*']  = { cmd = 'input /item "G. Slug Eyestalk" <t>' },
    ['???:15:150:*']   = { cmd = 'input /item "Tiny Morbol Vine" <t>' }, -- Misc
    ['???:15:370:*']   = { cmd = 'input /item "Rotting Eyeball" <t>' },
    ['???:15:360:*']   = { cmd = 'input /item "Murmuring Glob" <t>' },
    ['???:15:-359:*']  = { cmd = 'input /item "Snakeskin Moss" <t>' },
    ['???:15:-236:*']  = { cmd = 'input /item "Ripped Eft Skin" <t>' },
    ['???:15:-183:*']  = { cmd = 'input /item "Oblivispore" <t>' },
    ['???:15:630:*']   = { cmd = 'input /item "Moonglow Cloth" <t>' },

    -- Abyssea - Tahrongi (45)
    ['???:45:-235:*']  = { cmd = 'input /item "H.Q. Cli. Wing" <t>' }, -- Chloris
    ['???:45:74:*']    = { cmd = 'input /item "H.Q. Lim. Pincer" <t>' },
    ['???:45:-196:*']  = { keyItem = 1468, cmd = 'TradeNPC 1 "Bloodshot Hecteye" 1 "Shriveled Wing" 1 "Tarnished Pincer"' },
    ['???:45:-355:*']  = { cmd = 'input /item "Baleful Skull" <t>' },
    ['???:45:184:*']   = { keyItem = 1469, cmd = 'TradeNPC 1 "Exorcised Skull" 1 "Bloody Fang"' },
    ['???:45:71:*']    = { cmd = 'input /item "Alkaline Humus" <t>' },
    ['???:45:-281:*']  = { keyItem = 1470, cmd = 'TradeNPC 1 "Acidic Humus" 1 "V. Scorp. Stinger"' },
    ['???:45:403:*']   = { cmd = 'input /item "Eft Egg" <t>' }, -- Glavoid
    ['???:45:-41:*']   = { keyItem = 1472, cmd = 'TradeNPC 1 "Quiv. Eft Egg" 1 "Ctrice. Tailmeat"' },
    ['???:45:-129:*']  = { cmd = 'input /item "Shocking Whisker" <t>' },
    ['???:45:247:*']   = { keyItem = 1474, cmd = 'TradeNPC 1 "Smooth Whisker" 1 "Resilient Mane"' },
    ['???:45:-219:*']  = { cmd = 'input /item "Moaning Vestige" <t>' }, -- Misc

    -- Abyssea - La Theine (132)
    ['???:132:-717:*'] = { keyItem = 1482, cmd = 'input /item "Trophy Shield" <t>' }, -- Briareus
    ['???:132:-358:*'] = { keyItem = 1483, cmd = 'input /item "Oversized Sock" <t>' },
    ['???:132:-399:*'] = { keyItem = 1484, cmd = 'input /item "Massive Armband" <t>' },
    ['???:132:81:*']   = { keyItem = 1485, cmd = 'input /item "Tr. Insect Wing" <t>' }, -- Carabosse
    ['???:132:-74:*']  = { keyItem = 1486, cmd = 'input /item "Piceous Scale" <t>' },
    ['???:132:-765:*'] = { keyItem = 1479, cmd = 'input /item "Gargantuan Black Tiger Fang" <t>' },
    ['???:132:696:*']  = { cmd = 'input /item "Dried Chigoe" <t>' },
    ['???:132:-87:*']  = { cmd = 'input /item "Filthy Gnole Claw" <t>' },
    ['???:132:309:*']  = { cmd = 'input /item "Winter Puk Egg" <t>' },
    ['???:132:405:*']  = { cmd = 'input /item "Bug-eaten Hat" <t>' },
    ['???:132:279:*']  = { keyItem = 1478, cmd = 'input /item "Raw Mutton Chop" <t>' },

    -- Abyssea - Attohwa (215)
    ['???:215:233:*']  = { keyItem = 1489, cmd = 'input /item "Eruca Egg" <t>' }, -- Itzapapalotl
    ['???:215:401:*']  = { keyItem = 1488, cmd = 'input /item "Withered Cocoon" <t>' },
    ['???:215:281:*']  = { keyItem = 1491, cmd = 'input /item "Blanched Silver" <t>' }, -- Ulhuadashi
    ['???:215:410:*']  = { cmd = 'input /item "Withered Bud" <t>' }, -- Misc
    ['???:215:481:*']  = { cmd = 'input /item "Great Root" <t>' },
    ['???:215:-402:*'] = { cmd = 'input /item "Gory Pincer" <t>' },
    ['???:215:-546:*'] = { keyItem = 1497, cmd = 'input /item "Cracked Dragonscale" <t>' },
    ['???:215:-159:*'] = { keyItem = 1495, cmd = 'input /item "Wailing Rags" <t>' },
    ['???:215:-133:*'] = { keyItem = 1493, cmd = 'input /item "Undying Ooze" <t>' },
    ['???:215:-281:*'] = { cmd = 'input /item "Extended Eyestalk" <t>' },
    ['???:215:198:*']  = { cmd = 'input /item "Mangled Cockatrice Skin" <t>' },
    ['???:215:403:*']  = { keyItem = 1494, cmd = 'input /item "Bone Chips" <t>' },
    ['???:215:214:*']  = { cmd = 'input /item "Coeurl Round" <t>' },

    -- Abyssea - Misareaux (216)
    ['???:216:521:*']  = { keyItem = 1498, cmd = 'input /item "Bewitching Tusk" <t>' },
    ['???:216:346:*']  = { keyItem = 1499, cmd = 'input /item "Handful of molt scraps" <t>' },
    ['???:216:-162:*'] = { keyItem = 1504, cmd = 'input /item "Orbn. Cheekmeat" <t>' }, -- Ceiroin-Ceiroin
    ['???:216:180:*']  = { keyItem = 1501, cmd = 'input /item "Apkallu Down" <t>' }, -- Misc
    ['???:216:718:*']  = { cmd = 'input /item "Worm-Eaten Bud" <t>' },
    ['???:216:321:*']  = { cmd = 'input /item "Hardened Raptor Skin" <t>' },
    ['???:216:41:*']   = { cmd = 'input /item "Mocking Beak" <t>' },
    ['???:216:201:*']  = { cmd = 'TradeNPC 1 "H.Q. Crab Meat" 1 "H.Q. Rock Salt"' },
    ['???:216:411:*']  = { cmd = 'input /item "Black Rabbit Tail" <t>' },
    ['???:216:-199:*'] = { keyItem = 1506, cmd = 'input /item "Spheroid Plate" <t>' },
    ['???:216:-123:*'] = { cmd = 'input /item "Spotted Flyfrond" <t>' },
    ['???:216:120:*']  = { keyItem = 1502, cmd = 'input /item "Avian Remex" <t>' },

    -- Abyssea - Vunkerl (217)
    ['???:217:-116:*'] = { keyItem = 1508, cmd = 'input /item "Gnarled Taurus Horn" <t>' }, -- Bukhis
    ['???:217:-279:*'] = { keyItem = 1509, cmd = 'input /item "Gargouille Stone" <t>' },
    ['???:217:242:*']  = { keyItem = 1511, cmd = 'input /item "Moonbeam Clam" <t>' }, -- Sedna
    ['???:217:-345:*'] = { cmd = 'input /item "H.Q. Rabbit Hide" <t>' }, -- Misc
    ['???:217:-204:*'] = { cmd = 'input /item "Black Whisker" <t>' },
    ['???:217:-215:*'] = { cmd = 'input /item "Crwl. Floatstone" <t>' },
    ['???:217:-240:*'] = { cmd = 'input /item "Opaque Wing" <t>' },
    ['???:217:-640:*'] = { cmd = 'input /item "Dented Skull" <t>' },
    ['???:217:-476:*'] = { cmd = 'input /item "Stiffened Tentacle" <t>' },
    ['???:217:120:*']  = { cmd = 'input /item "Fortune Wing" <t>' },
    ['???:217:-396:*'] = { cmd = 'input /item "Djinn Ashes" <t>' },
    ['???:217:-397:*'] = { cmd = 'input /item "Shockshroom" <t>' },

    -- Abyssea - Altepa (218)
    ['???:218:-315:*'] = { cmd = 'input /item "Sand-caked fang" <t>' }, -- Orthrus
    ['???:218:-559:*'] = { keyItem = 1520, cmd = 'TradeNPC 1 "High-Quality Dhalmel Hide" 1 "Sharabha Hide" 1 "Tiger King\'s Hide"' },
    ['???:218:-878:*'] = { cmd = 'input /item "Sandy Shard" <t>' }, -- Rani / Iron Plates
    ['???:218:-745:*'] = { keyItem = 1518, cmd = 'TradeNPC 1 "Smoldering Arm" 1 "Tablilla Mercury"' },
    ['???:218:-609:*'] = { cmd = 'input /item "Sabulous Clay" <t>' }, -- Misc
    ['???:218:-492:*'] = { cmd = 'TradeNPC 1 "Oasis Water" 1 "Giant Mistletoe"' },
    ['???:218:-409:*'] = { cmd = 'input /item "Puppet\'s Blood" <t>' },
    ['???:218:-72:*']  = { cmd = 'TradeNPC 1 "Vadleany Fluid" 1 "High-Quality Scorpion Claw"' },
    ['???:218:-57:*']  = { cmd = 'input /item "Ladybird Leaf" <t>' },
    ['???:218:36:*']   = { cmd = 'input /item "High-quality Cockatrice Skin" <t>' },

    -- Abyssea - Uleguerand (253)
    ['???:253:-214:*'] = { cmd = 'input /item "Gelid Arm" <t>' },
    ['???:253:-282:*'] = { keyItem = 1525, cmd = 'TradeNPC 1 "High-Quality Marid Hide" 1 "Sisyphus Fragment" 1 "Snow God Core"' },
    ['???:253:-116:*'] = { cmd = 'input /item "Helical Gear" <t>' }, -- Iron Plates
    ['???:253:-16:*']  = { keyItem = 1523, cmd = 'TradeNPC 1 "Bevel Gear" 1 "Gear Fluid"' },
    ['???:253:336:*']  = { cmd = 'input /item "High-Quality Buffalo Horn" <t>' }, -- Misc
    ['???:253:427:*']  = { cmd = 'TradeNPC 1 "High-Quality Black Tiger Hide" 1 "Audumbla Hide"' },
    ['???:253:-481:*'] = { cmd = 'input /item "Imp Sentry\'s Horn" <t>' },
    ['???:253:-616:*'] = { cmd = 'TradeNPC 1 "Rimed Wing" 1 "Benumbed Eye"' },
    ['???:253:0:*']    = { cmd = 'input /item "Ice Wyvern Scale" <t>' },
    ['???:253:457:*']  = { cmd = 'input /item "Whiteworm Clay" <t>' },

    -- Abyssea - Grauberg (254)
    ['???:254:340:*']  = { cmd = 'input /item "Pursuer\'s Wing" <t>' },
    ['???:254:379:*']  = { cmd = 'TradeNPC 1 "High-Quality Wivre Hide" 1 "Jaculus Wing" 1 "Minaruja Skull"' },
    ['???:254:320:*']  = { cmd = 'input /item "Bubbling Oil" <t>' },
    ['???:254:502:*']  = { keyItem = 1528, cmd = 'TradeNPC 1 "Teekesselchen Fragment" 1 "Darkflame Arm"' },
    ['???:254:-69:*']  = { cmd = 'TradeNPC 1 "Unseelie Eye" 1 "Naiad\'s Lock"' },
    ['???:254:-193:*'] = { cmd = 'input /item "Fay Teardrop" <t>' },
    ['???:254:397:*']  = { cmd = 'input /item "Goblin Rope" <t>' },
    ['???:254:-488:*'] = { cmd = 'input /item "Decaying Molar" <t>' },
    ['???:254:556:*']  = { cmd = 'TradeNPC 1 "Goblin Oil" 1 "Goblin Gunpowder"' },
    ['???:254:158:*']  = { cmd = 'input /item "High-Quality Pugil Scale" <t>' },


    -- ========================
    -- ToAU / ZNM-style
    -- ========================
	
	['???:51:257:*']   = { cmd = 'input /item "Senorita pamama" <t>' },
	['???:51:-340:*']  = { cmd = 'input /item "Sheep Botfly" <t>' },
	['???:51:276:*']   = { cmd = 'input /item "Monkey Wine" <t>' },
	['???:51:-696:*']  = { cmd = 'input /item "Hellcage Butterfly" <t>' },

	['???:52:-33:*']   = { cmd = 'input /item "Olzhiryan Cactus" <t>' },
	['???:52:331:*']   = { cmd = 'input /item "Oily Blood" <t>' },

	['???:54:-454:*']  = { cmd = 'input /item "Rose Scampi" <t>' },
	['???:54:490:*']   = { cmd = 'input /item "Greenling" <t>' },
	['???:54:312:*']   = { cmd = 'input /item "Golden Teeth" <t>' },
	['???:54:177:*']   = { cmd = 'input /item "Merrow No. 11 Molting" <t>' },

	['???:61:402:*']   = { cmd = 'input /item "Shadeleaf" <t>' },
	['???:61:501:*']   = { cmd = 'input /item "Pectin" <t>' },
	['???:61:-364:*']  = { cmd = 'input /item "Raw Buffalo" <t>' },
	['???:61:88:*']    = { cmd = 'input /item "Vinegar Pie" <t>' },
	['???:61:323:*']   = { cmd = 'input /item "Buffalo Corpse" <t>' },

	['???:62:-141:*']  = { cmd = 'input /item "Granulated Sugar" <t>' },
	['???:62:-35:*']   = { cmd = 'input /item "Rock Juice" <t>' },
	['???:62:*:*']     = { cmd = 'input /item "Bone Charcoal" <t>' },

	['???:65:208:*']   = { cmd = 'input /item "Floral Nectar" <t>' },
	['???:65:-120:*']  = { cmd = 'input /item "Samariri Corpsehair" <t>' },

	['???:68:200:*']   = { cmd = 'input /item "Pandemonium Key" <t>' },
	['???:68:-200:*']  = { cmd = 'input /item "Pure Blood" <t>' },
	['???:68:-218:*']  = { cmd = 'input /item "Spoilt Blood" <t>' },

	['???:72:-21:*']   = { cmd = 'input /item "Opalus Gem" <t>' },
	['???:72:-185:*']  = { cmd = 'input /item "Rodent Cheese" <t>' },
	['???:72:-20:*']   = { cmd = 'input /item "Ferrite" <t>' },
	['???:72:548:*']   = { cmd = 'input /item "Cog Lubricant" <t>' },

	['???:79:-772:*']  = { cmd = 'input /item "Clump of Myrrh" <t>' },
	['???:79:697:*']   = { cmd = 'input /item "Exorcism Treatise" <t>' },
	['???:79:-757:*']  = { cmd = 'input /item "Singed Buffalo" <t>' },
	['???:79:417:*']   = { cmd = 'input /item "Mint Drop" <t>' },


    -- ========================
    -- Dynamis
    -- ========================
	
    ['???:134:-175:*'] = { cmd = 'input /item "Traitor\'s Fortune" <t>' },
    ['???:134:-91:*']  = { cmd = 'input /item "Sadist\'s Fortune" <t>' },
    ['???:134:60:*']   = { cmd = 'input /item "Villain\'s Fortune" <t>' },
    ['???:134:100:*']  = { cmd = 'input /item "Despot\'s Fortune" <t>' },
    ['???:134:266:*']  = { cmd = 'input /item "Deluder\'s Fortune" <t>' },
    ['???:134:280:*']  = { cmd = 'input /item "Leering Bijou" <t>' },

    ['???:135:-416:*'] = { cmd = 'input /item "Shrouded Bijou" <t>' },
    ['???:135:575:*']  = { cmd = 'input /item "Odious Skull" <t>' },
    ['???:135:579:*']  = { cmd = 'input /item "Odious Horn" <t>' },
    ['???:135:343:*']  = { cmd = 'input /item "Odious Blood" <t>' },
    ['???:135:-108:*'] = { cmd = 'input /item "Odious Pen" <t>' },
    ['???:135:-295:*'] = { cmd = 'input /item "Snarled Goad" <t>' },
    ['???:135:-8:*']   = { cmd = 'input /item "Divine Goad" <t>' },
    ['???:135:-4:*']   = { cmd = 'input /item "Demoniac Goad" <t>' },
    ['???:135:39:-129'] = { cmd = 'input /item "Tenebrous Goad" <t>' },
    ['???:135:39:*']    = { cmd = 'input /item "Stellar Goad" <t>' },
    ['???:135:57:*']   = { cmd = 'input /item "Runaeic Goad" <t>' },
    ['???:135:65:*']   = { cmd = 'input /item "Seraphic Goad" <t>' },
    ['???:135:119:-113'] = { cmd = 'input /item "Holy Goad" <t>' },
    ['???:135:119:*']    = { cmd = 'input /item "Intricate Goad" <t>' },
    ['???:135:150:*']  = { cmd = 'input /item "Celestial Goad" <t>' },
    ['???:135:157:*']  = { cmd = 'input /item "Supernal Goad" <t>' },
    ['???:135:159:*']  = { cmd = 'input /item "Heavenly Goad" <t>' },
    ['???:135:232:*']  = { cmd = 'input /item "Ornate Goad" <t>' },
    ['???:135:238:*']  = { cmd = 'input /item "Mystic Goad" <t>' },
    ['???:135:292:*']  = { cmd = 'input /item "Mysterial Goad" <t>' },

    ['???:185:0:*']    = { cmd = 'input /item "Barbaric Bijou" <t>' },
    ['???:186:-17:*']  = { cmd = 'input /item "Steelwall Bijou" <t>' },
    ['???:186:-105:*'] = { cmd = 'input /item "Odious Engraving" <t>' },
    ['???:187:94:*']   = { cmd = 'input /item "Divine Bijou" <t>' },

    ['???:188:0:-102'] = { cmd = 'input /item "Roving Bijou" <t>' },
    ['???:188:0:68']   = { cmd = 'input /item "Odious Cup" <t>' },
    ['???:188:0:127']  = { cmd = 'input /item "Odious Grenade" <t>' },
    ['???:188:-24:*']  = { cmd = 'input /item "Odious Die" <t>' },
    ['???:188:23:*']   = { cmd = 'input /item "Odious Mask" <t>' },

    ['???:39:63:*']    = { cmd = 'input /item "Creeper\'s Juju" <t>' },
    ['???:39:-202:*']  = { cmd = 'input /item "Nightmare Water" <t>' },
    ['???:40:-261:*']  = { cmd = 'input /item "Undying juju" <t>' },
    ['???:41:149:*']   = { cmd = 'input /item "Herald juju" <t>' },


    -- ========================
    -- Sky
    -- ========================
    ['???:130:569:*']  = { cmd = 'TradeNPC 1 "Gem of the East" 1 "Springstone"' },
    ['???:130:-511:*'] = { cmd = 'TradeNPC 1 "Gem of the South" 1 "Summerstone"' },
    ['???:130:-412:*'] = { cmd = 'TradeNPC 1 "Gem of the West" 1 "Autumnstone"' },
    ['???:130:253:*']  = { cmd = 'TradeNPC 1 "Gem of the North" 1 "Winterstone"' },

    ['???:177:0:*']    = { cmd = 'input /item "Curtana" <t>' },

    ['???:178:-79:*']  = { cmd = 'TradeNPC 1 "Seal of Genbu" 1 "Seal of Seiryu" 1 "Seal of Byakko" 1 "Seal of Suzaku"' },
    ['???:178:740:*']  = { cmd = 'input /item "Diorite" <t>' },
    ['???:178:849:*']  = { cmd = 'input /item "Ro\'Maeve Water" <t>' },


    -- ========================
    -- Sea Serpent Grotto
    -- ========================	
	[':176:40:*']  = { cmd = 'input /item "Mtl. Beastcoin" <t>' },
	[':176:60:*']  = { cmd = 'input /item "Gold Beastcoin" <t>' },
	[':176:280:*'] = { cmd = 'input /item "Silver Beastcoin" <t>' },
	
    -- ========================
    --  Misc
    -- ========================

    ['???:127:127:*']  = { cmd = 'input /item  "Savory Shank" <t>' },
    ['???:126:-121:*'] = { cmd = 'TradeNPC 1 "Seedspall Lux" 1 "Seedspall Luna" 1 "Seedspall Astrum"' },
    ['???:270:-560:*'] = { cmd = 'input /item  "Slashed Vine" <t>' },


    -- ========================
    -- Chest/Coffers
    -- ========================

	-- Coffers
    ['Treasure Coffer:12:*:*']  = { cmd = 'input /item "Newton Coffer Key" <t>' },      -- Newton_Movalpolos
    ['Treasure Coffer:147:*:*'] = { cmd = 'input /item "Beadeaux Coffer Key" <t>' },    -- Beadeaux
    ['Treasure Coffer:130:*:*'] = { cmd = 'input /item "Ru\'Aun Coffer Key" <t>' },     -- Ru'Aun_Gardens
    ['Treasure Coffer:150:*:*'] = { cmd = 'input /item "Davoi Coffer Key" <t>' },       -- Monastic_Cavern
    ['Treasure Coffer:151:*:*'] = { cmd = 'input /item "Oztroja Coffer Key" <t>' },     -- Castle_Oztroja
    ['Treasure Coffer:153:*:*'] = { cmd = 'input /item "Boyahda Coffer Key" <t>' },     -- The_Boyahda_Tree
    ['Treasure Coffer:160:*:*'] = { cmd = 'input /item "Den Coffer Key" <t>' },         -- Den_of_Rancor
    ['Treasure Coffer:161:*:*'] = { cmd = 'input /item "Zvahl Coffer Key" <t>' },       -- Castle_Zvahl_Baileys
    ['Treasure Coffer:169:*:*'] = { cmd = 'input /item "Toraimarai Coffer Key" <t>' },  -- Toraimarai_Canal
    ['Treasure Coffer:174:*:*'] = { cmd = 'input /item "Kuftal Coffer Key" <t>' },      -- Kuftal_Tunnel
    ['Treasure Coffer:176:*:*'] = { cmd = 'input /item "Grotto Coffer Key" <t>' },      -- Sea_Serpent_Grotto
    ['Treasure Coffer:177:*:*'] = { cmd = 'input /item "Ve\'Lugannon Coffer Key" <t>' },-- Ve'Lugannon_Palace
    ['Treasure Coffer:195:*:*'] = { cmd = 'input /item "Eldieme Coffer Key" <t>' },     -- The_Eldieme_Necropolis
    ['Treasure Coffer:197:*:*'] = { cmd = 'input /item "Nest Coffer Key" <t>' },        -- Crawlers_Nest
    ['Treasure Coffer:200:*:*'] = { cmd = 'input /item "Garlaige Coffer Key" <t>' },    -- Garlaige_Citadel
    ['Treasure Coffer:205:*:*'] = { cmd = 'input /item "Cauldron Coffer Key" <t>' },    -- Ifrits_Cauldron
    ['Treasure Coffer:208:*:*'] = { cmd = 'input /item "Quicksand Coffer Key" <t>' },   -- Quicksand_Caves
    ['Treasure Coffer:159:*:*'] = { cmd = 'input /item "Uggalepih Coffer Key" <t>' },   -- Temple_of_Uggalepih

    --Chest
    ['Treasure Chest:141:*:*'] = { cmd = 'input /item "Gls. Chest Key" <t>' },        -- Fort Ghelsba
    ['Treasure Chest:142:*:*'] = { cmd = 'input /item "Gls. Chest Key" <t>' },        -- Yughott Grotto
    ['Treasure Chest:147:*:*'] = { cmd = 'input /item "Beadeaux Chest Key" <t>' },    -- Beadeaux
    ['Treasure Chest:150:*:*'] = { cmd = 'input /item "Davoi Chest Key" <t>' },       -- Monastic Cavern
    ['Treasure Chest:151:*:*'] = { cmd = 'input /item "Oztroja Chest Key" <t>' },     -- Castle Oztroja
    ['Treasure Chest:161:*:*'] = { cmd = 'input /item "Zvahl Chest Key" <t>' },       -- Castle Zvahl Baileys
    ['Treasure Chest:195:*:*'] = { cmd = 'input /item "Eldieme Chest Key" <t>' },     -- The Eldieme Necropolis
    ['Treasure Chest:197:*:*'] = { cmd = 'input /item "Nest Chest Key" <t>' },        -- Crawlers' Nest
    ['Treasure Chest:200:*:*'] = { cmd = 'input /item "Garlaige Chest Key" <t>' },    -- Garlaige Citadel
    ['Treasure Chest:159:*:*'] = { cmd = 'input /item "Uggalepih Chest Key" <t>' },   -- Temple of Uggalepih
    ['Treasure Chest:191:*:*'] = { cmd = 'input /item "Dgr. Chest Key" <t>' },        -- Dangruf Wadi
    ['Treasure Chest:184:*:*'] = { cmd = 'input /item "Dlk. Chest Key" <t>' },        -- Lower Delkfutt's Tower
    ['Treasure Chest:157:*:*'] = { cmd = 'input /item "Dlk. Chest Key" <t>' },        -- Middle Delkfutt's Tower
    ['Treasure Chest:158:*:*'] = { cmd = 'input /item "Dlk. Chest Key" <t>' },        -- Upper Delkfutt's Tower
    ['Treasure Chest:204:*:*'] = { cmd = 'input /item "Fei\'Yin Chest Key" <t>' },    -- Fei'Yin
    ['Treasure Chest:145:*:*'] = { cmd = 'input /item "Gds. Chest Key" <t>' },        -- Giddeus
    ['Treasure Chest:196:*:*'] = { cmd = 'input /item "Gusgen Chest Key" <t>' },      -- Gusgen Mines
    ['Treasure Chest:192:*:*'] = { cmd = 'input /item "Hrt. Chest Key" <t>' },        -- Inner Horutoto Ruins
    ['Treasure Chest:194:*:*'] = { cmd = 'input /item "Hrt. Chest Key" <t>' },        -- Outer Horutoto Ruins
    ['Treasure Chest:213:*:*'] = { cmd = 'input /item "Onzozo Chest Key" <t>' },      -- Labyrinth of Onzozo
    ['Treasure Chest:11:*:*']  = { cmd = 'input /item "Oldton Chest Key" <t>' },      -- Oldton Movalpolos
    ['Treasure Chest:193:*:*'] = { cmd = 'input /item "Ordelle Chest Key" <t>' },     -- Ordelle's Caves
    ['Treasure Chest:143:*:*'] = { cmd = 'input /item "Plb. Chest Key" <t>' },        -- Palborough Mines
    ['Treasure Chest:9:*:*']   = { cmd = 'input /item "Pso. Chest Key" <t>' },        -- Pso'Xja
    ['Treasure Chest:190:*:*'] = { cmd = 'input /item "Rnp. Chest Key" <t>' },        -- King Ranperre's Tomb
    ['Treasure Chest:28:*:*']  = { cmd = 'input /item "Scr. Chest Key" <t>' },        -- Sacrarium
    ['Treasure Chest:198:*:*'] = { cmd = 'input /item "Shk. Chest Key" <t>' },        -- Maze of Shakhrami
	
	-- ========================
    -- BCNM
    -- ========================
	
	-- Macrocosmic Orb
	['Burning Circle:206:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Qu'Bia Arena
    ['Burning Circle:165:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Throne Room
    ['Burning Circle:168:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Chamber of Oracles
    ['Burning Circle:139:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Horlais Peak
    ['Burning Circle:146:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Balga's Dais
    ['Mahogany Door:163:*:*']  = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Sacrificial Chamber

    -- Mars Orb 
    ['Burning Circle:144:*:*'] = { cmd = 'TradeNPC 1 "Mars Orb"' }, -- Waughroon Shrine

    -- Zelos Orb
    ['Wind Pillar:*:*:*']      = { cmd = 'input /item "Zelos Orb" <t>' },
	
	
	-- ========================
    -- Limbus
    -- ========================	

	-- Swirling Vortex
    ['Swirling Vortex:38:*:*'] = { cmd = 'Superwarp li port' },
    ['Swirling Vortex:*:*:*']  = { cmd = 'Superwarp li enter' },

    -- Matter Diffusion Module
    ['Matter Diffusion Module:*:*:*'] = { cmd = 'Superwarp li port' },

	
	-- ========================
    -- Assualts - Rune of releas
    -- ========================		
	
	['Rune of Release:55:*:*'] = { cmd = 'input /item  "Ilrusi Ledger" <t>' },       -- Ilrusi Atoll
	['Rune of Release:56:*:*'] = { cmd = 'input /item  "Periqia Diary" <t>' },       -- Periqia
	['Rune of Release:63:*:*'] = { cmd = 'input /item  "Lebros Chronicle" <t>' },    -- Lebros Cavern
	['Rune of Release:66:*:*'] = { cmd = 'input /item  "Mamool Ja Journal" <t>' },   -- Mamool Ja Training Grounds
	['Rune of Release:69:*:*'] = { cmd = 'input /item  "Leujaoam Log" <t>' },        -- Leujaoam Sanctum
	
	
    -- ========================
    -- Moogle
    -- ========================
	
    ['Moogle:*:*:*']         = { cmd = 'input /item "Imp. Brz. Piece" <t>;exec MogHouseCleanUp' },
    ['Nomad Moogle:*:*:*']   = { cmd = 'jc reset' },
    ['Porter Moogle:*:*:*']  = { cmd = 'gets "Storage slip *" case;wait 1;porterpacker repack;wait 30;puts "Storage slip *" case;gs validate' },

    ['Dealer Moogle:*:*:*']  = { cmd = 'input /item "Kupon I-Seal" <t>' },
    ['Bonanza Moogle:*:*:*'] = { cmd = 'input /item "Bonanza pearl" <t>' },
    ['Festive Moogle:*:*:*'] = { cmd = 'input /item "Mog Pell (Green)" <t>;input /item "Mog Pell (Red)" <t>;input /item "Mog Pell (silver)" <t>' },

    ['Home Point #1:*:*:*']  = { cmd = 'HP set' },
    ['Home Point #2:*:*:*']  = { cmd = 'HP set' },
    ['Home Point #3:*:*:*']  = { cmd = 'HP set' },
    ['Home Point #4:*:*:*']  = { cmd = 'HP set' },
    ['Home Point #5:*:*:*']  = { cmd = 'HP set' },


    -- ========================
    -- Sortie
    -- ========================
	
    ['Diaphanous Bitzer:*:*:*']     = { cmd = 'Superwarp so port' },
    ['Diaphanous Bitzer #A:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Bitzer #B:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Bitzer #C:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Bitzer #D:*:*:*']  = { cmd = 'Superwarp so port' },

    ['Diaphanous Gadget:*:*:*']     = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #A:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #B:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #C:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #D:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #E:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #F:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #G:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Diaphanous Gadget #H:*:*:*']  = { cmd = 'Superwarp so port' },

    ['Diaphanous Device #A:*:*:*']  = { cmd = 'gs equip naked', msg = '!!! Touch the Bitzer Down the Ramp !!!\n!!! Cast Magic Here !!!' },
    ['Diaphanous Device #B:*:*:*']  = { cmd = 'input /hurray <t>' },
    ['Diaphanous Device #C:*:*:*']  = { msg = '!!! Kill Something Here !!!' },
    ['Diaphanous Device #D:*:*:*']  = { msg = '!!! Drop Wing KI Here !!!' },


    -- ========================
    -- Odyssey
    -- ========================
	
    ['Veridical Conflux #A:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Veridical Conflux #B:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Veridical Conflux #C:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Veridical Conflux #D:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Veridical Conflux #E:*:*:*']  = { cmd = 'Superwarp so port' },
    ['Veridical Conflux #F:*:*:*']  = { cmd = 'Superwarp so port' },

    ['Ethereal Junction #1:*:*:*'] = { cmd = 'input /item "Tumult\'s Blood" <t>;input /item "Hidhaegg\'s Scale" <t>;input /item "Sovereign\'s Hide" <t>;input /item "Sarama\'s Hide" <t>' },
    ['Ethereal Junction #2:*:*:*'] = { cmd = 'TradeNPC 3 "Hidhaegg\'s Scale";TradeNPC 3 "Sovereign\'s Hide";TradeNPC 3 "Sarama\'s Hide";TradeNPC 3 "Tumult\'s Blood"' },
    ['Ethereal Junction #3:*:*:*'] = { cmd = 'TradeNPC 5 "Sovereign\'s Hide";TradeNPC 5 "Sarama\'s Hide";TradeNPC 5 "Tumult\'s Blood";TradeNPC 5 "Hidhaegg\'s Scale"' },
    ['Ethereal Junction #4:*:*:*'] = { cmd = 'TradeNPC 10 "Sarama\'s Hide";TradeNPC 10 "Tumult\'s Blood";TradeNPC 10 "Hidhaegg\'s Scale";TradeNPC 10 "Sovereign\'s Hide"' },


    -- ========================
    -- Geas Fete/Escha Section
    -- ========================
	
	['Dimensional Portal:108:220:140']    = { cmd = 'Superwarp ew enter' },
	['Dimensional Portal:102:420:-140']   = { cmd = 'Superwarp ew enter' },
	['Dimensional Portal:117:260:340']    = { cmd = 'Superwarp ew enter' },
	['Dimensional Portal:291:-501:-495']  = { cmd = 'Superwarp ew exit' },
	
    ['Undulating Confluence:126:*:*']       = { cmd = 'Superwarp ew enter' },
	['Undulating Confluence:288:*:*']       = { cmd = 'Superwarp ew exit' },
	
    ['Affi:*:*:*']     = { trades = escha_zitah_trades },
    ['Dremi:*:*:*']    = { trades = escha_ruan_trades },
    ['Shiftrix:*:*:*'] = { trades = reisenjima_trades },


    -- ========================
    -- HTMB Area
    -- ========================
	
    ['Trisvain:*:*:*']       = { cmd = 'htmb' },
    ['Raving Opossum:*:*:*'] = { cmd = 'htmb' },
    ['Mimble-Pimble:*:*:*']  = { cmd = 'htmb' },
	

    -- ========================
    -- Delve
    -- ========================
	
    ['Anomaly Expert:*:*:*'] = { trades = delve_trades },
	
	-- ========================
    -- VoidWatch
    -- ========================	
	['Planar Rift:*:*:*'] = { cmd = 'input /item "Cobalt Cell" <t>;input /item "Rubicund Cell" <t>;input /item "Jade Cell" <t>;input /item "Xanthous Cell" <t>' },


    -- ========================
    -- Meeble Burrows
    -- ========================
	
    ['Burrows Researcher:*:*:*'] = { cmd = 'input /item "Diligence Grimoire" <t>' },


    -- ========================
    -- Legion
    -- ========================
	
    ['Legion Tome:*:*:*'] = { cmd = 'input /item "Legion Pass" <t>' },
    ['Mayuyu:*:*:*']      = { cmd = 'TradeNPC 1 "Lofty Trophy" 1 "Mired Trophy" 1 "Soaring Trophy" 1 "Veiled Trophy"' },
	
	
    -- ========================	
    -- Einhejar
	-- ========================
	
    ['Kilusha:*:*:*']    = { cmd = 'TradeNPC 1000 "Gil"' },
    ['Entry Gate:*:*:*'] = { cmd = 'input /item "Glowing Lamp" <t>' },	


    -- ========================
    -- Doors
    -- ========================

    ['Granite Door:*:*:*']          = { cmd = 'input /item "Uggalepih Key" <t>' },
    ['Unstable Displacement:*:*:*'] = { cmd = 'input /item "Giant Scale" <t>' },
    ['Iron Gate:*:*:*']             = { cmd = 'input /item "Lamian Fang Key" <t>' },
    ['Furnace Hatch:*:*:*']         = { cmd = 'input /item "Firesand" <t>' },
    ['Ornamented Door:*:*:*']       = { cmd = 'input /item "Sahagin Key" <t>'},


    -- ========================
    -- Currency Traders
    -- ========================
	
    ['Lootblox:*:*:*']   = { cmd = 'gets "O. Bronzepiece";wait 0.1;TradeNPC 100 "O. Bronzepiece"' },
    ['Antiqix:*:*:*']    = { cmd = 'gets "T. Whiteshell";wait 0.1;TradeNPC 100 "T. Whiteshell"' },
    ['Haggleblix:*:*:*'] = { cmd = 'gets "1 Byne Bill";wait 0.1;TradeNPC 100 "1 Byne Bill"' },
	['???:243:-54:*']    = { cmd = 'gets "Rusted I. card";gets "Old I. card";gets "Black. I. card";wait 0.1;TradeNPC 100 "Rusted I. card";TradeNPC 100 "Old I. card";TradeNPC 100 "Black. I. card"' },


    -- ========================
    -- Gathering
    -- ========================
	
    ['Harvesting Point:*:*:*'] = { cmd = 'input /item "Sickle" <t>' },
    ['Logging Point:*:*:*']    = { cmd = 'input /item "Hatchet" <t>' },
    ['Mining Point:*:*:*']     = { cmd = 'input /item "Pickaxe" <t>' },
    ['Excavation Point:*:*:*'] = { cmd = 'input /item "Pickaxe" <t>' },


    -- ========================
    -- Mog Garden
    -- ========================
	
    ['Garden Furrow:*:*:*']       = { cmd = 'input /item "Revival Root" <t>' },
    ['Garden Furrow #2:*:*:*']    = { cmd = 'input /item "Revival Root" <t>' },
    ['Garden Furrow #3:*:*:*']    = { cmd = 'input /item "Revival Root" <t>' },

    ['Mineral Vein:*:*:*']        = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Mineral Vein #2:*:*:*']     = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Mineral Vein #3:*:*:*']     = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Arboreal Grove:*:*:*']      = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Arboreal Grove #2:*:*:*']   = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Arboreal Grove #3:*:*:*']   = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Arboreal Grove #4:*:*:*']   = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Pond Dredger:*:*:*']        = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Coastal Fishing Net:*:*:*'] = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Green Thumb Moogle:*:*:*']  = { cmd = 'input /item "Star Sprinkles" <t>' },


    -- ========================
    -- City Buffs
    -- ========================
	
    ['Flying Axe, I.M.:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Rabid Wolf, I.M.:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Crying Wind, I.M.:*:*:*']     = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Arpevion, T.K.:*:*:*']        = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Aravoge, T.K.:*:*:*']         = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Achantere, T.K.:*:*:*']       = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Milma-Hapilma, W.W.:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Puroiko-Maiko, W.W.:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Harara, W.W.:*:*:*']          = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Kochahy-Muwachahy:*:*:*']     = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Alrauverat:*:*:*']            = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Emitt:*:*:*']                 = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Morlepiche:*:*:*']            = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },

    ['Asrahd:*:*:*']                = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Famatarthen:*:*:*']           = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Falzuuk:*:*:*']               = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Nabihwah:*:*:*']              = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Miliart, T.K.:*:*:*']         = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Millard, I.M.:*:*:*']         = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },
    ['Mindala-Andola, C.C.:*:*:*']  = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Fleuricette:*:*:*']           = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Quiri-Aliri:*:*:*']           = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },


    -- ========================
    -- Assaults Armband & Alzadaal Undersea Ruins Guards
    -- ========================
	
    ['Shahayl:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Daswil:*:*:*']       = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Waudeen:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Nahshib:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Meyaada:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Nareema:*:*:*']      = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },

    ['Kamih Mapokhalam:*:*:*'] = { OpenMenu = true, cmd = 'setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Hamta-Iramta:*:*:*']     = { OpenMenu = true, cmd = 'setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Bapokk:*:*:*']           = { OpenMenu = true, cmd = 'setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Nasheefa:*:*:*']         = { OpenMenu = true, cmd = 'setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Kwadaaf:*:*:*']          = { OpenMenu = true, cmd = 'setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },

    ['Runic Portal:*:*:*'] = { OpenMenu = true, cmd = 'setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },


    -- ========================
    -- Summoner mini trial
    -- ========================
	
    ['Dodmos:*:*:*']        = { cmd = 'input /item "Mini Fork of Fire" <t>'},
    ['Ferrol:*:*:*']        = { cmd = 'input /item "Mini Fork of Earth" <t>'},
    ['Lacia:*:*:*']         = { cmd = 'input /item "Mini Fork of Ltn." <t>'},
    ['Verctissa:*:*:*']     = { cmd = 'input /item "Mini Fork of Wtr." <t>'},
    ['Rahi Fohlatti:*:*:*'] = { cmd = 'input /item "Mini Fork of Wind" <t>'},
    ['Castilchat:*:*:*']    = { cmd = 'input /item "Mini Fork of Ice" <t>'},


    -- ========================
    -- NPC interactions
    -- ========================
	
    ['Mystrix:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Habitox:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Bountibox:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Specilox:*:*:*']  = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Arbitrix:*:*:*']  = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Funtrox:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Priztrix:*:*:*']  = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Sweepstox:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Wondrix:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Rewardox:*:*:*']  = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Winrix:*:*:*']    = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey right down;wait 1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },

    ['Cunegonde:*:*:*']   = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Dangueubert:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Mog Dinghy:*:*:*']  = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },

    ['Incantrix:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up' },
    ['Emporox:*:*:*']   = { OpenMenu = true, cmd = 'setkey down down;wait 1;setkey down up;wait 0.1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },

    ['Task Delegator:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Dimmian:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },


    -- ========================
    -- Fame
    -- ========================
	
    ['Mighty Fist:*:*:*'] = { cmd = 'TradeNPC 2 "Darksteel ore"' },
    ['Wyatt:*:*:*']       = { cmd = 'TradeNPC 4 "Ladybug Wing"' },
    ['Saldinor:*:*:*']   = { cmd = 'TradeNPC 2 "Twitherym Wing"' },
    ['Felmsy:*:*:*']      = { cmd = 'input /item "Velkk necklace" <t>;input /item "Velkk Mask" <t>' },
    ['Pudith:*:*:*']      = { cmd = 'input /item "Umbril Ooze" <t>' },
    ['Yocile:*:*:*']      = { cmd = 'TradeNPC 2 "Elshimo Coconut"' },

    ['Belgidiveau:*:*:*']  = { cmd = 'input /item "shk. whisker" <t>; input /item "spotted flyfrond" <t>; input /item "Mngl. Ck. Skin" <t>; input /item "Coeurl Round" <t>; input /item "amb. Pseudopod" <t>' },
    ['Cornelia:*:*:*']     = { cmd = 'input /item "Pursuer\'s Wing" <t>' },
    ['Moreno-Toeno:*:*:*'] = { cmd = 'input /item "Manigordo Tusk" <t>; input /item "Manigordo Tusk" <t>; input /item "Manigordo Tusk" <t>' },


    -- ========================
    -- Quests
    -- ========================
	
    ['Kuu Mohzolhi:*:*:*'] = { cmd = 'input /item "Marguerite" <t>' },
    ['Valah Molkot:*:*:*'] = { cmd = 'input /item "Amaryllis" <t>' },
    ['Ojha Rhawash:*:*:*'] = { cmd = 'input /item "Lilac" <t>' },
    ['Zona Shodhun:*:*:*'] = { cmd = 'input /item "Yellow Rock" <t>' },
    ['Bluffnix:*:*:*']     = { cmd = 'input /item "Goblin Stew 880" <t>'},

    ['Fay Spring:*:*:*']      = { cmd = 'input /item "Bottled Pixie" <t>' },
    ['Altar of Rancor:*:*:*'] = { cmd = 'input /item "Unlit Lantern" <t>' },
    ['Qu\'Hau Spring:*:*:*']  = { cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink"' },
    ['Chocobo:*:*:*']         = { cmd = 'input /item "Gausebit Grass" <t>' },

    ['Runje Desaali:*:*:*']   = { cmd = 'input /item "Atetepeyorg" <t>; input /item "Azukinagamitsu" <t>; input /item "Icoyoca" <t>; input /item "Macoquetza" <t>; input /item "Maochinoli" <t>; input /item "Suijingiri KM" <t>; input /item "Tamaxchi" <t>; input /item "Tlalpoloani" <t>; input /item "Tzacab Grip" <t>; input /item "Otomi Helm" <t>; input /item "Quauhpilli Helm" <t>; input /item "Xux Hat" <t>; input /item "Uk\'uxkaj Cap" <t>; input /item "Buremte Gloves" <t>; input /item "Otomi Gloves" <t>; input /item "Kaabnax Trousers" <t>; input /item "Quiahuiz Trousers" <t>; input /item "Uk\'uxkaj Boots" <t>'},
    ['Odyssean Passage:*:*:*'] = { cmd = 'input /item "Befouled Water" <t>' },

    ['Sanraku:*:*:*'] = { cmd = 'input /item "soul plate" <t>' },
	
    -- ========================
    -- Unsorted/Misc
    -- ========================	
	
	['Anomaly Trigger #1:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #2:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #3:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #4:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #5:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #6:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },

	['Lola:*:*:*'] = { cmd = 'qtr all' },
	

}









 -- --  ||==============================+||  -- --
 -- --  || AF PUGRADE BASED TRADE TABLES ||  -- --
 -- --  ||==============================+||  -- --

local upgrade_trades = {

	-- ========================
	-- WAR
	-- ========================
	{ Base="Warrior's Mask", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Warrior\'s Mask" 50 "Forgotten Thought"' },
	{ Base="Warrior's Lorica", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Warrior\'s Lorica" 50 "Forgotten Hope"' },
	{ Base="Warrior's Mufflers", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Warrior\'s Mufflers" 50 "Forgotten Touch"' },
	{ Base="Warrior's Cuisses", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Warrior\'s Cuisses" 50 "Forgotten Journey"' },
	{ Base="Warrior's Calligae", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Warrior\'s Calligae" 50 "Forgotten Step"' },

	-- ========================
	-- MNK
	-- ========================
	{ Base="Melee Crown", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Melee Crown" 50 "Forgotten Thought"' },
	{ Base="Melee Cyclas", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Melee Cyclas" 50 "Forgotten Hope"' },
	{ Base="Melee Gloves", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Melee Gloves" 50 "Forgotten Touch"' },
	{ Base="Melee Hose", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Melee Hose" 50 "Forgotten Journey"' },
	{ Base="Melee Gaiters", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Melee Gaiters" 50 "Forgotten Step"' },

	-- ========================
	-- WHM
	-- ========================
	{ Base="Cleric's Cap", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Cleric\'s Cap" 50 "Forgotten Thought"' },
	{ Base="Cleric's Briault", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Cleric\'s Briault" 50 "Forgotten Hope"' },
	{ Base="Cleric's Mitts", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Cleric\'s Mitts" 50 "Forgotten Touch"' },
	{ Base="Cleric's Pantaloons", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Cleric\'s Pantaloons" 50 "Forgotten Journey"' },
	{ Base="Cleric's Duckbills", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Cleric\'s Duckbills" 50 "Forgotten Step"' },

	-- ========================
	-- BLM
	-- ========================
	{ Base="Sorcerer's Petasos", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Sorcerer\'s Petasos" 50 "Forgotten Thought"' },
	{ Base="Sorcerer's Coat", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Sorcerer\'s Coat" 50 "Forgotten Hope"' },
	{ Base="Sorcerer's Gloves", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Sorcerer\'s Gloves" 50 "Forgotten Touch"' },
	{ Base="Sorcerer's Tonban", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Sorcerer\'s Tonban" 50 "Forgotten Journey"' },
	{ Base="Sorcerer's Sabots", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Sorcerer\'s Sabots" 50 "Forgotten Step"' },

	-- ========================
	-- RDM
	-- ========================
	{ Base="Duelist's Chapeau", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Duelist\'s Chapeau" 50 "Forgotten Thought"' },
	{ Base="Duelist's Tabard", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Duelist\'s Tabard" 50 "Forgotten Hope"' },
	{ Base="Duelist's Gloves", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Duelist\'s Gloves" 50 "Forgotten Touch"' },
	{ Base="Duelist's Tights", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Duelist\'s Tights" 50 "Forgotten Journey"' },
	{ Base="Duelist's Boots", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Duelist\'s Boots" 50 "Forgotten Step"' },

	-- ========================
	-- THF
	-- ========================
	{ Base="Assassin's Bonnet", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Assassin\'s Bonnet" 50 "Forgotten Thought"' },
	{ Base="Assassin's Vest", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Assassin\'s Vest" 50 "Forgotten Hope"' },
	{ Base="Assassin's Armlets", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Assassin\'s Armlets" 50 "Forgotten Touch"' },
	{ Base="Assassin's Culottes", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Assassin\'s Culottes" 50 "Forgotten Journey"' },
	{ Base="Assassin's Poulaines", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Assassin\'s Poulaines" 50 "Forgotten Step"' },

	-- ========================
	-- PLD
	-- ========================
	{ Base="Valor Coronet", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Valor Coronet" 50 "Forgotten Thought"' },
	{ Base="Valor Surcoat", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Valor Surcoat" 50 "Forgotten Hope"' },
	{ Base="Valor Gauntlets", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Valor Gauntlets" 50 "Forgotten Touch"' },
	{ Base="Valor Breeches", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Valor Breeches" 50 "Forgotten Journey"' },
	{ Base="Valor Leggings", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Valor Leggings" 50 "Forgotten Step"' },

	-- ========================
	-- DRK
	-- ========================
	{ Base="Abyss Burgeonet", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Abyss Burgeonet" 50 "Forgotten Thought"' },
	{ Base="Abyss Cuirass", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Abyss Cuirass" 50 "Forgotten Hope"' },
	{ Base="Abyss Gauntlets", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Abyss Gauntlets" 50 "Forgotten Touch"' },
	{ Base="Abyss Flanchard", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Abyss Flanchard" 50 "Forgotten Journey"' },
	{ Base="Abyss Sollerets", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Abyss Sollerets" 50 "Forgotten Step"' },

	-- ========================
	-- BST
	-- ========================
	{ Base="Monster Helm", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Monster Helm" 50 "Forgotten Thought"' },
	{ Base="Monster Jackcoat", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Monster Jackcoat" 50 "Forgotten Hope"' },
	{ Base="Monster Gloves", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Monster Gloves" 50 "Forgotten Touch"' },
	{ Base="Monster Trousers", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Monster Trousers" 50 "Forgotten Journey"' },
	{ Base="Monster Gaiters", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Monster Gaiters" 50 "Forgotten Step"' },

	-- ========================
	-- BRD
	-- ========================
	{ Base="Bard's Roundlet", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Bard\'s Roundlet" 50 "Forgotten Thought"' },
	{ Base="Bard's Justaucorps", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Bard\'s Justaucorps" 50 "Forgotten Hope"' },
	{ Base="Bard's Cuffs", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Bard\'s Cuffs" 50 "Forgotten Touch"' },
	{ Base="Bard's Cannions", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Bard\'s Cannions" 50 "Forgotten Journey"' },
	{ Base="Bard's Slippers", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Bard\'s Slippers" 50 "Forgotten Step"' },

	-- ========================
	-- RNG
	-- ========================
	{ Base="Scout's Beret", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Scout\'s Beret" 50 "Forgotten Thought"' },
	{ Base="Scout's Jerkin", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Scout\'s Jerkin" 50 "Forgotten Hope"' },
	{ Base="Scout's Bracers", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Scout\'s Bracers" 50 "Forgotten Touch"' },
	{ Base="Scout's Braccae", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Scout\'s Braccae" 50 "Forgotten Journey"' },
	{ Base="Scout's Socks", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Scout\'s Socks" 50 "Forgotten Step"' },

	-- ========================
	-- SAM
	-- ========================
	{ Base="Saotome Kabuto", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Saotome Kabuto" 50 "Forgotten Thought"' },
	{ Base="Saotome Domaru", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Saotome Domaru" 50 "Forgotten Hope"' },
	{ Base="Saotome Kote", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Saotome Kote" 50 "Forgotten Touch"' },
	{ Base="Saotome Haidate", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Saotome Haidate" 50 "Forgotten Journey"' },
	{ Base="Saotome Sune-Ate", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Saotome Sune-Ate" 50 "Forgotten Step"' },

	-- ========================
	-- NIN
	-- ========================
	{ Base="Koga Hatsuburi", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Koga Hatsuburi" 50 "Forgotten Thought"' },
	{ Base="Koga Chainmail", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Koga Chainmail" 50 "Forgotten Hope"' },
	{ Base="Koga Tekko", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Koga Tekko" 50 "Forgotten Touch"' },
	{ Base="Koga Hakama", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Koga Hakama" 50 "Forgotten Journey"' },
	{ Base="Koga Kyahan", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Koga Kyahan" 50 "Forgotten Step"' },

	-- ========================
	-- DRG
	-- ========================
	{ Base="Wyrm Armet", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Wyrm Armet" 50 "Forgotten Thought"' },
	{ Base="Wyrm Mail", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Wyrm Mail" 50 "Forgotten Hope"' },
	{ Base="Wyrm Finger Gauntlets", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Wyrm Finger Gauntlets" 50 "Forgotten Touch"' },
	{ Base="Wyrm Brais", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Wyrm Brais" 50 "Forgotten Journey"' },
	{ Base="Wyrm Greaves", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Wyrm Greaves" 50 "Forgotten Step"' },

	-- ========================
	-- SMN
	-- ========================
	{ Base="Summoner's Horn", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Summoner\'s Horn" 50 "Forgotten Thought"' },
	{ Base="Summoner's Doublet", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Summoner\'s Doublet" 50 "Forgotten Hope"' },
	{ Base="Summoner's Bracers", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Summoner\'s Bracers" 50 "Forgotten Touch"' },
	{ Base="Summoner's Spats", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Summoner\'s Spats" 50 "Forgotten Journey"' },
	{ Base="Summoner's Pigaches", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Summoner\'s Pigaches" 50 "Forgotten Step"' },

	-- ========================
	-- BLU
	-- ========================
	{ Base="Mirage Keffiyeh", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Mirage Keffiyeh" 50 "Forgotten Thought"' },
	{ Base="Mirage Jubbah", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Mirage Jubbah" 50 "Forgotten Hope"' },
	{ Base="Mirage Bazubands", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Mirage Bazubands" 50 "Forgotten Touch"' },
	{ Base="Mirage Shalwar", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Mirage Shalwar" 50 "Forgotten Journey"' },
	{ Base="Mirage Charuqs", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Mirage Charuqs" 50 "Forgotten Step"' },

	-- ========================
	-- COR
	-- ========================
	{ Base="Commodore Tricorne", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Commodore Tricorne" 50 "Forgotten Thought"' },
	{ Base="Commodore Frac", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Commodore Frac" 50 "Forgotten Hope"' },
	{ Base="Commodore Gants", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Commodore Gants" 50 "Forgotten Touch"' },
	{ Base="Commodore Trews", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Commodore Trews" 50 "Forgotten Journey"' },
	{ Base="Commodore Bottes", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Commodore Bottes" 50 "Forgotten Step"' },

	-- ========================
	-- DNC
	-- ========================
	{ Base="Etoile Tiara", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Etoile Tiara" 50 "Forgotten Thought"' },
	{ Base="Etoile Casaque", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Etoile Casaque" 50 "Forgotten Hope"' },
	{ Base="Etoile Bangles", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Etoile Bangles" 50 "Forgotten Touch"' },
	{ Base="Etoile Tights", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Etoile Tights" 50 "Forgotten Journey"' },
	{ Base="Etoile Toe Shoes", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Etoile Toe Shoes" 50 "Forgotten Step"' },

	-- ========================
	-- SCH
	-- ========================
	{ Base="Argute Mortarboard", Upgrades="Forgotten Thought", count=50, cmd='TradeNPC 1 "Argute Mortarboard" 50 "Forgotten Thought"' },
	{ Base="Argute Gown", Upgrades="Forgotten Hope", count=50, cmd='TradeNPC 1 "Argute Gown" 50 "Forgotten Hope"' },
	{ Base="Argute Bracers", Upgrades="Forgotten Touch", count=50, cmd='TradeNPC 1 "Argute Bracers" 50 "Forgotten Touch"' },
	{ Base="Argute Pants", Upgrades="Forgotten Journey", count=50, cmd='TradeNPC 1 "Argute Pants" 50 "Forgotten Journey"' },
	{ Base="Argute Loafers", Upgrades="Forgotten Step", count=50, cmd='TradeNPC 1 "Argute Loafers" 50 "Forgotten Step"' },



    -- ========================
    -- WAR
    -- ========================
    { Base="Ravager's Mask",      Upgrades="Ravager's Seal: Head",  count=8,  cmd='TradeNPC 1 "Ravager\'s Mask" 8 "Ravager\'s Seal: Head"' },
    { Base="Ravager's Lorica",    Upgrades="Ravager's Seal: Body",  count=10, cmd='TradeNPC 1 "Ravager\'s Lorica" 10 "Ravager\'s Seal: Body"' },
    { Base="Ravager's Mufflers",  Upgrades="Ravager's Seal: Hands", count=8,  cmd='TradeNPC 1 "Ravager\'s Mufflers" 8 "Ravager\'s Seal: Hands"' },
    { Base="Ravager's Cuisses",   Upgrades="Ravager's Seal: Legs",  count=8,  cmd='TradeNPC 1 "Ravager\'s Cuisses" 8 "Ravager\'s Seal: Legs"' },
    { Base="Ravager's Calligae",  Upgrades="Ravager's Seal: Feet",  count=8,  cmd='TradeNPC 1 "Ravager\'s Calligae" 8 "Ravager\'s Seal: Feet"' },

    -- ========================
    -- MNK
    -- ========================
    { Base="Tantra Crown",        Upgrades="Tantra Seal: Head",     count=8,  cmd='TradeNPC 1 "Tantra Crown" 8 "Tantra Seal: Head"' },
    { Base="Tantra Cyclas",       Upgrades="Tantra Seal: Body",     count=10, cmd='TradeNPC 1 "Tantra Cyclas" 10 "Tantra Seal: Body"' },
    { Base="Tantra Gloves",       Upgrades="Tantra Seal: Hands",    count=8,  cmd='TradeNPC 1 "Tantra Gloves" 8 "Tantra Seal: Hands"' },
    { Base="Tantra Hose",         Upgrades="Tantra Seal: Legs",     count=8,  cmd='TradeNPC 1 "Tantra Hose" 8 "Tantra Seal: Legs"' },
    { Base="Tantra Gaiters",      Upgrades="Tantra Seal: Feet",     count=8,  cmd='TradeNPC 1 "Tantra Gaiters" 8 "Tantra Seal: Feet"' },

    -- ========================
    -- WHM
    -- ========================
    { Base="Orison Cap",          Upgrades="Orison Seal: Head",     count=8,  cmd='TradeNPC 1 "Orison Cap" 8 "Orison Seal: Head"' },
    { Base="Orison Bliaut",       Upgrades="Orison Seal: Body",     count=10, cmd='TradeNPC 1 "Orison Bliaut" 10 "Orison Seal: Body"' },
    { Base="Orison Mitts",        Upgrades="Orison Seal: Hands",    count=8,  cmd='TradeNPC 1 "Orison Mitts" 8 "Orison Seal: Hands"' },
    { Base="Orison Pantaloons",   Upgrades="Orison Seal: Legs",     count=8,  cmd='TradeNPC 1 "Orison Pantaloons" 8 "Orison Seal: Legs"' },
    { Base="Orison Duckbills",    Upgrades="Orison Seal: Feet",     count=8,  cmd='TradeNPC 1 "Orison Duckbills" 8 "Orison Seal: Feet"' },

    -- ========================
    -- BLM
    -- ========================
    { Base="Goetia Petasos",      Upgrades="Goetia Seal: Head",     count=8,  cmd='TradeNPC 1 "Goetia Petasos" 8 "Goetia Seal: Head"' },
    { Base="Goetia Coat",         Upgrades="Goetia Seal: Body",     count=10, cmd='TradeNPC 1 "Goetia Coat" 10 "Goetia Seal: Body"' },
    { Base="Goetia Gloves",       Upgrades="Goetia Seal: Hands",    count=8,  cmd='TradeNPC 1 "Goetia Gloves" 8 "Goetia Seal: Hands"' },
    { Base="Goetia Chausses",     Upgrades="Goetia Seal: Legs",     count=8,  cmd='TradeNPC 1 "Goetia Chausses" 8 "Goetia Seal: Legs"' },
    { Base="Goetia Sabots",       Upgrades="Goetia Seal: Feet",     count=8,  cmd='TradeNPC 1 "Goetia Sabots" 8 "Goetia Seal: Feet"' },

    -- ========================
    -- RDM
    -- ========================
    { Base="Estoqueur's Chappel",    Upgrades="Estoqueur's Seal: Head",  count=8,  cmd='TradeNPC 1 "Estoqueur\'s Chappel" 8 "Estoqueur\'s Seal: Head"' },
    { Base="Estoqueur's Sayon",      Upgrades="Estoqueur's Seal: Body",  count=10, cmd='TradeNPC 1 "Estoqueur\'s Sayon" 10 "Estoqueur\'s Seal: Body"' },
    { Base="Estoqueur's Gantherots", Upgrades="Estoqueur's Seal: Hands", count=8,  cmd='TradeNPC 1 "Estoqueur\'s Gantherots" 8 "Estoqueur\'s Seal: Hands"' },
    { Base="Estoqueur's Fuseau",     Upgrades="Estoqueur's Seal: Legs",  count=8,  cmd='TradeNPC 1 "Estoqueur\'s Fuseau" 8 "Estoqueur\'s Seal: Legs"' },
    { Base="Estoqueur's Houseaux",   Upgrades="Estoqueur's Seal: Feet",  count=8,  cmd='TradeNPC 1 "Estoqueur\'s Houseaux" 8 "Estoqueur\'s Seal: Feet"' },

    -- ========================
    -- THF
    -- ========================
    { Base="Raider's Bonnet",     Upgrades="Raider's Seal: Head",   count=8,  cmd='TradeNPC 1 "Raider\'s Bonnet" 8 "Raider\'s Seal: Head"' },
    { Base="Raider's Vest",       Upgrades="Raider's Seal: Body",   count=10, cmd='TradeNPC 1 "Raider\'s Vest" 10 "Raider\'s Seal: Body"' },
    { Base="Raider's Armlets",    Upgrades="Raider's Seal: Hands",  count=8,  cmd='TradeNPC 1 "Raider\'s Armlets" 8 "Raider\'s Seal: Hands"' },
    { Base="Raider's Culottes",   Upgrades="Raider's Seal: Legs",   count=8,  cmd='TradeNPC 1 "Raider\'s Culottes" 8 "Raider\'s Seal: Legs"' },
    { Base="Raider's Poulaines",  Upgrades="Raider's Seal: Feet",   count=8,  cmd='TradeNPC 1 "Raider\'s Poulaines" 8 "Raider\'s Seal: Feet"' },

    -- ========================
    -- PLD
    -- ========================
    { Base="Creed Armet",         Upgrades="Creed Seal: Head",      count=8,  cmd='TradeNPC 1 "Creed Armet" 8 "Creed Seal: Head"' },
    { Base="Creed Cuirass",       Upgrades="Creed Seal: Body",      count=10, cmd='TradeNPC 1 "Creed Cuirass" 10 "Creed Seal: Body"' },
    { Base="Creed Gauntlets",     Upgrades="Creed Seal: Hands",     count=8,  cmd='TradeNPC 1 "Creed Gauntlets" 8 "Creed Seal: Hands"' },
    { Base="Creed Cuisses",       Upgrades="Creed Seal: Legs",      count=8,  cmd='TradeNPC 1 "Creed Cuisses" 8 "Creed Seal: Legs"' },
    { Base="Creed Sabatons",      Upgrades="Creed Seal: Feet",      count=8,  cmd='TradeNPC 1 "Creed Sabatons" 8 "Creed Seal: Feet"' },

    -- ========================
    -- DRK
    -- ========================
    { Base="Bale Burgeonet",      Upgrades="Bale Seal: Head",       count=8,  cmd='TradeNPC 1 "Bale Burgeonet" 8 "Bale Seal: Head"' },
    { Base="Bale Cuirass",        Upgrades="Bale Seal: Body",       count=10, cmd='TradeNPC 1 "Bale Cuirass" 10 "Bale Seal: Body"' },
    { Base="Bale Gauntlets",      Upgrades="Bale Seal: Hands",      count=8,  cmd='TradeNPC 1 "Bale Gauntlets" 8 "Bale Seal: Hands"' },
    { Base="Bale Flanchard",      Upgrades="Bale Seal: Legs",       count=8,  cmd='TradeNPC 1 "Bale Flanchard" 8 "Bale Seal: Legs"' },
    { Base="Bale Sollerets",      Upgrades="Bale Seal: Feet",       count=8,  cmd='TradeNPC 1 "Bale Sollerets" 8 "Bale Seal: Feet"' },

    -- ========================
    -- BST
    -- ========================
    { Base="Ferine Cabasset",     Upgrades="Ferine Seal: Head",     count=8,  cmd='TradeNPC 1 "Ferine Cabasset" 8 "Ferine Seal: Head"' },
    { Base="Ferine Gausape",      Upgrades="Ferine Seal: Body",     count=10, cmd='TradeNPC 1 "Ferine Gausape" 10 "Ferine Seal: Body"' },
    { Base="Ferine Manoplas",     Upgrades="Ferine Seal: Hands",    count=8,  cmd='TradeNPC 1 "Ferine Manoplas" 8 "Ferine Seal: Hands"' },
    { Base="Ferine Quijotes",     Upgrades="Ferine Seal: Legs",     count=8,  cmd='TradeNPC 1 "Ferine Quijotes" 8 "Ferine Seal: Legs"' },
    { Base="Ferine Ocreae",       Upgrades="Ferine Seal: Feet",     count=8,  cmd='TradeNPC 1 "Ferine Ocreae" 8 "Ferine Seal: Feet"' },

    -- ========================
    -- BRD
    -- ========================
    { Base="Aoidos' Calot",       Upgrades="Aoidos' Seal: Head",    count=8,  cmd='TradeNPC 1 "Aoidos\' Calot" 8 "Aoidos\' Seal: Head"' },
    { Base="Aoidos' Hongreline",  Upgrades="Aoidos' Seal: Body",    count=10, cmd='TradeNPC 1 "Aoidos\' Hongreline" 10 "Aoidos\' Seal: Body"' },
    { Base="Aoidos' Manchettes",  Upgrades="Aoidos' Seal: Hands",   count=8,  cmd='TradeNPC 1 "Aoidos\' Manchettes" 8 "Aoidos\' Seal: Hands"' },
    { Base="Aoidos' Rhingrave",   Upgrades="Aoidos' Seal: Legs",    count=8,  cmd='TradeNPC 1 "Aoidos\' Rhingrave" 8 "Aoidos\' Seal: Legs"' },
    { Base="Aoidos' Cothurnes",   Upgrades="Aoidos' Seal: Feet",    count=8,  cmd='TradeNPC 1 "Aoidos\' Cothurnes" 8 "Aoidos\' Seal: Feet"' },

    -- ========================
    -- RNG
    -- ========================
    { Base="Sylvan Gapette",      Upgrades="Sylvan Seal: Head",     count=8,  cmd='TradeNPC 1 "Sylvan Gapette" 8 "Sylvan Seal: Head"' },
    { Base="Sylvan Caban",        Upgrades="Sylvan Seal: Body",     count=10, cmd='TradeNPC 1 "Sylvan Caban" 10 "Sylvan Seal: Body"' },
    { Base="Sylvan Glovelettes",  Upgrades="Sylvan Seal: Hands",    count=8,  cmd='TradeNPC 1 "Sylvan Glovelettes" 8 "Sylvan Seal: Hands"' },
    { Base="Sylvan Bragues",      Upgrades="Sylvan Seal: Legs",     count=8,  cmd='TradeNPC 1 "Sylvan Bragues" 8 "Sylvan Seal: Legs"' },
    { Base="Sylvan Bottillons",   Upgrades="Sylvan Seal: Feet",     count=8,  cmd='TradeNPC 1 "Sylvan Bottillons" 8 "Sylvan Seal: Feet"' },

    -- ========================
    -- SAM
    -- ========================
    { Base="Unkai Kabuto",        Upgrades="Unkai Seal: Head",      count=8,  cmd='TradeNPC 1 "Unkai Kabuto" 8 "Unkai Seal: Head"' },
    { Base="Unkai Domaru",        Upgrades="Unkai Seal: Body",      count=10, cmd='TradeNPC 1 "Unkai Domaru" 10 "Unkai Seal: Body"' },
    { Base="Unkai Kote",          Upgrades="Unkai Seal: Hands",     count=8,  cmd='TradeNPC 1 "Unkai Kote" 8 "Unkai Seal: Hands"' },
    { Base="Unkai Haidate",       Upgrades="Unkai Seal: Legs",      count=8,  cmd='TradeNPC 1 "Unkai Haidate" 8 "Unkai Seal: Legs"' },
    { Base="Unkai Sune-Ate",      Upgrades="Unkai Seal: Feet",      count=8,  cmd='TradeNPC 1 "Unkai Sune-Ate" 8 "Unkai Seal: Feet"' },

    -- ========================
    -- NIN
    -- ========================
    { Base="Iga Zukin",           Upgrades="Iga Seal: Head",        count=8,  cmd='TradeNPC 1 "Iga Zukin" 8 "Iga Seal: Head"' },
    { Base="Iga Ningi",           Upgrades="Iga Seal: Body",        count=10, cmd='TradeNPC 1 "Iga Ningi" 10 "Iga Seal: Body"' },
    { Base="Iga Tekko",           Upgrades="Iga Seal: Hands",       count=8,  cmd='TradeNPC 1 "Iga Tekko" 8 "Iga Seal: Hands"' },
    { Base="Iga Hakama",          Upgrades="Iga Seal: Legs",        count=8,  cmd='TradeNPC 1 "Iga Hakama" 8 "Iga Seal: Legs"' },
    { Base="Iga Kyahan",          Upgrades="Iga Seal: Feet",        count=8,  cmd='TradeNPC 1 "Iga Kyahan" 8 "Iga Seal: Feet"' },

    -- ========================
    -- DRG
    -- ========================
    { Base="Lancer's Mezail",     Upgrades="Lancer's Seal: Head",   count=8,  cmd='TradeNPC 1 "Lancer\'s Mezail" 8 "Lancer\'s Seal: Head"' },
    { Base="Lancer Plackart",     Upgrades="Lancer's Seal: Body",   count=10, cmd='TradeNPC 1 "Lancer Plackart" 10 "Lancer\'s Seal: Body"' },
    { Base="Lancer Vambraces",    Upgrades="Lancer's Seal: Hands",  count=8,  cmd='TradeNPC 1 "Lancer Vambraces" 8 "Lancer\'s Seal: Hands"' },
    { Base="Lancer's Cuissots",   Upgrades="Lancer's Seal: Legs",   count=8,  cmd='TradeNPC 1 "Lancer\'s Cuissots" 8 "Lancer\'s Seal: Legs"' },
    { Base="Lancer's Schynbalds", Upgrades="Lancer's Seal: Feet",   count=8,  cmd='TradeNPC 1 "Lancer\'s Schynbalds" 8 "Lancer\'s Seal: Feet"' },

    -- ========================
    -- SMN
    -- ========================
    { Base="Caller's Horn",       Upgrades="Caller's Seal: Head",   count=8,  cmd='TradeNPC 1 "Caller\'s Horn" 8 "Caller\'s Seal: Head"' },
    { Base="Caller's Doublet",    Upgrades="Caller's Seal: Body",   count=10, cmd='TradeNPC 1 "Caller\'s Doublet" 10 "Caller\'s Seal: Body"' },
    { Base="Caller's Bracers",    Upgrades="Caller's Seal: Hands",  count=8,  cmd='TradeNPC 1 "Caller\'s Bracers" 8 "Caller\'s Seal: Hands"' },
    { Base="Caller's Spats",      Upgrades="Caller's Seal: Legs",   count=8,  cmd='TradeNPC 1 "Caller\'s Spats" 8 "Caller\'s Seal: Legs"' },
    { Base="Caller's Pigaches",   Upgrades="Caller's Seal: Feet",   count=8,  cmd='TradeNPC 1 "Caller\'s Pigaches" 8 "Caller\'s Seal: Feet"' },

    -- ========================
    -- BLU
    -- ========================
    { Base="Mavi Kavuk",          Upgrades="Mavi Seal: Head",       count=8,  cmd='TradeNPC 1 "Mavi Kavuk" 8 "Mavi Seal: Head"' },
    { Base="Mavi Mintan",         Upgrades="Mavi Seal: Body",       count=10, cmd='TradeNPC 1 "Mavi Mintan" 10 "Mavi Seal: Body"' },
    { Base="Mavi Bazuband",       Upgrades="Mavi Seal: Hands",      count=8,  cmd='TradeNPC 1 "Mavi Bazuband" 8 "Mavi Seal: Hands"' },
    { Base="Mavi Tayt",           Upgrades="Mavi Seal: Legs",       count=8,  cmd='TradeNPC 1 "Mavi Tayt" 8 "Mavi Seal: Legs"' },
    { Base="Mavi Basmak",         Upgrades="Mavi Seal: Feet",       count=8,  cmd='TradeNPC 1 "Mavi Basmak" 8 "Mavi Seal: Feet"' },

    -- ========================
    -- COR
    -- ========================
    { Base="Navarch's Tricorne",  Upgrades="Navarch's Seal: Head",  count=8,  cmd='TradeNPC 1 "Navarch\'s Tricorne" 8 "Navarch\'s Seal: Head"' },
    { Base="Navarch's Frac",      Upgrades="Navarch's Seal: Body",  count=10, cmd='TradeNPC 1 "Navarch\'s Frac" 10 "Navarch\'s Seal: Body"' },
    { Base="Navarch's Gants",     Upgrades="Navarch's Seal: Hands", count=8,  cmd='TradeNPC 1 "Navarch\'s Gants" 8 "Navarch\'s Seal: Hands"' },
    { Base="Navarch's Culottes",  Upgrades="Navarch's Seal: Legs",  count=8,  cmd='TradeNPC 1 "Navarch\'s Culottes" 8 "Navarch\'s Seal: Legs"' },
    { Base="Navarch's Bottes",    Upgrades="Navarch's Seal: Feet",  count=8,  cmd='TradeNPC 1 "Navarch\'s Bottes" 8 "Navarch\'s Seal: Feet"' },

    -- ========================
    -- PUP
    -- ========================
    { Base="Cirque Cappello",     Upgrades="Cirque Seal: Head",     count=8,  cmd='TradeNPC 1 "Cirque Cappello" 8 "Cirque Seal: Head"' },
    { Base="Cirque Farsetto",     Upgrades="Cirque Seal: Body",     count=10, cmd='TradeNPC 1 "Cirque Farsetto" 10 "Cirque Seal: Body"' },
    { Base="Cirque Guanti",       Upgrades="Cirque Seal: Hands",    count=8,  cmd='TradeNPC 1 "Cirque Guanti" 8 "Cirque Seal: Hands"' },
    { Base="Cirque Pantaloni",    Upgrades="Cirque Seal: Legs",     count=8,  cmd='TradeNPC 1 "Cirque Pantaloni" 8 "Cirque Seal: Legs"' },
    { Base="Cirque Scarpe",       Upgrades="Cirque Seal: Feet",     count=8,  cmd='TradeNPC 1 "Cirque Scarpe" 8 "Cirque Seal: Feet"' },

    -- ========================
    -- DNC
    -- ========================
    { Base="Charis Tiara",        Upgrades="Charis Seal: Head",     count=8,  cmd='TradeNPC 1 "Charis Tiara" 8 "Charis Seal: Head"' },
    { Base="Charis Casaque",      Upgrades="Charis Seal: Body",     count=10, cmd='TradeNPC 1 "Charis Casaque" 10 "Charis Seal: Body"' },
    { Base="Charis Bangles",      Upgrades="Charis Seal: Hands",    count=8,  cmd='TradeNPC 1 "Charis Bangles" 8 "Charis Seal: Hands"' },
    { Base="Charis Tights",       Upgrades="Charis Seal: Legs",     count=8,  cmd='TradeNPC 1 "Charis Tights" 8 "Charis Seal: Legs"' },
    { Base="Charis Toeshoes",     Upgrades="Charis Seal: Feet",     count=8,  cmd='TradeNPC 1 "Charis Toeshoes" 8 "Charis Seal: Feet"' },

    -- ========================
    -- SCH
    -- ========================
    { Base="Savant's Bonnet",     Upgrades="Savant's Seal: Head",   count=8,  cmd='TradeNPC 1 "Savant\'s Bonnet" 8 "Savant\'s Seal: Head"' },
    { Base="Savant's Gown",       Upgrades="Savant's Seal: Body",   count=10, cmd='TradeNPC 1 "Savant\'s Gown" 10 "Savant\'s Seal: Body"' },
    { Base="Savant's Bracers",    Upgrades="Savant's Seal: Hands",  count=8,  cmd='TradeNPC 1 "Savant\'s Bracers" 8 "Savant\'s Seal: Hands"' },
    { Base="Savant's Pants",      Upgrades="Savant's Seal: Legs",   count=8,  cmd='TradeNPC 1 "Savant\'s Pants" 8 "Savant\'s Seal: Legs"' },
    { Base="Savant's Loafers",    Upgrades="Savant's Seal: Feet",   count=8,  cmd='TradeNPC 1 "Savant\'s Loafers" 8 "Savant\'s Seal: Feet"' },
}














local function FindActionEntry(target)
    local npc  = target.name
    local zone = windower.ffxi.get_info().zone
    local x    = math.floor(target.x)
    local y    = math.floor(target.y)

    return coordinate_trade_tables[npc .. ':' .. zone .. ':' .. x .. ':' .. y]
        or coordinate_trade_tables[npc .. ':' .. zone .. ':' .. x .. ':*']
        or coordinate_trade_tables[npc .. ':' .. zone .. ':*:*']
        or coordinate_trade_tables[npc .. ':*:*:*']
end


local function ResolveActionEntry(entry)
    if not entry then
        return false
    end

    if entry.keyItem and KiProtection and HasKeyItem(entry.keyItem) then
        windower.add_to_chat(chatColor, 'You already have the Key Item')
        return false
    end

    if entry.OpenMenu and not OpenMenu() then
        return false
    end

    if entry.trades then
        return MultipleKeyItemsTrades(entry.trades)
    end

    if entry.cmd then
        windower.send_command(entry.cmd)
    end

    if entry.msg then
        windower.add_to_chat(chatColor, entry.msg)
    end

    return true
end


local function TradeIt(target)
    local entry = FindActionEntry(target)

    if entry then
        ResolveActionEntry(entry)
        return
    elseif target.name == 'Delivery Crate' then
        UpgradeTrades(upgrade_trades)
    else
        windower.add_to_chat(chatColor, 'No SirPopaLot action for target: ' .. tostring(target.name) .. ' Using Quicktrade 2')
        windower.send_command('qt2 pull')
    end
end


windower.register_event('addon command', function(cmd, ...)
    local target
	if cmd then
        cmd = cmd:lower()
    end

    if cmd == 'info' then
        target = windower.ffxi.get_mob_by_target('t')
        local zone = windower.ffxi.get_info().zone
		windower.add_to_chat(chatColor, zone)
        if target then
            windower.add_to_chat(chatColor, target.x)
            windower.add_to_chat(chatColor, target.y)
        end

    elseif cmd == 'ki' then
        KiProtection = not KiProtection
        windower.add_to_chat(chatColor, 'Key Item Protection is now: ' .. tostring(KiProtection))

    else
        target = windower.ffxi.get_mob_by_target('t')
			if not target then
				windower.send_command('input /targetnpc')
				local waited = 0
				while not target and waited < 2 do
					coroutine.sleep(0.1)
					waited = waited + 0.1
					target = windower.ffxi.get_mob_by_target('t')
				end
			end

        if target then
            TradeIt(target)
        end
    end
end)











function HasKeyItem(id)
    local keyitems = windower.ffxi.get_key_items()
    for i = 1, #keyitems do
        if keyitems[i] == id then
            return true
        end
    end
    return false
end









-- Helper Functions

function MultipleKeyItemsTrades(trades)
    local keyItems = {}

    for _, id in ipairs(windower.ffxi.get_key_items()) do
        keyItems[id] = true
    end

    for i = 1, #trades do
        local t = trades[i]
        if not keyItems[t.keyItem] then
            windower.send_command(t.cmd)
            return true
        end
    end

    return false
end




local function GetResources()
    if not res then
        res = require('resources')
    end
    return res
end


local function GetItemIdByName(name)
    local resources = GetResources()

    for id, item in pairs(resources.items) do
        if item and item.en == name then
            return id
        end
    end

    return nil
end


    
local function CountInventoryItemById(item_id)
    if not item_id then return 0 end

    local inventory = windower.ffxi.get_items(0)
    local total = 0

    for _, entry in pairs(inventory) do
        if type(entry) == 'table' and entry.id == item_id then
            total = total + (entry.count or 1)
        end
    end

    return total
end



local function HasUpgradeItems(entry)
    local base_id = GetItemIdByName(entry.Base)
    if not base_id then return false end

    local upgrade_id = GetItemIdByName(entry.Upgrades)
    if not upgrade_id then return false end

    local needed = entry.count or 50

    if CountInventoryItemById(base_id) < 1 then return false end
    if CountInventoryItemById(upgrade_id) < needed then return false end

    return true
end

function UpgradeTrades(trades)
    for i = 1, #trades do
        local t = trades[i]
        if HasUpgradeItems(t) then
            windower.send_command(t.cmd)
            return true
        end
    end
    return false
end










function TradeAsManyAsPossible(item_name, max_count)
    local item_id = GetItemIdByName(item_name)
    if not item_id then
        return false
    end

    local count = CountInventoryItemById(item_id)
    if count < 1 then
        return false
    end

    count = math.min(count, max_count or 100)

    windower.send_command(('TradeNPC %d "%s"'):format(count, item_name))
    return true
end














function OpenMenu(timeout)
    timeout = timeout or 5 -- seconds

    windower.send_command('setkey enter down;wait 0.1;setkey enter up')

    local waited = 0
    while waited < timeout do
        local player = windower.ffxi.get_player()

        if player and player.status == 4 then
            coroutine.sleep(0.5)
            return true
        end

        coroutine.sleep(0.1)
        waited = waited + 0.1
    end

    return false
end