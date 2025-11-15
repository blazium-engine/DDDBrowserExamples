local ImGuiTextBoxTest = {}

function ImGuiTextBoxTest:on_start()
    self.modalOpen = false
    self.tosAccepted = false
    self.interactionCount = 0
end

function ImGuiTextBoxTest:on_interact()
    self.interactionCount = self.interactionCount + 1
    
    if not self.modalOpen then
        -- Open ImGui textbox modal with ToS acceptance scenario
        local buttons = {"Accept", "Cancel"}
        local checkboxes = {
            ["I have read and agree to the Terms of Service"] = false,
            ["I agree to receive marketing emails"] = false
        }
        
        local tosText = "TERMS OF SERVICE\n\n" ..
            "1. You agree to use this service responsibly.\n" ..
            "2. You will not engage in any harmful activities.\n" ..
            "3. Your data will be handled according to our privacy policy.\n" ..
            "4. We reserve the right to modify these terms at any time.\n\n" ..
            "By clicking Accept, you acknowledge that you have read and understood these terms."
        
        if Engine and Engine.openImGuiTextBox then
            local success = Engine.openImGuiTextBox(
                "Terms of Service",
                tosText,
                buttons,
                checkboxes
            )
            
            if success then
                self.modalOpen = true
                print("Opened ImGui textbox modal for ToS acceptance")
            end
        end
    else
        -- Close modal
        if Engine and Engine.closeImGuiTextBox then
            Engine.closeImGuiTextBox()
            self.modalOpen = false
            print("Closed ImGui textbox modal")
        end
    end
end

function ImGuiTextBoxTest:on_update(dt)
    -- Poll for modal state if needed
    -- In a real implementation, callbacks would handle this
end

return ImGuiTextBoxTest

