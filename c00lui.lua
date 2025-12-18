-- c00lkidd UI Library

local UI = {}
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

function UI:CreateWindow(titleText)
    local gui = Instance.new("ScreenGui", lp.PlayerGui)
    gui.Name = "c00lkiddUILib"

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 450, 0, 330)
    main.Position = UDim2.new(0.05,0,0.15,0)
    main.BackgroundColor3 = Color3.fromRGB(0,0,0)
    main.BorderColor3 = Color3.fromRGB(255,0,0)
    main.BorderSizePixel = 3
    main.Active = true
    main.Draggable = true

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,0,0,35)
    title.Text = titleText
    title.BackgroundColor3 = Color3.fromRGB(0,0,0)
    title.TextColor3 = Color3.fromRGB(255,0,0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20

    local tabBar = Instance.new("Frame", main)
    tabBar.Size = UDim2.new(1,0,0,30)
    tabBar.Position = UDim2.new(0,0,0,35)
    tabBar.BackgroundTransparency = 1

    local pages = Instance.new("Frame", main)
    pages.Size = UDim2.new(1,0,1,-65)
    pages.Position = UDim2.new(0,0,0,65)
    pages.BackgroundTransparency = 1

    local tabIndex = 0
    local currentPage

    local Window = {}

    function Window:CreateTab(name)
        tabIndex += 1

        local btn = Instance.new("TextButton", tabBar)
        btn.Size = UDim2.new(0, 110, 1, 0)
        btn.Position = UDim2.new(0, (tabIndex-1)*115, 0, 0)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
        btn.BorderColor3 = Color3.fromRGB(255,0,0)
        btn.TextColor3 = Color3.fromRGB(255,0,0)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14

        local page = Instance.new("Frame", pages)
        page.Size = UDim2.new(1,0,1,0)
        page.Visible = false
        page.BackgroundTransparency = 1

        btn.MouseButton1Click:Connect(function()
            if currentPage then currentPage.Visible = false end
            page.Visible = true
            currentPage = page
        end)

        if not currentPage then
            page.Visible = true
            currentPage = page
        end

        local y = 10
        local Tab = {}

        function Tab:AddButton(text, callback)
            local b = Instance.new("TextButton", page)
            b.Size = UDim2.new(0, 400, 0, 30)
            b.Position = UDim2.new(0, 25, 0, y)
            b.BackgroundColor3 = Color3.fromRGB(25,25,25)
            b.BorderColor3 = Color3.fromRGB(255,0,0)
            b.Text = text
            b.TextColor3 = Color3.fromRGB(255,0,0)
            b.Font = Enum.Font.Gotham
            b.TextSize = 16
            b.MouseButton1Click:Connect(callback)
            y += 35
        end

        function Tab:AddInput(placeholder, callback)
            local box = Instance.new("TextBox", page)
            box.Size = UDim2.new(0, 400, 0, 30)
            box.Position = UDim2.new(0, 25, 0, y)
            box.BackgroundColor3 = Color3.fromRGB(15,15,15)
            box.BorderColor3 = Color3.fromRGB(255,0,0)
            box.PlaceholderText = placeholder
            box.Text = ""
            box.TextColor3 = Color3.fromRGB(255,0,0)
            box.Font = Enum.Font.Gotham
            box.TextSize = 16
            box.FocusLost:Connect(function(enter)
                if enter then callback(box.Text) end
            end)
            y += 35
        end

        function Tab:AddToggle(text, default, callback)
            local state = default

            local holder = Instance.new("Frame", page)
            holder.Size = UDim2.new(0, 400, 0, 30)
            holder.Position = UDim2.new(0, 25, 0, y)
            holder.BackgroundColor3 = Color3.fromRGB(25,25,25)
            holder.BorderColor3 = Color3.fromRGB(255,0,0)

            local label = Instance.new("TextLabel", holder)
            label.Size = UDim2.new(0.7,0,1,0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(255,0,0)
            label.Font = Enum.Font.Gotham
            label.TextSize = 16

            local toggle = Instance.new("TextButton", holder)
            toggle.Size = UDim2.new(0.3,-5,1,-6)
            toggle.Position = UDim2.new(0.7,0,0,3)
            toggle.BackgroundColor3 = state and Color3.fromRGB(150,0,0) or Color3.fromRGB(10,10,10)
            toggle.Text = state and "ON" or "OFF"
            toggle.TextColor3 = Color3.fromRGB(255,0,0)
            toggle.Font = Enum.Font.GothamBold
            toggle.TextSize = 14

            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = state and "ON" or "OFF"
                toggle.BackgroundColor3 = state and Color3.fromRGB(150,0,0) or Color3.fromRGB(10,10,10)
                callback(state)
            end)

            callback(state)
            y += 35
        end

        return Tab
    end

    return Window
end

return UI
