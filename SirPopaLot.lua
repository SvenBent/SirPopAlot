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
_addon.version = '26.05.28'
_addon.command = 'pop'

require('coroutine')
require('sets')

local chatColor = 207


--[[
KeyItem = xxx   : Checks for KeyItem and only execute CMD if the key item is NOT present
OpenMenu = true : Opens the menu of the npc object before passing on CMD defined commands
cmd = xxx       : Executes xxx as a command
msg = xxx       : Show the xxx as a message in chatlog
Item = xxx      : Trades all of this single items
Items = xxx     : Mix and trade all of these multiple items
]]--




--------  ||===============================||  --------
--------  || CORDINATES BASED TRADE TABLES ||  --------
--------  ||===============================||  --------


local coordinate_trade_tables = {
    -- ========================
    -- Abyssea
    -- ========================

	['Cavernous Maw:117:*:*']   = { cmd = 'Superwarp ab enter' },  -- Tahrongi Canyon
	['Cavernous Maw:102:*:*']   = { cmd = 'Superwarp ab enter' },  -- La Theine
	['Cavernous Maw:108:*:*']   = { cmd = 'Superwarp ab enter' },  -- Konschtat
	['Cavernous Maw:104:*:*']   = { cmd = 'Superwarp ab enter' },  -- Jugnue Forest
	['Cavernous Maw:103:*:*']   = { cmd = 'Superwarp ab enter' },  -- Valkurm Dunes
	['Cavernous Maw:118:*:*']   = { cmd = 'Superwarp ab enter' },  -- Buburima
	['Cavernous Maw:107:*:*']   = { cmd = 'Superwarp ab enter' },  -- South Gustaberg
	['Cavernous Maw:112:*:*']   = { cmd = 'Superwarp ab enter' },  -- Xarcabard
	['Cavernous Maw:106:*:*']   = { cmd = 'Superwarp ab enter' },  -- North Gustaberg

	['Cavernous Maw:132:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - La Theine
	['Cavernous Maw:15:*:*']    = { cmd = 'Superwarp ab exit' },   -- Abyssea - Konschtat
	['Cavernous Maw:45:*:*']    = { cmd = 'Superwarp ab exit' },   -- Abyssea - Tahrongi Canyon
	['Cavernous Maw:217:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - Vunkerl
	['Cavernous Maw:216:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - Miseraux
	['Cavernous Maw:215:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - Attohwa
	['Cavernous Maw:218:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - Altepa
	['Cavernous Maw:253:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - Uleguerand
	['Cavernous Maw:254:*:*']   = { cmd = 'Superwarp ab exit' },   -- Abyssea - Grauberg
		
    ['Sturdy Pyxis:*:*:*']      = { cmd = 'input /item "Forbidden Key" <t>'},
    ['Cruor Prospector:*:*:*']  = { OpenMenu = true, cmd = 'setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.2;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.2;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
    ['Atma Infusionist:*:*:*']  = { OpenMenu = true, cmd = 'setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3' },	
	
    -- Abyssea - Konschtat (15)
    ['???:15:-135:*']  = { keyItem = 1465, cmd = 'input /item "Armored Dragonhorn" <t>' },
    ['???:15:-156:*']  = { cmd = 'input /item "Eft Blood" <t>' },
    ['???:15:-183:*']  = { cmd = 'input /item "Oblivispore" <t>' },
    ['???:15:-236:*']  = { cmd = 'input /item "Ripped Eft Skin" <t>' },
    ['???:15:-249:*']  = { cmd = 'input /item "G. Slug Eyestalk" <t>' },
    ['???:15:-359:*']  = { cmd = 'input /item "Snakeskin Moss" <t>' },
    ['???:15:150:*']   = { cmd = 'input /item "Tiny Morbol Vine" <t>' },
    ['???:15:360:*']   = { cmd = 'input /item "Murmuring Glob" <t>' },
    ['???:15:370:*']   = { cmd = 'input /item "Rotting Eyeball" <t>' },
    ['???:15:438:*']   = { keyItem = 1466, cmd = 'input /item "Clouded Lens" <t>' },
    ['???:15:54:*']    = { keyItem = 1464, cmd = 'input /item "Giant Bugard Tusk" <t>' },
    ['???:15:630:*']   = { cmd = 'input /item "Moonglow Cloth" <t>' },

    -- Abyssea - Tahrongi (45)
    ['???:45:-129:*']  = { cmd = 'input /item "Shocking Whisker" <t>' },
    ['???:45:-196:*']  = { keyItem = 1468, cmd = 'TradeNPC 1 "Bloodshot Hecteye" 1 "Shriveled Wing" 1 "Tarnished Pincer"' },
    ['???:45:-219:*']  = { cmd = 'input /item "Moaning Vestige" <t>' },
    ['???:45:-235:*']  = { cmd = 'input /item "H.Q. Cli. Wing" <t>' },
    ['???:45:-281:*']  = { keyItem = 1470, cmd = 'TradeNPC 1 "Acidic Humus" 1 "V. Scorp. Stinger"' },
    ['???:45:-355:*']  = { cmd = 'input /item "Baleful Skull" <t>' },
    ['???:45:-41:*']   = { keyItem = 1472, cmd = 'TradeNPC 1 "Quiv. Eft Egg" 1 "Ctrice. Tailmeat"' },
    ['???:45:184:*']   = { keyItem = 1469, cmd = 'TradeNPC 1 "Exorcised Skull" 1 "Bloody Fang"' },
    ['???:45:247:*']   = { keyItem = 1474, cmd = 'TradeNPC 1 "Smooth Whisker" 1 "Resilient Mane"' },
    ['???:45:403:*']   = { cmd = 'input /item "Eft Egg" <t>' },
    ['???:45:71:*']    = { cmd = 'input /item "Alkaline Humus" <t>' },
    ['???:45:74:*']    = { cmd = 'input /item "H.Q. Lim. Pincer" <t>' },

    -- Abyssea - La Theine (132)
    ['???:132:-358:*'] = { keyItem = 1483, cmd = 'input /item "Oversized Sock" <t>' },
    ['???:132:-399:*'] = { keyItem = 1484, cmd = 'input /item "Massive Armband" <t>' },
    ['???:132:-717:*'] = { keyItem = 1482, cmd = 'input /item "Trophy Shield" <t>' }, 
    ['???:132:-74:*']  = { keyItem = 1486, cmd = 'input /item "Piceous Scale" <t>' },
    ['???:132:-765:*'] = { keyItem = 1479, cmd = 'input /item "Gargantuan Black Tiger Fang" <t>' },
    ['???:132:-87:*']  = { cmd = 'input /item "Filthy Gnole Claw" <t>' },
    ['???:132:279:*']  = { keyItem = 1478, cmd = 'input /item "Raw Mutton Chop" <t>' },
    ['???:132:309:*']  = { cmd = 'input /item "Winter Puk Egg" <t>' },
    ['???:132:405:*']  = { cmd = 'input /item "Bug-eaten Hat" <t>' },
    ['???:132:696:*']  = { cmd = 'input /item "Dried Chigoe" <t>' },
    ['???:132:81:*']   = { keyItem = 1485, cmd = 'input /item "Tr. Insect Wing" <t>' },

    -- Abyssea - Attohwa (215)
    ['???:215:-133:*'] = { keyItem = 1493, cmd = 'input /item "Undying Ooze" <t>' },
    ['???:215:-159:*'] = { keyItem = 1495, cmd = 'input /item "Wailing Rags" <t>' },
    ['???:215:-281:*'] = { cmd = 'input /item "Extended Eyestalk" <t>' },
    ['???:215:-402:*'] = { cmd = 'input /item "Gory Pincer" <t>' },
    ['???:215:-546:*'] = { keyItem = 1497, cmd = 'input /item "Cracked Dragonscale" <t>' },
    ['???:215:198:*']  = { cmd = 'input /item "Mangled Cockatrice Skin" <t>' },
    ['???:215:214:*']  = { cmd = 'input /item "Coeurl Round" <t>' },
    ['???:215:233:*']  = { keyItem = 1489, cmd = 'input /item "Eruca Egg" <t>' },
    ['???:215:281:*']  = { keyItem = 1491, cmd = 'input /item "Blanched Silver" <t>' },
    ['???:215:401:*']  = { keyItem = 1488, cmd = 'input /item "Withered Cocoon" <t>' },
    ['???:215:403:*']  = { keyItem = 1494, cmd = 'input /item "Bone Chips" <t>' },
    ['???:215:410:*']  = { cmd = 'input /item "Withered Bud" <t>' },
    ['???:215:481:*']  = { cmd = 'input /item "Great Root" <t>' },

    -- Abyssea - Misareaux (216)
    ['???:216:-123:*'] = { cmd = 'input /item "Spotted Flyfrond" <t>' },
    ['???:216:-162:*'] = { keyItem = 1504, cmd = 'input /item "Orbn. Cheekmeat" <t>' },
    ['???:216:-199:*'] = { keyItem = 1506, cmd = 'input /item "Spheroid Plate" <t>' },
    ['???:216:120:*']  = { keyItem = 1502, cmd = 'input /item "Avian Remex" <t>' },
    ['???:216:180:*']  = { keyItem = 1501, cmd = 'input /item "Apkallu Down" <t>' },
    ['???:216:201:*']  = { cmd = 'TradeNPC 1 "H.Q. Crab Meat" 1 "H.Q. Rock Salt"' },
    ['???:216:321:*']  = { cmd = 'input /item "Hardened Raptor Skin" <t>' },
    ['???:216:346:*']  = { keyItem = 1499, cmd = 'input /item "Handful of molt scraps" <t>' },
    ['???:216:411:*']  = { cmd = 'input /item "Black Rabbit Tail" <t>' },
    ['???:216:41:*']   = { cmd = 'input /item "Mocking Beak" <t>' },
    ['???:216:521:*']  = { keyItem = 1498, cmd = 'input /item "Bewitching Tusk" <t>' },
    ['???:216:718:*']  = { cmd = 'input /item "Worm-Eaten Bud" <t>' },

    -- Abyssea - Vunkerl (217)
    ['???:217:-116:*'] = { keyItem = 1508, cmd = 'input /item "Gnarled Taurus Horn" <t>' },
    ['???:217:-204:*'] = { cmd = 'input /item "Black Whisker" <t>' },
    ['???:217:-215:*'] = { cmd = 'input /item "Crwl. Floatstone" <t>' },
    ['???:217:-240:*'] = { cmd = 'input /item "Opaque Wing" <t>' },
    ['???:217:-279:*'] = { keyItem = 1509, cmd = 'input /item "Gargouille Stone" <t>' },
    ['???:217:-345:*'] = { cmd = 'input /item "H.Q. Rabbit Hide" <t>' },
    ['???:217:-396:*'] = { cmd = 'input /item "Djinn Ashes" <t>' },
    ['???:217:-397:*'] = { cmd = 'input /item "Shockshroom" <t>' },
    ['???:217:-476:*'] = { cmd = 'input /item "Stiffened Tentacle" <t>' },
    ['???:217:-640:*'] = { cmd = 'input /item "Dented Skull" <t>' },
    ['???:217:120:*']  = { cmd = 'input /item "Fortune Wing" <t>' },
    ['???:217:242:*']  = { keyItem = 1511, cmd = 'input /item "Moonbeam Clam" <t>' }, 

    -- Abyssea - Altepa (218)
    ['???:218:-315:*'] = { cmd = 'input /item "Sand-caked fang" <t>' }, -- Orthrus
    ['???:218:-409:*'] = { cmd = 'input /item "Puppet\'s Blood" <t>' },
    ['???:218:-492:*'] = { cmd = 'TradeNPC 1 "Oasis Water" 1 "Giant Mistletoe"' },
    ['???:218:-559:*'] = { keyItem = 1520, cmd = 'TradeNPC 1 "High-Quality Dhalmel Hide" 1 "Sharabha Hide" 1 "Tiger King\'s Hide"' },
    ['???:218:-57:*']  = { cmd = 'input /item "Ladybird Leaf" <t>' },
    ['???:218:-609:*'] = { cmd = 'input /item "Sabulous Clay" <t>' }, -- Misc
    ['???:218:-72:*']  = { cmd = 'TradeNPC 1 "Vadleany Fluid" 1 "High-Quality Scorpion Claw"' },
    ['???:218:-745:*'] = { keyItem = 1518, cmd = 'TradeNPC 1 "Smoldering Arm" 1 "Tablilla Mercury"' },
    ['???:218:-878:*'] = { cmd = 'input /item "Sandy Shard" <t>' }, -- Rani / Iron Plates
    ['???:218:36:*']   = { cmd = 'input /item "High-quality Cockatrice Skin" <t>' },

    -- Abyssea - Uleguerand (253)
    ['???:253:-116:*'] = { cmd = 'input /item "Helical Gear" <t>' }, -- Iron Plates
    ['???:253:-16:*']  = { keyItem = 1523, cmd = 'TradeNPC 1 "Bevel Gear" 1 "Gear Fluid"' },
    ['???:253:-214:*'] = { cmd = 'input /item "Gelid Arm" <t>' },
    ['???:253:-282:*'] = { keyItem = 1525, cmd = 'TradeNPC 1 "High-Quality Marid Hide" 1 "Sisyphus Fragment" 1 "Snow God Core"' },
    ['???:253:-481:*'] = { cmd = 'input /item "Imp Sentry\'s Horn" <t>' },
    ['???:253:-616:*'] = { cmd = 'TradeNPC 1 "Rimed Wing" 1 "Benumbed Eye"' },
    ['???:253:0:*']    = { cmd = 'input /item "Ice Wyvern Scale" <t>' },
    ['???:253:336:*']  = { cmd = 'input /item "High-Quality Buffalo Horn" <t>' }, -- Misc
    ['???:253:427:*']  = { cmd = 'TradeNPC 1 "High-Quality Black Tiger Hide" 1 "Audumbla Hide"' },
    ['???:253:457:*']  = { cmd = 'input /item "Whiteworm Clay" <t>' },

    -- Abyssea - Grauberg (254)
    ['???:254:-193:*'] = { cmd = 'input /item "Fay Teardrop" <t>' },
    ['???:254:-488:*'] = { cmd = 'input /item "Decaying Molar" <t>' },
    ['???:254:-69:*']  = { cmd = 'TradeNPC 1 "Unseelie Eye" 1 "Naiad\'s Lock"' },
    ['???:254:158:*']  = { cmd = 'input /item "High-Quality Pugil Scale" <t>' },
    ['???:254:320:*']  = { cmd = 'input /item "Bubbling Oil" <t>' },
    ['???:254:340:*']  = { cmd = 'input /item "Pursuer\'s Wing" <t>' },
    ['???:254:379:*']  = { cmd = 'TradeNPC 1 "High-Quality Wivre Hide" 1 "Jaculus Wing" 1 "Minaruja Skull"' },
    ['???:254:397:*']  = { cmd = 'input /item "Goblin Rope" <t>' },
    ['???:254:502:*']  = { keyItem = 1528, cmd = 'TradeNPC 1 "Teekesselchen Fragment" 1 "Darkflame Arm"' },
    ['???:254:556:*']  = { cmd = 'TradeNPC 1 "Goblin Oil" 1 "Goblin Gunpowder"' },



    -- ========================
    -- ToAU / ZNM-style
    -- ========================
	
	['Sanraku:*:*:*'] = { cmd = 'input /item "soul plate" <t>' },
	
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
    ['???:134:100:*']  = { cmd = 'input /item "Despot\'s Fortune" <t>' },
    ['???:134:266:*']  = { cmd = 'input /item "Deluder\'s Fortune" <t>' },
    ['???:134:60:*']   = { cmd = 'input /item "Villain\'s Fortune" <t>' },


    ['???:135:-108:*']   = { cmd = 'input /item "Odious Pen" <t>' },
    ['???:135:-295:*']   = { cmd = 'input /item "Snarled Goad" <t>' },
    ['???:135:-416:*']   = { cmd = 'input /item "Shrouded Bijou" <t>' },
    ['???:135:-4:*']     = { cmd = 'input /item "Demoniac Goad" <t>' },
    ['???:135:-8:*']     = { cmd = 'input /item "Divine Goad" <t>' },
    ['???:135:119:*']    = { cmd = 'input /item "Intricate Goad" <t>' },
    ['???:135:119:-113'] = { cmd = 'input /item "Holy Goad" <t>' },
    ['???:135:150:*']    = { cmd = 'input /item "Celestial Goad" <t>' },
    ['???:135:157:*']    = { cmd = 'input /item "Supernal Goad" <t>' },
    ['???:135:159:*']    = { cmd = 'input /item "Heavenly Goad" <t>' },
    ['???:135:232:*']    = { cmd = 'input /item "Ornate Goad" <t>' },
    ['???:135:238:*']    = { cmd = 'input /item "Mystic Goad" <t>' },
    ['???:135:292:*']    = { cmd = 'input /item "Mysterial Goad" <t>' },
    ['???:135:343:*']    = { cmd = 'input /item "Odious Blood" <t>' },
    ['???:135:39:*']     = { cmd = 'input /item "Stellar Goad" <t>' },
    ['???:135:39:-129']  = { cmd = 'input /item "Tenebrous Goad" <t>' },
    ['???:135:575:*']    = { cmd = 'input /item "Odious Skull" <t>' },
    ['???:135:579:*']    = { cmd = 'input /item "Odious Horn" <t>' },
    ['???:135:57:*']     = { cmd = 'input /item "Runaeic Goad" <t>' },
    ['???:135:65:*']     = { cmd = 'input /item "Seraphic Goad" <t>' },

    ['???:134:280:*']  = { cmd = 'input /item "Leering Bijou" <t>' },
    ['???:185:0:*']    = { cmd = 'input /item "Barbaric Bijou" <t>' },
    ['???:186:-17:*']  = { cmd = 'input /item "Steelwall Bijou" <t>' },
    ['???:187:94:*']   = { cmd = 'input /item "Divine Bijou" <t>' },
    ['???:188:0:-102'] = { cmd = 'input /item "Roving Bijou" <t>' },
    
	['???:186:-105:*'] = { cmd = 'input /item "Odious Engraving" <t>' },	
    ['???:188:-24:*']  = { cmd = 'input /item "Odious Die" <t>' },
    ['???:188:0:127']  = { cmd = 'input /item "Odious Grenade" <t>' },
    ['???:188:0:68']   = { cmd = 'input /item "Odious Cup" <t>' },
    ['???:188:23:*']   = { cmd = 'input /item "Odious Mask" <t>' },

    ['???:39:-202:*']  = { cmd = 'input /item "Nightmare Water" <t>' },
    ['???:39:63:*']    = { cmd = 'input /item "Creeper\'s Juju" <t>' },
    ['???:40:-261:*']  = { cmd = 'input /item "Undying juju" <t>' },
    ['???:41:149:*']   = { cmd = 'input /item "Herald juju" <t>' },


    -- ========================
    -- Sky
    -- ========================
    ['???:130:569:*']  = { cmd = 'TradeNPC 1 "Gem of the East" 1 "Springstone"' },
    ['???:130:253:*']  = { cmd = 'TradeNPC 1 "Gem of the North" 1 "Winterstone"' },
    ['???:130:-511:*'] = { cmd = 'TradeNPC 1 "Gem of the South" 1 "Summerstone"' },
    ['???:130:-412:*'] = { cmd = 'TradeNPC 1 "Gem of the West" 1 "Autumnstone"' },

    ['???:177:0:*']    = { cmd = 'input /item "Curtana" <t>' },

    ['???:178:-79:*']  = { cmd = 'TradeNPC 1 "Seal of Genbu" 1 "Seal of Seiryu" 1 "Seal of Byakko" 1 "Seal of Suzaku"' },
    ['???:178:740:*']  = { cmd = 'input /item "Diorite" <t>' },
    ['???:178:849:*']  = { cmd = 'input /item "Ro\'Maeve Water" <t>' },


    -- ========================
    -- Sea Serpent Grotto
    -- ========================	
	[':176:280:*'] = { cmd = 'input /item "Silver Beastcoin" <t>' },
	[':176:40:*']  = { cmd = 'input /item "Mtl. Beastcoin" <t>' },
	[':176:60:*']  = { cmd = 'input /item "Gold Beastcoin" <t>' },
	
    -- ========================
    --  Misc NMs
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
    ['Burning Circle:168:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Chamber of Oracles
    ['Burning Circle:139:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Horlais Peak
    ['Burning Circle:146:*:*'] = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Balga's Dais
    ['Mahogany Door:163:*:*']  = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Sacrificial Chamber
	['Throne Room:*:*:*']  = { cmd = 'input /item "Macrocosmic Orb" <t>' }, -- Throne Room

    -- Mars Orb 
    ['Burning Circle:144:*:*'] = { cmd = 'TradeNPC 1 "Mars Orb"' }, -- Waughroon Shrine

    -- Zelos Orb
    ['Wind Pillar:*:*:*']      = { cmd = 'input /item "Zelos Orb" <t>' },
	
	
	-- ========================
    -- Limbus
    -- ========================	

	-- Apollyon
	['Swirling Vortex:33:*:*']  = { cmd = 'Superwarp li enter' },
    ['Swirling Vortex:38:*:*'] = { cmd = 'Superwarp li port' },
	['Radiant Aureole:38:*:*'] = { cmd = 'Superwarp li Exit' },

    -- Temenos
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
    -- Unity
    -- ========================
	
    ['Ethereal Junction:101:*:*'] = { cmd = 'AdjustROE add Hugemaw Harold'},
    ['Ethereal Junction:107:*:*'] = { cmd = 'AdjustROE add Bounding Belinda'},
    ['Ethereal Junction:116:*:*'] = { cmd = 'AdjustROE add Prickly Pitriv'},
    ['Ethereal Junction:102:*:*'] = { cmd = 'AdjustROE add Ironhorn Baldurno'},
    ['Ethereal Junction:108:*:*'] = { cmd = 'AdjustROE add Sleepy Mabel'},
    ['Ethereal Junction:117:*:*'] = { cmd = 'AdjustROE add Serpopard Ninlil'},
    ['Ethereal Junction:118:*:*'] = { cmd = 'AdjustROE add Abyssdiver'},
    ['Ethereal Junction:24:*:*']  = { cmd = 'AdjustROE add Immanibugard'},
    ['Ethereal Junction:4:*:*']   = { cmd = 'AdjustROE add Intuila'},
    ['Ethereal Junction:126:*:*'] = { cmd = 'AdjustROE add Jester Malatrix'},
    ['Ethereal Junction:2:*:*']   = { cmd = 'AdjustROE add Orcfeltrap'},
    ['Ethereal Junction:123:*:*'] = { cmd = 'AdjustROE add Sybaritic Samantha'},
    ['Ethereal Junction:103:*:*'] = { cmd = 'AdjustROE add Valkurm Imperator'},
    ['Ethereal Junction:114:*:*'] = { cmd = 'AdjustROE add Cactrot Veloz'},
    ['Ethereal Junction:167:*:*'] = { cmd = 'AdjustROE add Garbage Gel'},
    ['Ethereal Junction:104:*:*'] = { cmd = 'AdjustROE add Emperor Arthro'},
    ['Ethereal Junction:109:*:*'] = { cmd = 'AdjustROE add Joyous Green'},
    ['Ethereal Junction:121:*:*'] = { cmd = 'AdjustROE add Keeper of Heiligtum'},
    ['Ethereal Junction:25:*:*']  = { cmd = 'AdjustROE add Tiyanak'},
    ['Ethereal Junction:119:*:*'] = { cmd = 'AdjustROE add Warblade Beak'},
    ['Ethereal Junction:213:*:*'] = { cmd = 'AdjustROE add Voso'},
    ['Ethereal Junction:124:*:*'] = { cmd = 'AdjustROE add Woodland Mender'},
    ['Ethereal Junction:120:*:*'] = { cmd = 'AdjustROE add Arke'},
    ['Ethereal Junction:112:*:*'] = { cmd = 'AdjustROE add Beist'},
    ['Ethereal Junction:122:*:*'] = { cmd = 'AdjustROE add Douma Weapon'},
    ['Ethereal Junction:125:*:*'] = { cmd = 'AdjustROE add King Uropygid'},
    ['Ethereal Junction:111:*:*'] = { cmd = 'AdjustROE add Largantua'},
    ['Ethereal Junction:105:*:*'] = { cmd = 'AdjustROE add Lumber Jill'},
    ['Ethereal Junction:7:*:*']   = { cmd = 'AdjustROE add Muut'},
    ['Ethereal Junction:110:*:*'] = { cmd = 'AdjustROE add Strix'},
    ['Ethereal Junction:200:*:*'] = { cmd = 'AdjustROE add Mephitas'},
    ['Ethereal Junction:205:*:*'] = { cmd = 'AdjustROE add Coca'},
    ['Ethereal Junction:153:*:*'] = { cmd = 'AdjustROE add Ayapec'},
    ['Ethereal Junction:174:*:*'] = { cmd = 'AdjustROE add Specter Worm'},
    ['Ethereal Junction:160:*:*'] = { cmd = 'AdjustROE add Azrael'},
    ['Ethereal Junction:176:*:*'] = { cmd = 'AdjustROE add Bakunawa'},
    ['Ethereal Junction:159:*:*'] = { cmd = 'AdjustROE add Azure-toothed Clawberry'},
    ['Ethereal Junction:208:*:*'] = { cmd = 'AdjustROE add Centurio XX-I'},
    ['Ethereal Junction:190:*:*'] = { cmd = 'AdjustROE add Crom Dubh'},
    ['Ethereal Junction:177:*:*'] = { cmd = 'AdjustROE add Fleetstalker'},
    ['Ethereal Junction:151:*:*'] = { cmd = 'AdjustROE add Grandgousier'},
    ['Ethereal Junction:184:*:*'] = { cmd = 'AdjustROE add Kabandha'},
    ['Ethereal Junction:159:*:*'] = { cmd = 'AdjustROE add Naga Raja'},
    ['Ethereal Junction:127:*:*'] = { cmd = 'AdjustROE add Sovereign Behemoth'},
    ['Ethereal Junction:51:*:*']  = { cmd = 'AdjustROE add Thu\'ban'},


    -- ========================
    -- Odyssey
    -- ========================
	
    ['Veridical Conflux #1:*:*:*']  = { cmd = 'Superwarp od port' },
    ['Veridical Conflux #2:*:*:*']  = { cmd = 'Superwarp od port' },
    ['Veridical Conflux #3:*:*:*']  = { cmd = 'Superwarp od port' },
    ['Veridical Conflux #4:*:*:*']  = { cmd = 'Superwarp od port' },
    ['Veridical Conflux #5:*:*:*']  = { cmd = 'Superwarp od port' },
    ['Veridical Conflux #6:*:*:*']  = { cmd = 'Superwarp od port' },

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
	
    ['Undulating Confluence:126:*:*']       = { cmd = 'Superwarp ew enter' }, -- Qufim
	['Undulating Confluence:25:*:*']        = { cmd = 'Superwarp ew enter' }, -- Miseraux
	['Undulating Confluence:288:*:*']       = { cmd = 'Superwarp ew exit' },  -- Esha Zitah
	['Undulating Confluence:289:*:*']       = { cmd = 'Superwarp ew exit' },  -- Escha-Ru'aun
	
	['Affi:*:*:*'] = {
		-- Tier I
		{ keyItem = 2895, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2896, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2897, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2898, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2899, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2900, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2901, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2902, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2903, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2904, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2905, cmd = 'TradeNPC 6 "Fish Mithkabob"' },
		{ keyItem = 2906, cmd = 'TradeNPC 6 "Fish Mithkabob"' },

		-- Tier II
		{ keyItem = 2911, cmd = 'input /item "Ayapec\'s Shell" <t>' },
		{ keyItem = 2912, cmd = 'input /item "Ethereal Incense" <t>' },
		{ keyItem = 2913, cmd = 'input /item "Ayapec\'s Shell" <t>' },
		{ keyItem = 2914, cmd = 'input /item "Ethereal Incense" <t>' },
		{ keyItem = 2915, cmd = 'input /item "Ayapec\'s Shell" <t>' },
		{ keyItem = 2916, cmd = 'input /item "Ethereal Incense" <t>' },

		-- Tier III
		{ keyItem = 2917, cmd = 'TradeNPC 5 "Riftborn Boulder"' },
		{ keyItem = 2918, cmd = 'TradeNPC 5 "Beitetsu"' },
		{ keyItem = 2919, cmd = 'TradeNPC 5 "Pluton"' },

		-- HELM
		{ keyItem = 2907, cmd = 'TradeNPC 1 "Duskcrawler" 1 "Gravewood Log"' },
		{ keyItem = 2908, cmd = 'TradeNPC 1 "Ashweed" 1 "Gravewood Log"' },
		{ keyItem = 2909, cmd = 'TradeNPC 1 "Ashweed" 1 "Duskcrawler"' },
		{ keyItem = 2910, cmd = 'TradeNPC 1 "Ashweed" 1 "Duskcrawler" 1 "Gravewood Log"' },
	},
	
	
	['Dremi:*:*:*'] = {
		-- Tier I
		{ keyItem = 2927, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2928, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2929, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2930, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2931, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2932, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2933, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2934, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2935, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2936, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2937, cmd = 'TradeNPC 2 "Ebony Lumber"' },
		{ keyItem = 2938, cmd = 'TradeNPC 2 "Ebony Lumber"' },

		-- Tier II
		{ keyItem = 2939, cmd = 'TradeNPC 5 "Vidmapire\'s Claw"' },
		{ keyItem = 2940, cmd = 'TradeNPC 5 "Azrael\'s Eye"' },
		{ keyItem = 2941, cmd = 'TradeNPC 5 "Centurio\'s Armor"' },
		{ keyItem = 2942, cmd = 'TradeNPC 5 "Mhuufya\'s Beak"' },
		{ keyItem = 2943, cmd = 'TradeNPC 5 "Tuft of Camahueto\'s Fur"' },
		{ keyItem = 2944, cmd = 'TradeNPC 5 "Vedrfolnir\'s Wing"' },

		-- Tier III
		{ keyItem = 2945, cmd = 'input /item "Waktza Crest" <t>' },
		{ keyItem = 2946, cmd = 'input /item "Yggdreant Root" <t>' },
		{ keyItem = 2947, cmd = 'input /item "Cehuetzi Pelt" <t>' },

		-- Gods
		{ keyItem = 2948, cmd = 'TradeNPC 3 "Byakko Scrap"' },
		{ keyItem = 2949, cmd = 'TradeNPC 3 "Genbu Scrap"' },
		{ keyItem = 2950, cmd = 'TradeNPC 3 "Seiryu Scrap"' },
		{ keyItem = 2951, cmd = 'TradeNPC 3 "Suzaku Scrap"' },
		{ keyItem = 2952, cmd = 'TradeNPC 5 "Byakko Scrap" 5 "Genbu Scrap" 5 "Seiryu Scrap" 5 "Suzaku Scrap"' },

		-- Angels
		{ keyItem = 2953, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Ashweed" 1 "Gravewood Log"' },
		{ keyItem = 2954, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Gravewood Log" 1 "Duskcrawler"' },
		{ keyItem = 2955, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Duskcrawler" 1 "Ashen Crayfish"' },
		{ keyItem = 2956, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Ashweed" 1 "Ashen Crayfish"' },
		{ keyItem = 2957, cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink" 1 "Ashen Crayfish" 1 "Gravewood Log"' },
	},



	['Shiftrix:*:*:*'] = {
		-- Tier I
		{ keyItem = 2991, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2992, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2993, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2994, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2995, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2996, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2997, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2998, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 2999, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 3000, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 3001, cmd = 'input /item "Behem. Leather" <t>' },
		{ keyItem = 3002, cmd = 'input /item "Behem. Leather" <t>' },

		-- Tier II
		{ keyItem = 3003, cmd = 'TradeNPC 2 "Ymmr-Ulvid\'s Grand Coffer"' },
		{ keyItem = 3004, cmd = 'TradeNPC 2 "Ignor-Mnt\'s Grand Coffer"' },
		{ keyItem = 3005, cmd = 'TradeNPC 2 "Durs-Vike\'s Grand Coffer"' },
		{ keyItem = 3006, cmd = 'TradeNPC 2 "Tryl-Wuj\'s Grand Coffer"' },
		{ keyItem = 3007, cmd = 'TradeNPC 2 "Liij-Vok\'s Grand Coffer"' },
		{ keyItem = 3008, cmd = 'input /item "Gramk-Droog\'s Grand Coffer" <t>' },

		-- Tier III
		{ keyItem = 3009, cmd = 'input /item "Sovereign Behemoth\'s Hide" <t>' },
		{ keyItem = 3010, cmd = 'input /item "Hidhaegg\'s Scale" <t>' },
		{ keyItem = 3011, cmd = 'input /item "Tolba\'s Shell" <t>' },

		-- HELM
		{ keyItem = 3012, cmd = 'TradeNPC 3 "Void Crystal" 3 "Voidsnapper" 1 "Siren\'s Hair" 1 "Scroll of Maiden\'s Virelai"' },
		{ keyItem = 3013, cmd = 'TradeNPC 3 "Void Grass" 3 "Ashen Crayfish" 10 "Flan Meat" 1 "Black Pudding"' },
		{ keyItem = 3014, cmd = 'TradeNPC 3 "Void Crystal" 3 "Duskcrawler" 10 "Bone Chip" 1 "Scarletite Ingot"' },
		{ keyItem = 3015, cmd = 'TradeNPC 3 "Voidsnapper" 3 "Gravewood Log" 1 "Bztavian Stinger" 1 "Leafslit"' },
		{ keyItem = 3016, cmd = 'TradeNPC 3 "Ashweed" 3 "Void Grass" 1 "Vermihumus" 1 "Coalition Humus"' },
		{ keyItem = 3017, cmd = 'TradeNPC 3 "Void Crystal" 3 "Void Grass" 10 "Titanite" 1 "Worm Mulch"' },
		{ keyItem = 3018, cmd = 'TradeNPC 3 "Voidsnapper" 3 "Ashweed" 1 "Mistmelt" 1 "Scroll of Tornado"' },
	},

    -- ========================
    -- HTMB Area
    -- ========================
	
    ['Trisvain:*:*:*']       = { cmd = 'htmb' },
    ['Raving Opossum:*:*:*'] = { cmd = 'htmb' },
    ['Mimble-Pimble:*:*:*']  = { cmd = 'htmb' },
	

    -- ========================
    -- Delve
    -- ========================
	
['Anomaly Expert:*:*:*'] = {

    { keyItem = 2296, cmd = 'input /item "Celadon Yggrete" <t>' },
    { keyItem = 2297, cmd = 'input /item "Zaffre Yggrete" <t>' },
    { keyItem = 2298, cmd = 'input /item "Alizarin Yggrete" <t>' },
    { keyItem = 2529, cmd = 'input /item "Phlox Yggrete" <t>' },
    { keyItem = 2530, cmd = 'input /item "Russet Yggrete" <t>' },
    { keyItem = 2531, cmd = 'input /item "Aster Yggrete" <t>' },

},
	
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
	
	['Back to Town:*:*:*']          = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up'},


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
	['Mythril Seam:143:*:*']   = { cmd = 'input /item "Pickaxe" <t>' },


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
	['Flotsam:*:*:*']            = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1.5;setkey enter down;wait 0.1;setkey enter up' },

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

    ['Runic Portal:*:*:*'] = { cmd = 'Superwarp Po return' },


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
    ['Emporox:*:*:*']   = { OpenMenu = true, cmd = 'setkey right down;wait 0.1;setkey right up;wait 0.1;setkey right down;wait 0.1;setkey right up;wait 0.1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },

    ['Task Delegator:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up;wait 0.5;setkey enter down;wait 0.1;setkey enter up' },

    ['Dimmian:*:*:*'] = { OpenMenu = true, cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },


    -- ========================
    -- Fame
    -- ========================
	
    ['Mighty Fist:*:*:*'] = { cmd = 'TradeNPC 2 "Darksteel ore"' },
	['Nanaa Mihgo:*:*:*'] = { cmd = 'TradeNPC 4 "Yagudo Necklace"' },
    ['Wyatt:*:*:*']       = { cmd = 'TradeNPC 4 "Ladybug Wing"' },
    ['Saldinor:*:*:*']    = { cmd = 'TradeNPC 2 "Twitherym Wing"' },
    ['Felmsy:*:*:*']      = { cmd = 'input /item "Velkk necklace" <t>;input /item "Velkk Mask" <t>' },
    ['Pudith:*:*:*']      = { cmd = 'input /item "Umbril Ooze" <t>' },
    ['Yocile:*:*:*']      = { cmd = 'TradeNPC 2 "Elshimo Coconut"' },
	['Melyon:*:*:*']      = { cmd = 'TradeNPC 3 "Millioncorn;wait 2; setkey enter down;wait 0.1;setkey enter up"' },
    ['Yoran-Oran:*:*:*']  = { cmd = 'input /item "Cornette" <t>' },	

    ['Belgidiveau:*:*:*']  = { cmd = 'input /item "shk. whisker" <t>; input /item "spotted flyfrond" <t>; input /item "Mngl. Ck. Skin" <t>; input /item "Coeurl Round" <t>; input /item "amb. Pseudopod" <t>' },
    ['Cornelia:*:*:*']     = { cmd = 'input /item "Pursuer\'s Wing" <t>' },
    ['Moreno-Toeno:*:*:*'] = { cmd = 'input /item "Manigordo Tusk" <t>; input /item "Manigordo Tusk" <t>; input /item "Manigordo Tusk" <t>' },
	
	
    -- ========================
    -- Mobility/Access
    -- ========================
	 ['Chocobo:*:*:*']         = { cmd = 'input /item "Gausebit Grass" <t>' },
	
    ['Kuu Mohzolhi:*:*:*']  = { cmd = 'input /item "Marguerite" <t>' },
    ['Valah Molkot:*:*:*']  = { cmd = 'input /item "Amaryllis" <t>' },
    ['Ojha Rhawash:*:*:*']  = { cmd = 'input /item "Lilac" <t>' },
    ['Zona Shodhun:*:*:*']  = { cmd = 'input /item "Yellow Rock" <t>' },
	['Ahkk Jharcham:*:*:*'] = { cmd = 'TradeNPC 1 "Parchment" 1 "Black Ink"' },

	['Apolliane:*:*:*']     = { cmd = 'input /item "Marble Nugget" <t>' },	
	['Choubollet:*:*:*']    = { cmd = 'TradeNPC 3 "Dhalmel Leather" 1 "Umbril Ooze" 1 "Twitherym Scale"'},	
	['Traiffeaux:*:*:*']    = { cmd = 'TradeNPC 3 "Rabbit hide" 1 "Raaz Tusk"'},
	['Lerene:*:*:*']        = { cmd = 'TradeNPC 2 "Ancestral Cloth"'},	
	

    -- ========================
    -- Quests
    -- ========================
	
    ['Bluffnix:*:*:*']        = { cmd = 'input /item "Goblin Stew 880" <t>'},
	['Pawkrix:*:*:*']         = { cmd = 'setkey enter down;wait 0.1;setkey enter up;wait 1;setkey enter down;wait 0.1;setkey enter up; wait 0.3;setkey right down;wait 0.1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up'},
	['Ghebi Damomohe:*:*:*']  = { cmd = 'input /item "Tenshodo Invite" <t>'},
	['Sattal-Mansal:*:*:*']   = { cmd = 'input /item "Quadav Charm" <t>;input /item "Quadav Augury Shell" <t>'},
	
    ['Fay Spring:*:*:*']      = { cmd = 'input /item "Bottled Pixie" <t>' },
    ['Altar of Rancor:*:*:*'] = { cmd = 'input /item "Unlit Lantern" <t>' },
    ['Qu\'Hau Spring:*:*:*']  = { cmd = 'TradeNPC 1 "Parchment" 1 "Illuminink"' },

    ['Runje Desaali:*:*:*']    = { cmd = 'input /item "Atetepeyorg" <t>; input /item "Azukinagamitsu" <t>; input /item "Icoyoca" <t>; input /item "Macoquetza" <t>; input /item "Maochinoli" <t>; input /item "Suijingiri KM" <t>; input /item "Tamaxchi" <t>; input /item "Tlalpoloani" <t>; input /item "Tzacab Grip" <t>; input /item "Otomi Helm" <t>; input /item "Quauhpilli Helm" <t>; input /item "Xux Hat" <t>; input /item "Uk\'uxkaj Cap" <t>; input /item "Buremte Gloves" <t>; input /item "Otomi Gloves" <t>; input /item "Kaabnax Trousers" <t>; input /item "Quiahuiz Trousers" <t>; input /item "Uk\'uxkaj Boots" <t>'},
    ['Odyssean Passage:*:*:*'] = { cmd = 'input /item "Befouled Water" <t>' },

	['Abelard:*:*:*'] = { cmd = 'Tradenpc 3 "Bee Pollen" <t>' },
	
	['Reet:*:*:*']    = { cmd = 'input /item "Adventurer Cpn." <t>' },
	['Ailevia:*:*:*'] = { cmd = 'input /item "Adventurer Cpn." <t>' },

	['???:108:-710:102'] = { cmd = 'input /item "Oriental Steel" <t>' }, -- Job Quest SAM
	['???:121:642:-150'] = { cmd = 'input /item "Sacred Sprig" <t>' },   -- Job Quest SAM
	['Jaucribaix:*:*:*'] = { cmd = 'TradeNPC 1 "Bomb Steel" 1 "Sacred Branch"' },   -- Job Quest SAM
	
	
    -- ========================
    -- Unsorted/Misc
    -- ========================	
	
	['Anomaly Trigger #1:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #2:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #3:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #4:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #5:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	['Anomaly Trigger #6:*:*:*'] = { cmd = 'input /lockon;setkey w down;wait 1;setkey w up;setkey enter down;wait 0.1;setkey enter up' },
	
	['Artisan Moogle:*:*:*'] = { OpenMenu = true, cmd = 'wait 1;setkey right down;wait 0.1;setkey right up;wait 0.1;setkey enter down;wait 0.1;setkey enter up' },
	

	['Lola:*:*:*'] = {
		{ item_id = 4036, item_name = 'Lebondopt Wing', stack = 12 },
		{ item_id = 3950, item_name = 'Pulchridopt Wing', stack = 12 },
	},

	['Waypoint:*:*:*'] = {
		items = {
			-- Crystals
			{ item_id = 4096, item_name = 'Fire Crystal', stack = 12 },
			{ item_id = 4097, item_name = 'Ice Crystal', stack = 12 },
			{ item_id = 4098, item_name = 'Wind Crystal', stack = 12 },
			{ item_id = 4099, item_name = 'Earth Crystal', stack = 12 },
			{ item_id = 4100, item_name = 'Lightning Crystal', stack = 12 },
			{ item_id = 4101, item_name = 'Water Crystal', stack = 12 },
			{ item_id = 4102, item_name = 'Light Crystal', stack = 12 },
			{ item_id = 4103, item_name = 'Dark Crystal', stack = 12 },
			-- Clusters			
			{ item_id = 4104, item_name = 'Fire Cluster', stack = 12 },
			{ item_id = 4105, item_name = 'Ice Cluster', stack = 12 },
			{ item_id = 4106, item_name = 'Wind Cluster', stack = 12 },
			{ item_id = 4107, item_name = 'Earth Cluster', stack = 12 },
			{ item_id = 4108, item_name = 'Lightning Cluster', stack = 12 },
			{ item_id = 4109, item_name = 'Water Cluster', stack = 12 },
			{ item_id = 4110, item_name = 'Light Cluster', stack = 12 },
			{ item_id = 4111, item_name = 'Dark Cluster', stack = 12 },
		}
	},
	
	['Ephemeral Moogle:*:*:*'] = {
		items = {
			-- Crystals
			{ item_id = 4096, item_name = 'Fire Crystal', stack = 12 },
			{ item_id = 4097, item_name = 'Ice Crystal', stack = 12 },
			{ item_id = 4098, item_name = 'Wind Crystal', stack = 12 },
			{ item_id = 4099, item_name = 'Earth Crystal', stack = 12 },
			{ item_id = 4100, item_name = 'Lightning Crystal', stack = 12 },
			{ item_id = 4101, item_name = 'Water Crystal', stack = 12 },
			{ item_id = 4102, item_name = 'Light Crystal', stack = 12 },
			{ item_id = 4103, item_name = 'Dark Crystal', stack = 12 },
			-- Clusters			
			{ item_id = 4104, item_name = 'Fire Cluster', stack = 12 },
			{ item_id = 4105, item_name = 'Ice Cluster', stack = 12 },
			{ item_id = 4106, item_name = 'Wind Cluster', stack = 12 },
			{ item_id = 4107, item_name = 'Earth Cluster', stack = 12 },
			{ item_id = 4108, item_name = 'Lightning Cluster', stack = 12 },
			{ item_id = 4109, item_name = 'Water Cluster', stack = 12 },
			{ item_id = 4110, item_name = 'Light Cluster', stack = 12 },
			{ item_id = 4111, item_name = 'Dark Cluster', stack = 12 },
		}
	},

}




local function HasKeyItem(id)
    local keyitems = windower.ffxi.get_key_items()
    for i = 1, #keyitems do
        if keyitems[i] == id then
            return true
        end
    end
    return false
end


local function OpenMenu(timeout)
    timeout = timeout or 5 

    windower.send_command('setkey enter down;wait 0.1;setkey enter up')

    local waited = 0
    while waited < timeout do
        local player = windower.ffxi.get_player()

        if player and player.status == 4 then
            coroutine.sleep(1.5)
            return true
        end

        coroutine.sleep(0.1)
        waited = waited + 0.1
    end

    return false
end





--- TradeAll Helper Function


local function CountInventoryItemById(item_id)
    if not item_id then
        return 0
    end

    local inventory = windower.ffxi.get_items(0)
    local total = 0

    for _, entry in pairs(inventory) do
        if type(entry) == 'table' and entry.id == item_id then
            total = total + (entry.count or 1)
        end
    end

    return total
end

local function TradeAsManyAsPossible(item_id, item_name, stack_size)
    if not item_id or not item_name then
        return false
    end

    local count = CountInventoryItemById(item_id)
    if count < 1 then
        return false
    end

    count = math.min(count, stack_size or 99)

    windower.send_command(('TradeNPC %d "%s"'):format(count, item_name))
    return true
end



local function TradeMixedItems(items)
    local MAX_TRADE_SLOTS = 8
    local trade_parts = {}
    local slots_used = 0

    for i = 1, #items do
        if slots_used >= MAX_TRADE_SLOTS then
            break
        end

        local entry = items[i]
        local item_id = entry.item_id
        local item_name = entry.item_name
        local stack_size = entry.stack or 99

        if item_id and item_name then
            local count = CountInventoryItemById(item_id)

            while count > 0 and slots_used < MAX_TRADE_SLOTS do
                local trade_count = math.min(count, stack_size)
                trade_parts[#trade_parts + 1] = ('%d "%s"'):format(trade_count, item_name)
                count = count - trade_count
                slots_used = slots_used + 1
            end
        end
    end

    if #trade_parts == 0 then
        return false
    end

    windower.send_command('TradeNPC ' .. table.concat(trade_parts, ' '))
    return true
end

---








-- Entry handling functions
local function FindEntry(target)
    local npc  = target.name
    local zone = windower.ffxi.get_info().zone
    local x    = math.floor(target.x)
    local y    = math.floor(target.y)

    return coordinate_trade_tables[npc .. ':' .. zone .. ':' .. x .. ':' .. y]
        or coordinate_trade_tables[npc .. ':' .. zone .. ':' .. x .. ':*']
        or coordinate_trade_tables[npc .. ':' .. zone .. ':*:*']
        or coordinate_trade_tables[npc .. ':*:*:*']
end


local function CacheKeyItems()
    local owned = {}
    for _, id in ipairs(windower.ffxi.get_key_items()) do
        owned[id] = true
    end
    return owned
end

local function ExecuteAction(action, ownedKeyItems)
    if not action then
        return false
    end

    if action.msg then
        windower.add_to_chat(chatColor, action.msg)
    end

    if action.keyItem then
        if ownedKeyItems then
            if ownedKeyItems[action.keyItem] then
                return false
            end
        elseif HasKeyItem(action.keyItem) then
            return false
        end
    end

    if action.OpenMenu and not OpenMenu() then
        return false
    end

    if action.cmd then
        windower.send_command(action.cmd)
        return true
    end

	if action.item_id then
		return TradeAsManyAsPossible(action.item_id, action.item_name, action.stack)
	end

	if action.items then
		return TradeMixedItems(action.items)
	end
	
    return true
end

local function ResolveEntry(entry)
    if not entry then
        return false
    end

    if not entry[1] then
        return ExecuteAction(entry)
    end

    local ownedKeyItems = CacheKeyItems()
    for i = 1, #entry do
        if ExecuteAction(entry[i], ownedKeyItems) then
            return true
        end
    end

    windower.add_to_chat(chatColor, 'No eligible action found.')
    return false
end


local function TradeIt(target)
    local entry = FindEntry(target)

    if entry then
        ResolveEntry(entry)
        
    else
	    windower.add_to_chat(chatColor, 'No SirPopaLot action for target: ' .. tostring(target.name) .. ' Using Quicktrade 2')
		windower.send_command('qt2 pull')
	end
end
---





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
			coroutine.sleep(0.5)
		end

        if target then
            TradeIt(target)
        end
    end
end)
