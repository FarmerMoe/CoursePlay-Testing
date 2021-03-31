function courseplay:setNameVariable(workTool)
courseplay:debug('EBP: specialTool:setNameVariable() for: ' .. workTool:getName() )
	if workTool.cp == nil then
		workTool.cp = {};
	end;

	courseplay:updateFillLevelsAndCapacities(workTool)

	-- TODO: is this even needed? Why not use the workTool.spec_* directly? Do we really need our own table?
	-- Only default specs!
	for i,spec in pairs(workTool.specializations) do
		if spec == Combine 			   then workTool.cp.hasSpecializationCombine 			 = true;
		elseif spec == Cutter 			   then workTool.cp.hasSpecializationCutter 			 = true;
		elseif spec == Drivable 		   then workTool.cp.hasSpecializationDrivable 			 = true;
		elseif spec == FillUnit 		   then workTool.cp.hasSpecializationFillUnit 			 = true;
		elseif spec == FillVolume 		   then workTool.cp.hasSpecializationFillVolume			 = true;
		elseif spec == MixerWagon 		   then workTool.cp.hasSpecializationMixerWagon 		 = true;
		elseif spec == Shovel 			   then workTool.cp.hasSpecializationShovel 			 = true;
		elseif spec == Leveler 		   	   then workTool.cp.hasSpecializationLeveler 			 = true;
		elseif spec == Overloading 		   then workTool.cp.hasSpecializationOverloader			 = true;
		elseif spec == Trailer	 		   then workTool.cp.hasSpecializationTrailer			 = true;
		elseif spec == BunkerSiloCompacter then workTool.cp.hasSpecializationBunkerSiloCompacter = true;		
		end;
	end;

    if workTool.cp.hasSpecializationFillUnit and workTool.cp.hasSpecializationFillVolume then
		workTool.cp.hasSpecializationFillable = true;
	end;

	--------------------------------------------------------------
	-- ###########################################################
	--------------------------------------------------------------

	-- SPECIALIZATIONS BASED
	-- [1] AUGER WAGONS
	if workTool.typeName == 'augerWagon' then
		workTool.cp.isAugerWagon = true;
	elseif workTool.cp.hasSpecializationOverloader and not workTool.cp.hasSpecializationCutter then
		workTool.cp.isAugerWagon = true;
	elseif workTool.animationParts ~= nil and workTool.animationParts[2] ~= nil and workTool.toggleUnloadingState ~= nil and workTool.setUnloadingState ~= nil then
		workTool.cp.isAugerWagon = true;
	end;

	-- [2] SOIL SAMPLERS
	if workTool.spec_soilSampler then
		-- workTool.typeName == 'FS19_precisionFarming.soilSampler' then
		-- workTool.spec_soilSampler or workTool.cp.hasSpecializationSoilSampler then
		courseplay:debug('EBP: spec_soilSampler condition in SpecialTools : ' .. workTool:getName() .. ' has Soil Specialization')

		workTool.cp.hasSpecializationSoilSampler = true;
		workTool.isSoilSampler = true

		-- EBP put any soil sampler special variables here ..

		-- Isaria Scout  [Precision Farming DLC] specific settings
		if workTool.cp.xmlFileName == 'isariaScout.xml' then
			courseplay:debug('EBP: Isaria specs')
			workTool.cp.lengthOffset = 3
			workTool.spec_foldable.turnOnFoldDirection = 0
			workTool.spec_foldable.foldingPartsStartMoveDirection = 1

			--[[
			if workTool.spec_soilSampler.samplingRadius ~= nil then
				-- Reduce oval size by truncating decimal thereby only using integer number.
				--note: removed cp
				workTool.cp.workWidth = math.floor(workTool.spec_soilSampler.samplingRadius - 0.5);
				workTool.workWidth = workTool.cp.workWidth + 50
			else
				courseplay:debug('EBP: no samplingRadius')
			end

			if workTool.rootNote == nil then
				workTool.rootNode = workTool.spec_soilSampler.samplingNode
			end
			]]
		end
	end
end
