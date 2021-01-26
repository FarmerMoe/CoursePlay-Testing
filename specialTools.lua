function courseplay:setNameVariable(workTool)
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
	if workTool.typeName == 'FS19_precisionFarming.SoilSampler' then
		-- workTool.spec_soilSampler or workTool.cp.hasSpecializationSoilSampler then
		courseplay:debug('EBP: workTool.spec_soilSampler: ' .. workTool.typeName .. ' has Soil Specialization')
		if workTool.spec_soilSampler then
			courseplay:debug('EBP: spec_soilSampler found')
		end
		--if workTool.cp.hasSpecializationSoilSampler then
		--	courseplay:debug('EBP: cp.hasSpecializationSoilSampler found')
		--end

		-- EBP put any soil sampler special variables here ..
		if workTool.spec_soilSampler.samplingRadius ~= nil then
			-- Reduce oval size by truncating decimal thereby only using integer number.
			workTool.cp.specialWorkWidth = math.floor(workTool.spec_soilSampler.samplingRadius - 0.5);
		end;
	end;
	
end;
