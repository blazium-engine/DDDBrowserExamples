local AudioTest = {}

function AudioTest:on_start()
    self.audioPlaying = false
    self.ambientPlaying = false
    self.loopingPlaying = false
    self.interactionCount = 0
end

function AudioTest:on_interact()
    self.interactionCount = self.interactionCount + 1
    
    if not self.audioPlaying then
        -- Play spatial audio at entity position
        if Engine and Engine.playAudio then
            local pos = {0, 0, 0}  -- Will use entity position
            local success = Engine.playAudio(
                "spatial-audio-" .. tostring(self.entity),
                "test-audio",
                pos,
                false,  -- not ambient (spatial)
                false,  -- not looping
                0.8     -- volume
            )
            
            if success then
                self.audioPlaying = true
                print("Started spatial audio playback")
            end
        end
    else
        -- Stop spatial audio
        if Engine and Engine.stopAudio then
            Engine.stopAudio("spatial-audio-" .. tostring(self.entity))
            self.audioPlaying = false
            print("Stopped spatial audio")
        end
    end
    
    -- Toggle ambient audio
    if not self.ambientPlaying then
        if Engine and Engine.playAudio then
            local pos = {0, 0, 0}
            local success = Engine.playAudio(
                "ambient-audio-" .. tostring(self.entity),
                "test-audio",
                pos,
                true,   -- ambient (constant volume)
                true,   -- looping
                0.5     -- volume
            )
            
            if success then
                self.ambientPlaying = true
                print("Started ambient looping audio")
            end
        end
    else
        if Engine and Engine.stopAudio then
            Engine.stopAudio("ambient-audio-" .. tostring(self.entity))
            self.ambientPlaying = false
            print("Stopped ambient audio")
        end
    end
end

function AudioTest:on_update(dt)
    -- Audio playback is handled by the audio system
end

return AudioTest

