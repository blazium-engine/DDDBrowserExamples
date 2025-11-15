local UrlModalTest = {}

function UrlModalTest:on_start()
    self.modalOpen = false
    self.interactionCount = 0
    self.testUrls = {
        "https://www.example.com",
        "https://github.com",
        "https://blazium-engine.github.io"
    }
    self.currentUrlIndex = 1
end

function UrlModalTest:on_interact()
    self.interactionCount = self.interactionCount + 1
    
    if not self.modalOpen then
        -- Open external URL modal
        local url = self.testUrls[self.currentUrlIndex]
        if not url then
            self.currentUrlIndex = 1
            url = self.testUrls[1]
        end
        
        if Engine and Engine.openExternalUrl then
            local function onUrlResult(accepted)
                if accepted then
                    print("User accepted opening URL: " .. url)
                else
                    print("User declined opening URL: " .. url)
                end
                self.modalOpen = false
            end
            
            -- Note: In actual implementation, callback would be passed as Lua function reference
            local success = Engine.openExternalUrl(url)
            
            if success then
                self.modalOpen = true
                print("Opened URL modal for: " .. url)
                
                -- Cycle to next URL for next interaction
                self.currentUrlIndex = self.currentUrlIndex + 1
                if self.currentUrlIndex > #self.testUrls then
                    self.currentUrlIndex = 1
                end
            end
        end
    else
        -- Modal should close via user interaction (accept/decline)
        -- This is just a fallback
        self.modalOpen = false
    end
end

function UrlModalTest:on_update(dt)
    -- Poll for modal state if needed
end

return UrlModalTest

