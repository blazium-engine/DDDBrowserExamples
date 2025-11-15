local TextBoxTest = {}

function TextBoxTest:on_start()
    self.textboxOpen = false
    self.interactionCount = 0
end

function TextBoxTest:on_interact()
    self.interactionCount = self.interactionCount + 1
    
    if not self.textboxOpen then
        -- Open textbox with quest acceptance scenario
        local buttons = {"Accept Quest", "Decline"}
        local checkboxes = {
            ["Remember my choice"] = false,
            ["Show hints"] = true
        }
        
        local callbackRef = nil
        if Engine and Engine.openTextBox then
            -- Create callback function
            local function onTextBoxResult(button, checkboxStates)
                print("TextBox result: button=" .. tostring(button))
                for name, checked in pairs(checkboxStates) do
                    print("  Checkbox '" .. name .. "': " .. tostring(checked))
                end
                
                if button == "Accept Quest" then
                    print("Quest accepted!")
                elseif button == "Decline" then
                    print("Quest declined.")
                end
                
                self.textboxOpen = false
            end
            
            -- Note: In actual implementation, callback would be passed as Lua function reference
            -- For now, we'll open without callback and handle via polling
            local success = Engine.openTextBox(
                "quest-textbox-" .. tostring(self.entity),
                "Quest: Find the Lost Artifact",
                "A mysterious artifact has been discovered. Will you help recover it?\n\nRewards:\n- 100 Gold\n- Rare Item\n- Experience Points",
                buttons,
                checkboxes
            )
            
            if success then
                self.textboxOpen = true
                print("Opened textbox for entity " .. tostring(self.entity))
            end
        end
    else
        -- Close textbox
        if Engine and Engine.closeTextBox then
            Engine.closeTextBox("quest-textbox-" .. tostring(self.entity))
            self.textboxOpen = false
            print("Closed textbox for entity " .. tostring(self.entity))
        end
    end
end

function TextBoxTest:on_update(dt)
    -- Poll for textbox state if needed
    -- In a real implementation, callbacks would handle this
end

return TextBoxTest

