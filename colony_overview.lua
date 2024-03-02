--
-- Colony Stats Overview
-- for Minecolonies + Advanced Peripherals
-- Created by AmigaLink - https://linktr.ee/AmigaLink
--

local colony = peripheral.find("colonyIntegrator")
local mon = peripheral.find("monitor")

function prepareMonitor()
	monX, monY = mon.getSize()
	mon.clear()
	mon.setTextScale(0.5)
end

function round(number, decimals)
	local power = 10^decimals
	return math.floor(number * power) / power
end

function getChildren()
--	local citizens = colony.getCitizens()
	local children = 0
	
	for _, citizen in ipairs(citizens) do
		if (citizen["age"] == "child") then
			children = children + 1
		end
	end
	
	return children
end

function getUnemployed()
	local unemployed = 0
	
	for _, citizen in ipairs(citizens) do
		if (citizen["age"] == "adult") then
			local citizenWork = citizen["work"]
				if citizenWork == nil then
					unemployed = unemployed + 1
				end
		end
	end
	
	return unemployed
end

function stats()
	citizens = colony.getCitizens()
	
	mon.setTextColor(colors.white)
	mon.setCursorPos(2,2)
	mon.write("Overall happiness: ".. round(colony.getHappiness(), 2).. "   ")
	mon.setCursorPos(2,4)
	mon.write("Citizens: ".. colony.amountOfCitizens().. " / ".. colony.maxOfCitizens().. "  ")
	mon.setCursorPos(2,5)
	mon.write("Children: ".. getChildren().. "  ")
	mon.setCursorPos(2,6)
	mon.write("Unemployed: ".. getUnemployed().. "  ")
	
	mon.setCursorPos(2,7)
	mon.write("Construction sites: ".. colony.amountOfConstructionSites().. "  ")
	
	mon.setCursorPos(2,9)
	mon.write("Amount of graves: ".. colony.amountOfGraves())
	
--[[	mon.setCursorPos(2,10)
	mon.clearLine()
	mon.setTextColor(colors.green)
	local underAttack = "Peacefull"
	if (colony.isUnderAttack() == true) then
		mon.setTextColor(colors.red)
		underAttack = "Is under Attack!"
	end
	mon.write(underAttack)
	mon.setTextColor(colors.white)]]--
end

prepareMonitor()

while true do
	stats()
	sleep(5)
	--mon.clear()
end
