local CombinedFeaturesTest = {}

function CombinedFeaturesTest:on_start()
    self.stage = 0  -- 0: quest, 1: audio, 2: url
    self.questAccepted = false
    self.audioPlaying = false
    self.urlOpened = false
    self.interactionCount = 0
end

function CombinedFeaturesTest:on_interact()
    self.interactionCount = self.interactionCount + 1
    
    if self.stage == 0 then
        -- Stage 1: Quest acceptance dialog
        if Engine and Engine.openImGuiTextBox then
            local buttons = {"Accept Quest", "Decline"}
            local checkboxes = {
                ["Enable quest notifications"] = true
            }
            
            local questText = "Welcome, adventurer!\n\n" ..
                "A great quest awaits you. The ancient artifact has been stolen " ..
                "and needs to be recovered. Will you help?\n\n" ..
                "Rewards await those who succeed!"
            
            local success = Engine.openImGuiTextBox(
                "Quest: The Lost Artifact",
                questText,
                buttons,
                checkboxes
            )
            
            if success then
                print("Opened quest dialog")
                -- In real implementation, callback would set self.questAccepted
                -- For now, simulate acceptance after a delay
                self.questAccepted = true
                self.stage = 1
            end
        end
    elseif self.stage == 1 then
        -- Stage 2: Play audio feedback
        if Engine and Engine.playAudio then
            local pos = {0, 0, 0}
            local success = Engine.playAudio(
                "quest-audio-" .. tostring(self.entity),
                "test-audio",
                pos,
                false,  -- spatial
                false,  -- not looping
                1.0     -- full volume
            )
            
            if success then
                self.audioPlaying = true
                print("Playing quest acceptance audio")
                self.stage = 2
            end
        end
    elseif self.stage == 2 then
        -- Stage 3: Open external URL for quest details
        if Engine and Engine.openExternalUrl then
            local url = "https://example.com/quest-details"
            local success = Engine.openExternalUrl(url)
            
            if success then
                self.urlOpened = true
                print("Opening quest details URL")
                -- Reset for next cycle
                self.stage = 0
                self.questAccepted = false
                self.audioPlaying = false
                self.urlOpened = false
            end
        end
    end
end

function CombinedFeaturesTest:on_update(dt)
    -- Handle state transitions and cleanup
    if self.audioPlaying then
        -- Stop audio after a short duration (simulated)
        -- In real implementation, audio system handles this
    end
end

return CombinedFeaturesTest

