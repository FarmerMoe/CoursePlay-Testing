

SoilSamplerAIDriver = CpObject(UnloadableFieldworkAIDriver)

SoilSamplerAIDriver.myStates = {
	APPROACHING_SAMPLE_POINT = {},
	SAMPLING = {},
	MOVE_FORWARD_AFTER_SAMPLING = {}
}

function SoilSamplerAIDriver:init(vehicle)
	courseplay.infoVehicle(vehicle,'EBP - SoilSamplerAIDriver:init routine')

  courseplay.debugFormat(6,'EBP - SoilSamplerAIDriver:init routine' )
	UnloadableFieldworkAIDriver.init(self, vehicle)
	self.soilProbe = AIDriverUtil.getAIImplementWithSpecialization(vehicle, soilSampler)


  -- Soil Sampler from Precision Farming does not have no AI markers so use Probe sampler distance
	--if self.soilProbe then
  --  self.workWidth = self.samplerDistance
  --  self.isFolded
  -- foldingPart.isFoldedAnimTime = 0;
  -- foldingPart.isFoldedAnimTimeNormal = 0;
  -- foldingPart.isUnfoldedAnimTime = foldingPart.animDuration;
  -- foldingPart.isUnfoldedAnimTimeNormal = 1;


  --  self:info('EBP workwidth: ', self.workWidth ' Fill Unit: ', self.getFillUnitCapacity, ' Fill Level: ', self.getFillUnitFillLevel)
	--end

  self:initStates(SoilSamplerAIDriver.myStates)

  --self.baler = AIDriverUtil.getAIImplementWithSpecialization(vehicle, Baler)
	--if self.baler then
	--	self.balerSpec = self.baler.spec_baler
	--end
	--self.slowDownFillLevel = 200
  --  self.slowDownStartSpeed = 20
end


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


function SoilSamplerAIDriver:dismiss()
	UnloadableFieldworkAIDriver.dismiss(self)
	--revert possible change for the player to default
	if self.soilProbe then
		self.soilProbe.automaticDrop = self.oldAutomaticDrop
	end
end
