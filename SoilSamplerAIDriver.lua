--[[
Fieldwork AI Driver for soilSampler
]]


SoilSamplerAIDriver = CpObject(FieldworkAIDriver)

SoilSamplerAIDriver.myStates = {
	DRIVING = {},
  UNFOLDING_SOILPROBE = {},
  FOLDING_SOILPROBE = {},
  TAKING_SAMPLE = {},
	SENDING_SAMPLES = {}
}

function SoilSamplerAIDriver:init(vehicle)
  courseplay.debugVehicle(11,vehicle,'SoilSamplerAIDriver:init()')
	courseplay:debug('EBP: SoilSamplerAIDriver');
  FieldworkAIDriver.init(self, vehicle)
	self:initStates(SoilSamplerAIDriver.myStates)
	self.mode = courseplay.MODE_FIELDWORK

	self.soilProbe = getAIImpWithSpec(vehicle, soilSampler)
	-- AIDriverUtil.getAIImplementWithSpecialization(vehicle, soilSampler)
  if self.soilProbe then
		courseplay:debug('EBP: SoilSamplerAIDriver:init soilProbe found')
		self.samplingNode = self.soilProbe.samplingNode
		self.sampleDistance = math.floor((self.soilProbe.samplingRadius / 2) - 0.5)
		self.numCollectedSamples = self.soilProbe.numCollectedSamples or 0

		self.todd = self.soilProbe.getIsFoldAllowed

		if self.todd then
			courseplay:debug('EBP: self.todd is true')
		else
			courseplay:debug('EBP: self.todd is false')
		end
	else
			courseplay:debug('EBP: SoilSamplerAIDriver:init soilProbe NOT found')
			courseplay:debug('EBP: XXXXXXXXXX************************************************************************XXXXXXXXXXXXXXXXXXXXXXXXXX')
  end

	-- use this to stop for testing
	self.stopImplementsWhileUnloadOrRefillOnField = true

	-- This needs to be set as a tool specific variable. For Isaria SCOUT = 3
	self.fillCapacity = 3
end



function SoilSamplerAIDriver:getAIImpWithSpec(vehicle, specialization)
	courseplay:debug('EBP: getAIImpWithSpec get attached implements ')
	local aiImplements = vehicle:getAttachedAIImplements()

	courseplay:debug('EBP: getAttachedAIImplements)

	local vehicleName = vehicle and nameNum(vehicle) or "Unknown vehicle"
	if vehicleName == 'XUV865M' or vehicleName == '724 Vario' then
		courseplay:debug('EBP: Review AIimplements on selected vehicles' .. vehicleName)

		for _, implement in ipairs(aiImplements) do

			IPN = implement.object and nameNum(implement.object) or "Unknown"
			courseplay:debug('EBP: Implement name: ' .. IPN)

		end
	end

	if SpecializationUtil.hasSpecialization(specialization, implement.object.specializations) then
		return implement.object
	end

	--[[
	courseplay:debug('EBP: getImplementWithSpecializationFromList')
	for _, implement in ipairs(implements) do


		for z,spec1 in pairs(implement.object.specializations) do
			courseplay:debug('EBP - T5 obj ' .. tostring(spec1))
		end

			--courseplay:debug('EBP - T4 specialization ' .. specialization)
			--courseplay:debug('EBP - T4 obj ' .. implement.object.specializations)

			--for i,spec in pairs(specialization) do
			--	courseplay:debug('Specialization:' .. (spec))
			--end;

			--for z,spec1 in pairs(implement.object.specializations) do
			--	courseplay:debug('Obj Specialization:' .. tostring(spec1))
			--end;


			if SpecializationUtil.hasSpecialization(specialization, implement.object.specializations) then
				return implement.object
			end
	end
	--]]

end






function SoilSamplerAIDriver:start(startingPoint)
	-- When starting work with a soilSampler it first may need to be unfolded and then can we start working
	self:debug('Starting soil sampling AI Driver work')
	StartStopWorkEvent:sendStartEvent(self.vehicle)
	self:startEngineIfNeeded()

	-- this will unfold the soilSampler when necessary
	self.vehicle:raiseAIEvent("onAIStart", "onAIImplementStart")
	self.vehicle:requestActionEventUpdate()

	if self.soilProbe.getIsUnfolded and self.soilProbe:getIsUnfolded() then
		self:debug('soilSampler already unfolded')
	else
		self:debug('Unfolding soilSampler')
		self.fieldworkState = self.states.UNFOLDING_SOILPROBE
	end
	self:debug('EBP: End sampling work routine()')
end

function SoilSamplerAIDriver:driveFieldwork(dt)
	courseplay:debug('EBP: SoilSamplerAIDriver:driveFieldwork')

--[[
	if self.fieldworkState == self.states.ROTATING_PLOW then
		self:setSpeed(0)
		if not self.plow.spec_plow:getIsAnimationPlaying(self.plow.spec_plow.rotationPart.turnAnimation) then
			self:debug('Plow rotation finished, ')
			self:setOffsetX()
			self:lowerImplements(self.vehicle)
			self.fieldworkState = self.states.WAITING_FOR_LOWER
		end
	else
	-- ]]
	if self.fieldworkState == self.states.UNFOLDING__SOILPROBE then
		self:setSpeed(0)
		if not getIsUnfolded then
			self:debug('SoilSampler unfold is finished, ')
			self:lowerImplements(self.vehicle)
			self.fieldworkState = self.states.WAITING_FOR_LOWER
		end
	else
		return FieldworkAIDriver.driveFieldwork(self, dt)
	end
	return false





end


function SoilSamplerAIDriver:dismiss()
	UnloadableFieldworkAIDriver.dismiss(self)
	--revert possible change for the player to default
end

function handleSoilProbe()
	courseplay:debug('EBP: handleSoilProbe()')
	-- Unfold antenna if Folded

	-- Drive until

	-- lower implement if raised

  -- Unfold antenna if Folded
  --if self.soilProbe.getIsFoldAllowed then
  --  self:debug('EBP SS fold Allowed');
  --end;
end




--[[

  --  self.isFolded
  -- foldingPart.isFoldedAnimTime = 0;
  -- foldingPart.isFoldedAnimTimeNormal = 0;
  -- foldingPart.isUnfoldedAnimTime = foldingPart.animDuration;
  -- foldingPart.isUnfoldedAnimTimeNormal = 1;


function SoilSamplerAIDriver:takeSample()
	courseplay.debugVehicle(6,vehicle,'SoilSamplerAIDriver:takeSample()')
  if self.soilProbe then
    if self.getCanStartSoilSampling then
      -- take soil sampler
      self.startSoilSampling()
    end
    -- If reached sample max then send samples
  end
end



--]]
