--==================================================
-- UJAYY | RIDE A PET | ROBLOX  —  V1.0.5 (Free)
-- Author: Xnowplee | discord.gg/6byStpCzv
-- UI: Ujayy UI v2 | Logic: ported from p.lua
--==================================================

local Ujayy = (function()
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Ujayy = {}
Ujayy.__index = Ujayy
Ujayy.Version = "2.0.0"

local LOGO_B64 = [=[
iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAVZUlEQVR42u1daZBdxXX++r032jXaBRJIKARkBRLJIAnJsjEYE8RS
IakshjgmIQ7lmD9JqgLIThxnKQQBCltJKjgJTihANgKFxRJoNRghBAnggGMWASZCC2CxC5VlNPPe+/Lj9fEcte+7t/sub5mZWzU1
y5t7b/f5vrP06dPdwPA1fA1fQ/cyeT6MpAFQavJsypcxhsOibyo/o2RnHPkBQD1P+ZkcGl2yoNd8G0ayXERnuhj4MgBjjKkGEKVs
5VdvCwEs8EdoM8kZAE4AMBHAPCEGgNcB7AewB8Crxph+dU8lhDyDDXhjTM0BdiaAuQCOBjAHwEgAhwG8AOBtAC8bY/a7ViMtEUxK
M1WShpM8FcC59ms+gAkxtx8GsBfADgD3AthkjDkshMrK5i4C/gjlIXkGgAsAnAdgNoDemNvfB/ADAN8FsM4Y87/KihRrUZXpBskl
JO8nWeeRV41klWS/+qrav7vXSyQvk+fq5w9ycy8/f4bkExFyaSZDV9ZVkutILo16fiENJ3kUyVudxjRroHvVVec0IR4nuVjeY63M
oAvwrOaD5CKS2xzA++13HxkKOfR1M8nJhZDA+mmQPJPkLqchWa6a6kg/ycvFRA4mEjjg/4nqczPLGHJpxfsRyUUaszw1/zL1on7m
e+lOrBpMJJB+WMv2bzkqj3sJJgdInpULCRT4X3B8UxFXXXVi9WAggQP+3QqoekEyFGz6SF6UyR0o8C+I0NIkHy8xQVX5q6pnx4UE
37IC7EoSKPBH2EBNgGGAj5e4oBZAGvnfD5U7KKVt/GyS7yhgfdgXYu59SGC0D+0y8EeSXO/pNn3cQt2TCPKcXSQnxSmRiUtQkLwD
wMUAqgCa+ROqZ1UBPA1gG4BXAHxg8wLHAlgK4BMARkgWUKWNo65+AD0A1gD4nP1/0+m5AhnjW3mts/kR6Uuzq2YzezLOfw7AE7bP
CwFMAjDNJom03OMso2D278aYy9ykk4/pP8eDudoqfJPk/IRnn0jyX9R9NU9L8B2SlU63BI7Zf8DT7FdV8PZXJGc6zzyN5AqSa0m+
av+vHmhtF3jHA2q4siPBtAt4b5I83xnyVOxXWf1cUv+zjOTLnqZRBPgAyZ5UPq11mg+SPSQ3evZNPt9G8iNRMrS//wLJj1si3GTJ
8KxyC0nPv9OLAEr7T03w+xJovEPyo6rjJQ8NkU7NIbkzUFAbSY7oNBIo8EeQ3BTYp++QHCnDNtdX69/t56NIziD5hyT/J4EEEjMc
InlMotwUOKsSOiEEOE86njKxdAzJHwRagk1W0B3hDhT4IxX4fZ59Waf6UvZJJKm/zSZ5g02nx5FA5LoiNjcgTLMvezbGR1edsXpP
xmHmNJLPB5JgQyeQwAH/IU/w+5VLGxnaB/l/2/8LSH5NjdTqMXhtjrUAqjMzSB6MYZUkbE7KCoAzv/BoIAnWt5MEzlBvYyD492WJ
Z5SyTiX5WZJ3JuBFkm+RHOe6lSgwzvLQ/u1NH5SeBONJPtYNlsCJ9kPBvyevEY19xniSp9vETxwJ6iQXNg0GFRAXxkT/0okbJVLN
eb5hmgpsqgGBYctGBymjfSHHWpntzKOtkiSzP/9rTFtElme7BChFJIVOchI8UYmjvbnWpTWSTiVjzFsAzgDwfZsYiSuRqtjPzwWw
nuQIY0y9SBJI0YoNetfbd8clySQh0wNgLYDflQROHgkti4GMHA573DLdTQBGCSuuGkVufDKGJGk7U7cCPgjgbEuCigcJ+gEsB7DO
DqdYBAkU+CNthm+5fXclIZtZAXC3Bb8mfc2xaVJOd0xcdtdeU9w/lJo0OumaUYSGKRK8D+DTaJSOJZGgR5HgPgA9eVsCBf5Y+47l
Huld0fx7AVxURCqbpLHtOhnAcR4EqPoQ4IWYB0njF6sS5qJIcACNGrkQEpwLYAPJiXmRwObQ6yTHA9jgmdsXt7AGwG+L3AoAn9Yi
LQEw1uO2va7lLkVM6rzr4QJOtGanXrAlOBhIgqq1HJtJTs5KAtuGmgV/LYBPeoAvZv8eAJ9VPr+oYs3jrfmfEaO48ref+ES3H7FD
irjhxEE7djdFB132e6+am/BNse4gOTHDWFvePZ3k9sB3r5P5j6Lko6L/T5G8yyMP8AHJ6XF5AHlgOSG9KEOKlVkygSmAGJ+CBNvS
zB2od44h+UzgUO/+NBm+DLmIk0ju9sjdPJ6Yu1E5+m/HdFomiQ6RnOc9zZgPCcYFZAz79dyBLwmapHd9wb+vVTkJhdXFCVPr0vbr
Y+cCnITMRZ5TwU9Y/9iKDmsSbA8EZivJCUla2SS96/uO/2xVzYLCaTbJ1xNKxqSk7FSf2UBxA6NI7k2YEhZyPNoGEoxPYQli3UHK
9K58vlqVrpkWyaDXrqdgAkZ1ko9646NMy194CLi/S0jQF5c2bpLe9c3tr1bFq+3oe9Wj2ui8RPMfMd04wQaDSQWhmgTj2kCC0MBQ
F5WUnWKOULO/Rsusw+Igv2ngBB9zYaBwO50EfW5gqMDfFKj531LKYjoMfPH7b5M8LhVBlSu4JlAwO9oUGD4SSNYtJI+34/wtgffe
0Qaf70t0XV5+fupRmlrRUklR5LiDZG8bSOAbE4iA3iG5J3D6+Q4ln1YGfL7gy+dXePv9BBKkLXzo9MCw1uTnuD6taXPA5wv+VZnB
bzI82tAFJOgNIEE9BfimS8DvybVBGerf/ptFrVvPJzD0CRrvaEOSZ1xHgJ+TJcg0MZOBBNsykCBK8zst2q97l33n3MA0CyCeaoM7
GBvgDqLafFsbhnrjUwR8VxUOfkLWLGR00M7AsC/A7K9u1fL0rgE/Y968U0YHfT6a34YMX3uj/RYHhu0iwfdiBOyCXxpy0X4bSDCu
xaODsXYxpitoafM/qDmCos1+Z0b7GYQbsjiynXMHI5zRQZ+T3i11eLTfPrPvKdwsgWG5RRZrtKr2oa2pq3RBbr/zwE8YHfhagsdJ
Tm2xOxhJ8rskb2nTxM72QM2/smPBj9CwHrsOLsQSPMnGZtOtJIHetrUdZr+va82+BwlKNosWQoLH1E4WRZPAtAn87V0b8IWSwP58
ayAJniM5pUWBoemSgK97wHeEK52/OcUE0vRWWIIOHOdXu87sJ5CgnIEELUkWDad3W2cJbkhRYzil20iQMcP31a41+54k+FslEJ89
7p7pJkvggP9IWp/PwXZmguMOvhZIgpZlDIczfMWTQBZmrBhMJHDmG7YPmWg/pbDEElwVSIIdnegOUph9HQz/zZACXwmtZzCQIOMq
pX8Ws89BeE6SjzuopCTBo51AgpQBX7XVU8/dZgmqAUPEtpEgxcSO7tvVw+AfKcyKExiGkKDlgWHG1UgrhsGPFqqs2L22k0nggL8t
0Odfq/s6fCmhqkKNrZ4rdpq5g3ILwA9deCIbNay3fTTdmN4uWqi6pCzkMMWoBanlDgLfXX+4iS3YRKrbwB8VUEqWlDY+Pm8SpFx8
mrhJxZAmgSPUhzII1RXubpK/lFdMkCP4XtvVDDXwpwZG0b6B4T5VY5hlp1DZI6E3sJ2+K443DTlL4FQQ+x6zUnOSKb6BYU+W4ZYa
nt6Vop01T0swdEjgmNPQ8vGb1VRy0umj7rCrnKKtMl9xpWcBp1inW0k+GDgf0JGnoeUNvgh0oho/+1YHrVTPuUppmA8JloWSgAOn
eiy0bYwjXNSsni7+9N1rcKt1NYPPEijwJ7Cxu2iIdsiexBUVNP2phyWQz3aErPJ1ilce80hKRU7ppkwUbR507kAJcxb9Nl6uu5qv
Z8uUX748AJyL9b2eZL3Eo63NwNfb1WwLtASDZ3SgBDGF5PcDteHnwE8xgSRW4CnfEnC1puF5xp/o/bMdRKLamXGauPsDQyWA0fTf
cr3fmS1rOk+uLMF/JJBAYoXTk2IBpf1n2PuqCRM7T9okVmQ7A5amR8ngIQ4cKVvqVvBHpthKJhF8Z4w+nuSumPkDee6tSW5Akeq2
mDbLez6kPS2dCTuQq/48EBj/bLH96x5L4NTGfa8I8CMA+4MYKyBB4pskJwl5ogil8hO7Y3IO8o7rA+IKvaPK/YExwZaumTtQw6eJ
KYZBK0PAV1ZATs/8sQdo5zRzA8r8L43J5smROe+zccilNygZSXDEBtedPtTrIflw2mg/w3tXeWz/0vQ9ypr8dcxzqo47Kae0jqNT
rJ7eWORsZ17gz0xh9oM1v4nVOTsmBVtVQozUWtWHO2PaL89ezoQj3z1IUCL5zUBZ/VerVk+nBf+HrQTf8d2T2DghO4oE8vur7n3O
MwzJV5o8Q8z/ByRnZYnOnWRT6BL6H7FFZzWFsHkyyWfTpHezlkTzyNPO9sWAR+u7fw48nWQi+WoCiV7WhMkiO2W9bg+U3d4i6h7S
av5RJJ/OkN41GduhCbAzxg3I3z7uCk715ZSY9LL07fa05j8m6VQmebcnCcSd7SI5M23sJFdaE1a2J2pOQOM41Y8i/hRtYuDEzWuM
MX9pG13LeqKmPT61ZIypAXhFva9ZO2oxjxuDxqnlcW06bNucuaJX9b2OxuHSt1gZxbVRTlWfA+Bekr3GmGpaQqY5UbNiwZ8FYDuA
U5F8hHqtCPBFi+wRsWUAs0W2zWSe0Gefo3CreVpSOU/YGNNnjPk8gG9YkONIULGfnwbgEZLHWUzKrTL7M+1WLi0N+BJcQMn6xrhi
jBrJBRExgMQyJ5D8aZN8gpjeh1nALqLOSqmbAt3BPpWVrBQFvjRuPsn/S5vhK6BdQoCpHqOAPSRHxYwCyta3xj3jdaUIpkASXBso
4zfZOEY+fzk74L8ZuHDj6iI0P8Iqne4RAO6KiuAdK/JSwjDwEMm5RU3SOPso/H3gqqMf5z5EVI2ZT3K/J/h9RZr9JuT8skcmcG2z
CF4953aPTOAfaW0tmARXB5LgpdySRaoRv+IJfr1onx/jAn4YYwGkTV/xSAV/1YMAjxQ9Teu4g68HkuAFkkdnaqOavJhO8rVAs98q
8IWgn/GoCaiSXNRMKCoQXJhQ2i2HMi4tOhGTMjDUm26OYprNr+XF9uYHOyHaj0mi9NjsXJL/f54xG0KrmcWK/d+keYVthUbd0e7g
2sBZxLWpSKpe+GdFzudnFIyUhf1dgva7JeI+BSFJEbi86wrdlhaRwNcdCAkuDSKBMv2/TPIg/XftaAf4X0gQhlTvHCJ5QpJPVG5g
rq34qTfpu9QK/lSVnbfSEvjMIkop3LvWjftti6teck9AVezKFoIvWnq+BSmpNJwk7/bVAtX/ez3IVSd5gOTCNpBgVRp8fGf35tqb
ax7CXdkGzf+0als9YbVOleQC3wkcNUN3mgoek2TwGskT20CCf/Ik6bscOLfR+GjXVzx94F1t0PyP2WndpE0kxAeuCg2EAgSsZfGK
cjPlFpIgaU8FaftliQS17NeRfzXGt+yzdQCtOF1LwF9mTW7S4ktp97N2hU7QAlGn4vhFjyGwJsHcFpFAYrUpJN9IqIquW5fePHml
Eirj2ThWPanA8ostMnka/IMe4AtB3yN5StpkiHKHi2wVUNKC1Kqq2JndIhKIbL7oURW9R7lQE2f2PhnDJl1ZM5kFH7igOnimp+aL
zzvssxAk4P2/52hTEgleJDmnaAVRuYsJCUpbsy5xYVOFUAT4tRg2ub6/yFSolEFfqN6bBL50dHlewmf4ZpZVVbZ1cgtIILh92wO3
812l0ACKJi+RZ0e9z37fbTW/VJTmG2P67Bj7Nvueesz7pNKnBOASY8xm+4zMxRu22qZijLkewAoMFGM0K2aRYo5jATxIcpE8I4Uc
vJposXgtBje5+tw/RAl0isdL9+dRzRMDfpXkpwBsBDDBdioJ/AqAK4wxd5LsyQN8hwQ9KUhwFIANJE9LQwJjjBcRPErU5AHzHGWP
FKqPVhcFftkK6hMAHgDQ66n5FQBfMsbcaAnUn3fbjDH9yhJ8yb6z7kGCaQA2kVzgSwIBnOQRPzcJ4KQcbpYLrs8VJdi9HvcdXUA1
jNQaXgpgC4DRAeCvMMZcl5fZ93AH11lLkFS7J59PArCV5OK07kDA15ZX6iEt6DNiCCB/e7GpAqtg4hyPYGJNnsMcNTz5DSeg86k7
aPlJGyowvNLZhyBuaEo7nFzq216xAM1cgBoFTFP5irgZzPOa4qYIcKbHMHA/yTF5DAOdcf7bar69I8HPYXTwBsnFebTbGbnFpe1r
tn2nxA0DJRHUa3PHSYmg38/aCaX5ywLG+R1zzArDD73QliBxFjFO+51s4P0JmVuph6zEzgdwYDOlhz1SwTvtKtdU+/A5uf0DAeN8
kvzzdoOfgQQi0wMkP5a2H+q9S9TEHWNSwat95gIElGs8J4NuVHMIZc+G6zKnX7fa4AO++Nk/bpfZz9EdRFqCgH0R5H09HNjBNGk7
m9/0IYDkv2fbYoe6x1ToDbphzSyCtSwV9fuXIwSSpPmf6zTwY0jgO3fwAckzIybkSirI02sIBaNfZGNbuaRaSJm4G+sVs6nA4ibP
qhPaKclTPAU1mQPnBiYJSe/SdUmngh8zOvC1BP1WIXo93/N5z/UZ7mmkFZ+HC/OOtaVUvkz+0K51P4v2uFfnuSfZGvd9Hlrvgn9p
p4OfwR3oz/aS/Ibd7GKBneqdysYeQfNIXqrm/5PAl9HUHrt3gn91sLICKwPr0amGiTvt2HSn/ap5Nrzjov0WBIZRw+5DVo5v2arn
wxGznj5FoRcF52xUQUQP/bc7rTN5q/R+j4YPiuNUU5BAj9drMYqWpDwa/FtSy8/JC7zgSQKX0fqr7nlfvdvBzxAYRsmiHiA/d2FI
b6qFIRGuQC8KzXJaho8bqZK8vNvBjwkM6anFaS7R/PxOV1UkOJmNPXeZYKZCL23y3yd57mABP4IEv2X76OsSQpSnqsDvzQX8CBL0
cmB/O/3iNB2pOdbkKVWyNOgOUlYkWMSBvZOzKFM9Iib4R5JjcwXfTRLZn39HrZ/THel36vVdP9Yf4ULes5nH0YNN82NIMNqOsN6L
sITVJvKLk+FmW0CD2Fx/Dh3Q+9uNsgmJbR6LFaOu50heJ8WThbC2M0mgFWmOJcJzKeT3E5LrpM5PZRGDwE+7OWPZ7solv88D8KsA
FgNYikYlDwBMRqMg4gAa9WiPAXgZwHoAT0vljnUx9aLKzDqQBAaA7GwmLm8JgLMAzAewDI1CmBFo7Fz2nr31bQDPANgGYKsxZnfU
8wongH6pC5w1cz322bPQ2B7uDft/hyNiC8pOWUPtstag5FYxkRyDRtXOGDSqiaTg80NH1iUAJg3wmQkQ1RE0WlNNCCaN7dyQ0fgA
ZTJWIWpJcYSVX2bFMQV1xn0+LTmGAU8nw5/JbViGw9fwNXzld/0/jxpEID9ABxoAAAAASUVORK5CYII=
]=]

local function makeTheme(h, s, accentSat)
	return {
		Background = Color3.fromHSV(h, s, 0.13),
		Sidebar    = Color3.fromHSV(h, s, 0.10),
		Element    = Color3.fromHSV(h, s * 0.9, 0.21),
		Banner     = Color3.fromHSV(h, s, 0.26),
		Accent     = Color3.fromHSV(h, accentSat, 1),
		Stroke     = Color3.fromHSV(h, accentSat * 0.9, 0.62),
		Text       = Color3.fromRGB(240, 244, 255),
		SubText    = Color3.fromRGB(165, 175, 200),
	}
end

local Themes = {
	Dark   = makeTheme(0.00, 0.00, 0.00),
	Blue   = makeTheme(0.59, 0.85, 0.85),
	Purple = makeTheme(0.76, 0.75, 0.75),
	Red    = makeTheme(0.00, 0.85, 0.80),
	Green  = makeTheme(0.33, 0.85, 0.80),
	Orange = makeTheme(0.08, 0.85, 0.90),
}
Themes.Dark.Accent = Color3.fromRGB(230, 230, 235)
Themes.Dark.Stroke = Color3.fromRGB(95, 95, 100)
Ujayy.Themes = Themes
Ujayy.ThemeNames = { "Dark", "Blue", "Purple", "Red", "Green", "Orange" }

local function create(class, props, parent)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do inst[k] = v end
	if parent then inst.Parent = parent end
	return inst
end

local function corner(parent, r)
	return create("UICorner", { CornerRadius = UDim.new(0, r) }, parent)
end

local function stroke(parent, thickness, transparency)
	return create("UIStroke", {
		Thickness = thickness or 1,
		Transparency = transparency or 0.45,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, parent)
end

local function padding(parent, l, t, r, b)
	return create("UIPadding", {
		PaddingLeft = UDim.new(0, l), PaddingTop = UDim.new(0, t),
		PaddingRight = UDim.new(0, r), PaddingBottom = UDim.new(0, b),
	}, parent)
end

local function listLayout(parent, pad)
	return create("UIListLayout", {
		Padding = UDim.new(0, pad or 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, parent)
end

local function tween(inst, t, props, style, dir)
	local tw = TweenService:Create(inst, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function safe(cb, ...)
	if type(cb) == "function" then
		local ok, err = pcall(cb, ...)
		if not ok then warn("[Ujayy] callback error: " .. tostring(err)) end
	end
end

local function fire(list, ...)
	for _, fn in ipairs(list) do safe(fn, ...) end
end

local function iconId(icon)
	if type(icon) == "number" then return "rbxassetid://" .. icon end
	if type(icon) == "string" then
		if icon:find("^rbxasset") or icon:find("^http") then return icon end
		if icon:match("^%d+$") then return "rbxassetid://" .. icon end
	end
	return nil
end

local function getGuiParent()
	local ok, hui = pcall(function() return gethui and gethui() end)
	if ok and hui then return hui end
	local ok2, core = pcall(function() return game:GetService("CoreGui") end)
	if ok2 and core then
		local fine = pcall(function()
			local t = Instance.new("Folder")
			t.Parent = core
			t:Destroy()
		end)
		if fine then return core end
	end
	return Players.LocalPlayer:WaitForChild("PlayerGui")
end

local function b64decode(data)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local lookup = {}
	for i = 1, #chars do lookup[chars:sub(i, i)] = i - 1 end
	local out, n = {}, 0
	local buf, bits = 0, 0
	for i = 1, #data do
		local v = lookup[data:sub(i, i)]
		if v then
			buf = buf * 64 + v
			bits = bits + 6
			if bits >= 8 then
				bits = bits - 8
				local p = 2 ^ bits
				local byte = math.floor(buf / p)
				buf = buf % p
				n = n + 1
				out[n] = string.char(byte)
			end
		end
	end
	return table.concat(out)
end

local logoCache
local function getLogo(custom)
	if custom and custom ~= "" then return iconId(custom) or custom end
	if logoCache ~= nil then return logoCache or nil end
	local ok, res = pcall(function()
		assert(type(writefile) == "function" and type(getcustomasset) == "function")
		if type(makefolder) == "function" and type(isfolder) == "function" and not isfolder("Ujayy") then
			makefolder("Ujayy")
		end
		local path = "Ujayy/logo_v2.png"
		if not (type(isfile) == "function" and isfile(path)) then
			writefile(path, b64decode(LOGO_B64))
		end
		return getcustomasset(path)
	end)
	if ok and res then logoCache = res else logoCache = false end
	return logoCache or nil
end

local function bind(win, inst, prop, key)
	table.insert(win._bindings, { inst, prop, key })
	inst[prop] = win.Theme[key]
end

local function track(win, handle, onBegin, onMove, onEnd)
	local active = false
	handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			active = true
			if onBegin then onBegin(i) end
			local conn
			conn = i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					active = false
					conn:Disconnect()
					if onEnd then onEnd(i) end
				end
			end)
		end
	end)
	table.insert(win._connections, UserInputService.InputChanged:Connect(function(i)
		if active and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			if onMove then onMove(i) end
		end
	end))
end

local function mkLabel(win, parent, props, key)
	local l = create("TextLabel", {
		BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 14, Text = "",
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
	}, parent)
	for k, v in pairs(props or {}) do l[k] = v end
	bind(win, l, "TextColor3", key or "Text")
	return l
end

local function logoNode(win, parent, props, key)
	props = props or {}
	local alpha = props.Alpha
	props.Alpha = nil
	local node
	if win.LogoImage then
		node = create("ImageLabel", {
			BackgroundTransparency = 1, Image = win.LogoImage, ScaleType = Enum.ScaleType.Fit,
			ImageTransparency = alpha or 0,
		}, parent)
		for k, v in pairs(props) do node[k] = v end
		bind(win, node, "ImageColor3", key or "Accent")
	else
		node = create("TextLabel", {
			BackgroundTransparency = 1, Text = "X", Font = Enum.Font.GothamBlack,
			TextScaled = true, TextTransparency = alpha or 0,
		}, parent)
		for k, v in pairs(props) do node[k] = v end
		bind(win, node, "TextColor3", key or "Accent")
	end
	return node
end

local function nextOrder(self)
	self._n = (self._n or 0) + 1
	return self._n
end

local function elHeight(cfg, base)
	if cfg.Desc then return base + 14 end
	return base
end

local function mkElement(self, height)
	local win = self.Window
	local f = create("Frame", {
		Size = UDim2.new(1, 0, 0, height), BorderSizePixel = 0, ClipsDescendants = true,
		LayoutOrder = nextOrder(self),
	}, self.Holder)
	corner(f, 8)
	bind(win, f, "BackgroundColor3", "Element")
	bind(win, stroke(f), "Color", "Stroke")
	local lock = create("TextButton", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.45, Text = "", AutoButtonColor = false,
		Visible = false, ZIndex = 20, BorderSizePixel = 0,
	}, f)
	corner(lock, 8)
	return f, lock
end

local function mkHeader(self, f, cfg, rightPad, topAlign, widthScale)
	local win = self.Window
	local title = cfg.Name or cfg.Title or "Element"
	local desc = cfg.Desc
	local w = widthScale and UDim2.new(widthScale, -12, 0, 18) or UDim2.new(1, -(12 + rightPad), 0, 18)
	local t
	if desc or topAlign then
		t = mkLabel(win, f, {
			Text = title, Font = Enum.Font.GothamMedium, TextSize = 14,
			Position = UDim2.fromOffset(12, 6), Size = w, TextTruncate = Enum.TextTruncate.AtEnd,
		})
	else
		t = mkLabel(win, f, {
			Text = title, Font = Enum.Font.GothamMedium, TextSize = 14,
			Position = UDim2.fromOffset(12, 0),
			Size = widthScale and UDim2.new(widthScale, -12, 1, 0) or UDim2.new(1, -(12 + rightPad), 1, 0),
			TextTruncate = Enum.TextTruncate.AtEnd,
		})
	end
	if desc then
		mkLabel(win, f, {
			Text = desc, TextSize = 12, Position = UDim2.fromOffset(12, 25),
			Size = widthScale and UDim2.new(widthScale, -12, 0, 16) or UDim2.new(1, -(12 + rightPad), 0, 16),
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, "SubText")
	end
	return t
end

local function finishObj(obj, f, lock, win, cfg)
	obj.Frame = f
	function obj:Lock() lock.Visible = true end
	function obj:Unlock() lock.Visible = false end
	function obj:SetVisible(v) f.Visible = v end
	function obj:Destroy() f:Destroy() end
	if cfg.Locked then lock.Visible = true end
	if cfg.Flag then win.Flags[cfg.Flag] = obj end
	return obj
end

local function makeBar(win, parent, y, onChange)
	local hit = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, -24, 0, 22),
		Position = UDim2.fromOffset(12, y), Active = true,
	}, parent)
	local bar = create("Frame", {
		Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, -3), BorderSizePixel = 0,
	}, hit)
	corner(bar, 3)
	bind(win, bar, "BackgroundColor3", "Sidebar")
	local fill = create("Frame", { Size = UDim2.fromScale(0, 1), BorderSizePixel = 0 }, bar)
	corner(fill, 3)
	bind(win, fill, "BackgroundColor3", "Accent")
	local knob = create("Frame", {
		Size = UDim2.fromOffset(12, 12), AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0), BorderSizePixel = 0, BackgroundColor3 = Color3.new(1, 1, 1),
	}, bar)
	corner(knob, 6)
	local function set(rel)
		rel = math.clamp(rel, 0, 1)
		fill.Size = UDim2.fromScale(rel, 1)
		knob.Position = UDim2.new(rel, 0, 0.5, 0)
	end
	local dragging = false
	local startPos = nil
	local THRESHOLD = 10
	local function applyFromX(x)
		local rel = (x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1)
		rel = math.clamp(rel, 0, 1)
		set(rel)
		onChange(rel)
	end
	bar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startPos = Vector2.new(i.Position.X, i.Position.Y)
			applyFromX(i.Position.X)
			local conn
			conn = i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
					startPos = nil
					conn:Disconnect()
				end
			end)
		end
	end)
	table.insert(win._connections, UserInputService.InputChanged:Connect(function(i)
		if dragging and startPos then
			if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
				local cur = Vector2.new(i.Position.X, i.Position.Y)
				if (cur - startPos).Magnitude >= THRESHOLD then
					applyFromX(i.Position.X)
				end
			end
		end
	end))
	return set
end

local Container = {}
Container.__index = Container

function Container:CreateSection(arg)
	local cfg = type(arg) == "table" and arg or { Title = arg }
	local win = self.Window
	local opened = cfg.Opened ~= false

	local wrapper = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = nextOrder(self),
	}, self.Holder)
	listLayout(wrapper, 8)

	local head = create("TextButton", {
		BackgroundTransparency = 1, Text = "", Size = UDim2.new(1, 0, 0, 26),
		AutoButtonColor = false, LayoutOrder = 1,
	}, wrapper)
	local dot = create("Frame", { Size = UDim2.fromOffset(4, 18), Position = UDim2.fromOffset(2, 4), BorderSizePixel = 0 }, head)
	corner(dot, 2)
	bind(win, dot, "BackgroundColor3", "Accent")
	mkLabel(win, head, {
		Text = cfg.Title or cfg.Name or "Section", Font = Enum.Font.GothamBold, TextSize = 17,
		Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -40, 1, 0),
		TextTruncate = Enum.TextTruncate.AtEnd,
	})
	local chev = mkLabel(win, head, {
		Text = ">", Font = Enum.Font.GothamBold, TextSize = 16,
		Position = UDim2.new(1, -28, 0, 0), Size = UDim2.fromOffset(24, 26),
		TextXAlignment = Enum.TextXAlignment.Center, Rotation = opened and 90 or 0,
	}, "Accent")

	local body = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2, Visible = opened,
	}, wrapper)
	listLayout(body, 8)

	local sec = setmetatable({ Window = win, Holder = body, Frame = wrapper }, Container)
	function sec:SetOpened(v)
		opened = v and true or false
		body.Visible = opened
		tween(chev, 0.15, { Rotation = opened and 90 or 0 })
	end
	head.MouseButton1Click:Connect(function() sec:SetOpened(not opened) end)
	return sec
end

function Container:CreateDivider()
	local win = self.Window
	local w = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 10), LayoutOrder = nextOrder(self) }, self.Holder)
	local line = create("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0.5, 0), BorderSizePixel = 0, BackgroundTransparency = 0.5 }, w)
	bind(win, line, "BackgroundColor3", "Stroke")
	return { Destroy = function() w:Destroy() end }
end

function Container:CreateLabel(arg)
	local cfg = type(arg) == "table" and arg or { Title = arg }
	cfg.Title = cfg.Title or cfg.Name or "Label"
	local win = self.Window
	local f, lock = mkElement(self, elHeight(cfg, 34))
	local t = mkHeader(self, f, cfg, 12)
	local obj = {}
	function obj:Set(text) t.Text = text end
	return finishObj(obj, f, lock, win, cfg)
end

function Container:CreateParagraph(cfg)
	cfg = cfg or {}
	local win = self.Window
	local f = create("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0, LayoutOrder = nextOrder(self),
	}, self.Holder)
	corner(f, 8)
	bind(win, f, "BackgroundColor3", "Element")
	bind(win, stroke(f), "Color", "Stroke")
	padding(f, 12, 10, 12, 10)
	listLayout(f, 4)
	local title = cfg.Title or cfg.Name or ""
	local t = mkLabel(win, f, {
		Text = title, Font = Enum.Font.GothamBold, TextSize = 15, TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Visible = title ~= "", LayoutOrder = 1,
	})
	local c = mkLabel(win, f, {
		Text = cfg.Content or cfg.Desc or "", TextSize = 13, TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 2,
	}, "SubText")
	local obj = {}
	function obj:Set(n)
		if n.Title then t.Text = n.Title; t.Visible = n.Title ~= "" end
		if n.Content then c.Text = n.Content end
	end
	obj.Frame = f
	function obj:Destroy() f:Destroy() end
	return obj
end

function Container:CreateButton(cfg)
	cfg = cfg or {}
	local win = self.Window
	local f, lock = mkElement(self, elHeight(cfg, 38))
	mkHeader(self, f, cfg, 40)
	mkLabel(win, f, {
		Text = ">", Font = Enum.Font.GothamBold, TextSize = 18,
		Position = UDim2.new(1, -34, 0, 0), Size = UDim2.new(0, 24, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Center,
	}, "Accent")
	local btn = create("TextButton", { BackgroundTransparency = 1, Text = "", Size = UDim2.fromScale(1, 1) }, f)
	btn.MouseEnter:Connect(function() tween(f, 0.15, { BackgroundColor3 = win.Theme.Banner }) end)
	btn.MouseLeave:Connect(function() tween(f, 0.15, { BackgroundColor3 = win.Theme.Element }) end)
	btn.MouseButton1Click:Connect(function() safe(cfg.Callback) end)
	return finishObj({}, f, lock, win, cfg)
end

function Container:CreateToggle(cfg)
	cfg = cfg or {}
	local win = self.Window
	local state = (cfg.Default or cfg.Value) == true
	local f, lock = mkElement(self, elHeight(cfg, 38))
	mkHeader(self, f, cfg, 64)
	local rail = create("Frame", { Size = UDim2.fromOffset(40, 20), Position = UDim2.new(1, -52, 0.5, -10), BorderSizePixel = 0 }, f)
	corner(rail, 10)
	local knob = create("Frame", {
		Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
	}, rail)
	corner(knob, 7)
	local obj = {}
	local function render(animate)
		local col = state and win.Theme.Accent or win.Theme.Sidebar
		local pos = state and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)
		if animate then
			tween(rail, 0.15, { BackgroundColor3 = col })
			tween(knob, 0.15, { Position = pos })
		else
			rail.BackgroundColor3 = col
			knob.Position = pos
		end
	end
	table.insert(win._refreshers, function() render(false) end)
	render(false)
	function obj:Set(v, silent)
		state = v and true or false
		render(true)
		if not silent then safe(cfg.Callback, state) end
	end
	function obj:Get() return state end
	local btn = create("TextButton", { BackgroundTransparency = 1, Text = "", Size = UDim2.fromScale(1, 1) }, f)
	btn.MouseButton1Click:Connect(function() obj:Set(not state) end)
	if state then safe(cfg.Callback, state) end
	return finishObj(obj, f, lock, win, cfg)
end

function Container:CreateSlider(cfg)
	cfg = cfg or {}
	local win = self.Window
	local vr = type(cfg.Value) == "table" and cfg.Value or {}
	local min = cfg.Min or vr.Min or 0
	local max = cfg.Max or vr.Max or 100
	local inc = cfg.Increment or vr.Increment or ((vr.Decimals and vr.Decimals > 0) and 10 ^ (-vr.Decimals)) or 1
	local value = math.clamp(cfg.Default or vr.Default or min, min, max)
	local H = cfg.Desc and 70 or 56
	local f, lock = mkElement(self, H)
	mkHeader(self, f, cfg, 100, true)
	local function fmt(v)
		return tostring(math.floor(v * 10000 + 0.5) / 10000) .. (cfg.Suffix and (" " .. cfg.Suffix) or "")
	end
	local valLabel = mkLabel(win, f, {
		Text = fmt(value), Font = Enum.Font.GothamMedium, TextSize = 13,
		Position = UDim2.new(1, -100, 0, 6), Size = UDim2.fromOffset(88, 18),
		TextXAlignment = Enum.TextXAlignment.Right,
	}, "Accent")
	local setBar
	local obj = {}
	local function apply(v, silent)
		v = math.clamp(math.floor(v / inc + 0.5) * inc, min, max)
		v = math.floor(v * 10000 + 0.5) / 10000
		value = v
		valLabel.Text = fmt(v)
		setBar((v - min) / math.max(max - min, 1e-9))
		if not silent then safe(cfg.Callback, v) end
	end
	setBar = makeBar(win, f, H - 26, function(rel) apply(min + (max - min) * rel) end)
	function obj:Set(v, silent) apply(v, silent) end
	function obj:Get() return value end
	apply(value, true)
	return finishObj(obj, f, lock, win, cfg)
end

function Container:CreateInput(cfg)
	cfg = cfg or {}
	local win = self.Window
	local f, lock = mkElement(self, elHeight(cfg, 38))
	mkHeader(self, f, cfg, 0, false, 0.45)
	local box = create("TextBox", {
		Size = UDim2.new(0.55, -16, 0, 26), Position = UDim2.new(0.45, 4, 0.5, -13),
		Font = Enum.Font.Gotham, TextSize = 13, Text = cfg.Default or cfg.Value or "",
		PlaceholderText = cfg.Placeholder or "...", ClearTextOnFocus = false,
		BorderSizePixel = 0, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, f)
	corner(box, 6)
	padding(box, 8, 0, 8, 0)
	bind(win, box, "BackgroundColor3", "Sidebar")
	bind(win, box, "TextColor3", "Text")
	box.PlaceholderColor3 = Color3.fromRGB(120, 130, 150)
	if cfg.Numeric then
		box:GetPropertyChangedSignal("Text"):Connect(function()
			local clean = box.Text:gsub("[^%d%.%-]", "")
			if clean ~= box.Text then box.Text = clean end
		end)
	end
	box.FocusLost:Connect(function() safe(cfg.Callback, box.Text) end)
	local obj = {}
	function obj:Set(t, silent)
		box.Text = tostring(t)
		if not silent then safe(cfg.Callback, box.Text) end
	end
	function obj:Get() return box.Text end
	return finishObj(obj, f, lock, win, cfg)
end

function Container:CreateDropdown(cfg)
	cfg = cfg or {}
	local win = self.Window
	local options = cfg.Options or cfg.Values or {}
	local multi = cfg.Multi == true
	local current = multi and {} or nil
	local open = false
	local HEAD, ITEM = elHeight(cfg, 38), 28
	local f, lock = mkElement(self, HEAD)
	mkHeader(self, f, cfg, 160)
	local valLabel = mkLabel(win, f, {
		Text = "None", Font = Enum.Font.GothamMedium, TextSize = 13,
		Position = UDim2.new(1, -150, 0, 0), Size = UDim2.fromOffset(116, HEAD),
		TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
	}, "Accent")
	local chev = mkLabel(win, f, {
		Text = ">", Font = Enum.Font.GothamBold, TextSize = 16,
		Position = UDim2.new(1, -30, 0, 0), Size = UDim2.fromOffset(24, HEAD),
		TextXAlignment = Enum.TextXAlignment.Center, Rotation = 90,
	}, "Accent")
	local head = create("TextButton", { BackgroundTransparency = 1, Text = "", Size = UDim2.new(1, 0, 0, HEAD) }, f)
	local list = create("ScrollingFrame", {
		BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, HEAD),
		Size = UDim2.new(1, -16, 1, -HEAD - 6), CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
	}, f)
	listLayout(list, 2)
	local obj = {}
	local build
	local function isSel(opt)
		if multi then return current[opt] == true end
		return current == opt
	end
	local function listValue()
		if multi then
			local t = {}
			for _, o in ipairs(options) do
				if current[o] then table.insert(t, o) end
			end
			return t
		end
		return current
	end
	local function display()
		if multi then
			local t = {}
			for _, o in ipairs(options) do
				if current[o] then table.insert(t, tostring(o)) end
			end
			valLabel.Text = #t > 0 and table.concat(t, ", ") or "None"
		else
			valLabel.Text = current ~= nil and tostring(current) or "None"
		end
	end
	local function resize()
		local listH = math.min(#options, 6) * (ITEM + 2)
		tween(f, 0.18, { Size = UDim2.new(1, 0, 0, open and (HEAD + listH + 8) or HEAD) })
		tween(chev, 0.18, { Rotation = open and -90 or 90 })
	end
	build = function()
		for _, c in ipairs(list:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		for idx, opt in ipairs(options) do
			local b = create("TextButton", {
				Size = UDim2.new(1, -4, 0, ITEM), BorderSizePixel = 0, AutoButtonColor = false,
				Font = Enum.Font.Gotham, TextSize = 13, Text = tostring(opt), LayoutOrder = idx,
				TextTruncate = Enum.TextTruncate.AtEnd,
			}, list)
			corner(b, 6)
			bind(win, b, "BackgroundColor3", "Sidebar")
			bind(win, b, "TextColor3", isSel(opt) and "Accent" or "Text")
			b.MouseButton1Click:Connect(function()
				if multi then
					if current[opt] then current[opt] = nil else current[opt] = true end
					build()
					display()
					safe(cfg.Callback, listValue())
				else
					obj:Set(opt)
					open = false
					resize()
				end
			end)
		end
	end
	function obj:Set(v, silent)
		if multi then
			current = {}
			if type(v) == "table" then
				for _, x in ipairs(v) do current[x] = true end
			end
		else
			current = v
		end
		build()
		display()
		if not silent then safe(cfg.Callback, listValue()) end
	end
	function obj:Refresh(newOptions, keep)
		options = newOptions or {}
		if not keep then current = multi and {} or nil end
		build()
		display()
		if open then resize() end
	end
	function obj:Get() return listValue() end
	local def = cfg.Default or cfg.Value
	if multi then
		if type(def) == "table" then
			for _, x in ipairs(def) do current[x] = true end
		end
	else
		current = def
	end
	build()
	display()
	head.MouseButton1Click:Connect(function()
		open = not open
		resize()
	end)
	return finishObj(obj, f, lock, win, cfg)
end

function Container:CreateKeybind(cfg)
	cfg = cfg or {}
	local win = self.Window
	local key = cfg.Default or cfg.Value
	if type(key) == "string" then key = Enum.KeyCode[key] end
	local listening = false
	local f, lock = mkElement(self, elHeight(cfg, 38))
	mkHeader(self, f, cfg, 116)
	local btn = create("TextButton", {
		Size = UDim2.fromOffset(92, 26), Position = UDim2.new(1, -104, 0.5, -13),
		Font = Enum.Font.GothamMedium, TextSize = 13, BorderSizePixel = 0, AutoButtonColor = false,
		Text = key and key.Name or "None",
	}, f)
	corner(btn, 6)
	bind(win, btn, "BackgroundColor3", "Sidebar")
	bind(win, btn, "TextColor3", "Accent")
	local obj = {}
	function obj:Set(k, silent)
		if type(k) == "string" then k = Enum.KeyCode[k] end
		key = k
		btn.Text = key and key.Name or "None"
		if not silent then safe(cfg.OnChanged, key) end
	end
	function obj:Get() return key and key.Name or nil end
	btn.MouseButton1Click:Connect(function()
		listening = true
		btn.Text = "..."
	end)
	table.insert(win._connections, UserInputService.InputBegan:Connect(function(i, gp)
		if listening then
			if i.UserInputType == Enum.UserInputType.Keyboard then
				listening = false
				if i.KeyCode ~= Enum.KeyCode.Escape then key = i.KeyCode end
				btn.Text = key and key.Name or "None"
				safe(cfg.OnChanged, key)
			end
			return
		end
		if not gp and key and i.KeyCode == key and not lock.Visible then
			safe(cfg.Callback, key)
		end
	end))
	return finishObj(obj, f, lock, win, cfg)
end

function Container:CreateColorPicker(cfg)
	cfg = cfg or {}
	local win = self.Window
	local color = cfg.Default or cfg.Value or Color3.fromRGB(255, 255, 255)
	local h, s, v = color:ToHSV()
	local open = false
	local HEAD = elHeight(cfg, 38)
	local f, lock = mkElement(self, HEAD)
	mkHeader(self, f, cfg, 64)
	local swatch = create("Frame", { Size = UDim2.fromOffset(36, 20), Position = UDim2.new(1, -48, 0, (HEAD - 20) / 2), BorderSizePixel = 0 }, f)
	corner(swatch, 5)
	stroke(swatch, 1, 0.2)
	local head = create("TextButton", { BackgroundTransparency = 1, Text = "", Size = UDim2.new(1, 0, 0, HEAD) }, f)
	local obj = {}
	local setH, setS, setV
	local function apply(silent)
		color = Color3.fromHSV(h, s, v)
		swatch.BackgroundColor3 = color
		if not silent then safe(cfg.Callback, color) end
	end
	local names = { "H", "S", "V" }
	for idx = 1, 3 do
		local y = HEAD + (idx - 1) * 26 + 2
		mkLabel(win, f, { Text = names[idx], TextSize = 12, Position = UDim2.fromOffset(12, y + 2), Size = UDim2.fromOffset(14, 18) }, "SubText")
		local holder = create("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(18, 0), Size = UDim2.new(1, -18, 1, 0) }, f)
		local setter = makeBar(win, holder, y, function(rel)
			if idx == 1 then h = rel elseif idx == 2 then s = rel else v = rel end
			apply()
		end)
		if idx == 1 then setH = setter elseif idx == 2 then setS = setter else setV = setter end
	end
	local function syncBars()
		setH(h); setS(s); setV(v)
	end
	function obj:Set(c, silent)
		if type(c) == "table" then c = Color3.new(c.r or c[1] or 1, c.g or c[2] or 1, c.b or c[3] or 1) end
		h, s, v = c:ToHSV()
		syncBars()
		apply(silent)
	end
	function obj:Get() return color end
	syncBars()
	apply(true)
	head.MouseButton1Click:Connect(function()
		open = not open
		tween(f, 0.18, { Size = UDim2.new(1, 0, 0, open and (HEAD + 3 * 26 + 8) or HEAD) })
	end)
	return finishObj(obj, f, lock, win, cfg)
end

local Window = {}
Window.__index = Window

local function encodeValue(v)
	if typeof(v) == "Color3" then
		return { __t = "color", r = v.R, g = v.G, b = v.B }
	end
	return v
end
local function decodeValue(v)
	if type(v) == "table" and v.__t == "color" then
		return Color3.new(v.r, v.g, v.b)
	end
	return v
end
local function hasFS()
	return type(writefile) == "function" and type(readfile) == "function"
end

function Window:_bind(inst, prop, key)
	bind(self, inst, prop, key)
end

function Window:_applyTheme(animate)
	for i = #self._bindings, 1, -1 do
		local b = self._bindings[i]
		if b[1] and b[1].Parent then
			if animate then
				tween(b[1], 0.25, { [b[2]] = self.Theme[b[3]] })
			else
				b[1][b[2]] = self.Theme[b[3]]
			end
		else
			table.remove(self._bindings, i)
		end
	end
	for _, fn in ipairs(self._refreshers) do fn() end
	self:_refreshTabs()
end

function Window:SetTheme(name)
	if not Themes[name] then return end
	self.ThemeName = name
	self.Theme = Themes[name]
	self:_applyTheme(true)
end

function Window:SetTitle(t) self._title.Text = t end
function Window:SetSubtitle(t) self._subtitle.Text = t end

function Window:SetUIScale(n)
	n = math.clamp(tonumber(n) or 1, 0.6, 1.3)
	self._userScale = n
	if not self._minimized then
		tween(self._uiScale, 0.15, { Scale = n })
	end
end

function Window:SetToggleKey(k)
	if type(k) == "string" then k = Enum.KeyCode[k] end
	if k then self.ToggleKey = k end
end

function Window:OnOpen(fn) table.insert(self._hooks.open, fn) end
function Window:OnClose(fn) table.insert(self._hooks.close, fn) end
function Window:OnDestroy(fn) table.insert(self._hooks.destroy, fn) end

function Window:_layout()
	local w = self.Main.Size.X.Offset
	local compact = w < 620
	self._compact = compact
	local sw = compact and 56 or 170
	self._sidebar.Size = UDim2.new(0, sw, 1, -16)
	self._pages.Position = UDim2.fromOffset(sw + 24, 4)
	self._pages.Size = UDim2.new(1, -(sw + 36), 1, -16)
	for _, t in ipairs(self._tabs) do
		t.Label.Visible = not compact
		t.Badge.Position = compact and UDim2.new(0.5, -12, 0.5, -12) or UDim2.new(0, 8, 0.5, -12)
	end
	self._tagHolder.Visible = w >= 470
end

function Window:_refreshTabs()
	local th = self.Theme
	for _, t in ipairs(self._tabs) do
		local active = (t == self._activeTab)
		tween(t.Button, 0.15, {
			BackgroundColor3 = th.Accent,
			BackgroundTransparency = active and 0.78 or 1,
		})
		t.Stroke.Color = th.Accent
		t.Stroke.Enabled = active
		t.Label.TextColor3 = active and th.Text or th.SubText
		t.Badge.BackgroundColor3 = th.Accent
		t.Badge.BackgroundTransparency = active and 0.1 or 0.8
		if t.Glyph:IsA("ImageLabel") then
			t.Glyph.ImageColor3 = active and th.Background or th.Accent
		else
			t.Glyph.TextColor3 = active and th.Background or th.Accent
		end
		t.Page.Visible = active
	end
end

function Window:SelectTab(tab)
	self._activeTab = tab
	self:_refreshTabs()
end

function Window:CreateTab(name, icon)
	local win = self
	local tab = setmetatable({ Window = win, Name = name }, Container)
	local btn = create("TextButton", {
		Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1, Text = "",
		AutoButtonColor = false, BorderSizePixel = 0, LayoutOrder = #win._tabs + 1,
	}, win._tabList)
	corner(btn, 8)
	local st = create("UIStroke", { Thickness = 1, Enabled = false, Transparency = 0.3 }, btn)
	local badge = create("Frame", { Size = UDim2.fromOffset(24, 24), Position = UDim2.new(0, 8, 0.5, -12), BorderSizePixel = 0 }, btn)
	corner(badge, 7)
	local img = iconId(icon)
	local glyph
	if img then
		glyph = create("ImageLabel", { BackgroundTransparency = 1, Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(4, 4), Image = img }, badge)
	else
		glyph = create("TextLabel", {
			BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
			Text = string.upper(string.sub(name, 1, 1)), Font = Enum.Font.GothamBold, TextSize = 14,
		}, badge)
	end
	local lb = create("TextLabel", {
		BackgroundTransparency = 1, Text = name, Font = Enum.Font.GothamMedium, TextSize = 14,
		Position = UDim2.fromOffset(40, 0), Size = UDim2.new(1, -46, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, btn)
	local page = create("ScrollingFrame", {
		BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 3, Visible = false,
	}, win._pages)
	bind(win, page, "ScrollBarImageColor3", "Accent")
	listLayout(page, 8)
	padding(page, 0, 0, 6, 8)
	tab.Holder, tab.Page, tab.Button, tab.Stroke = page, page, btn, st
	tab.Label, tab.Badge, tab.Glyph = lb, badge, glyph
	function tab:Select() win:SelectTab(self) end
	table.insert(win._tabs, tab)
	btn.MouseButton1Click:Connect(function() win:SelectTab(tab) end)
	if not win._activeTab then win._activeTab = tab end
	win:_layout()
	win:_refreshTabs()
	return tab
end

function Window:CreateHome(cfg)
	cfg = cfg or {}
	local win = self
	local tab = self:CreateTab(cfg.TabName or "Home", cfg.Icon)
	local banner = create("Frame", { Size = UDim2.new(1, 0, 0, 112), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = nextOrder(tab) }, tab.Holder)
	corner(banner, 12)
	bind(win, banner, "BackgroundColor3", "Banner")
	bind(win, stroke(banner), "Color", "Stroke")
	logoNode(win, banner, { Size = UDim2.fromOffset(96, 96), Position = UDim2.new(1, -112, 0.5, -48), Alpha = 0.35 }, "Accent")
	local box = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, -130, 1, 0), Position = UDim2.fromOffset(16, 0) }, banner)
	create("UIListLayout", { VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, box)
	mkLabel(win, box, { Text = cfg.Title or "Welcome!", Font = Enum.Font.GothamBold, TextSize = 26, Size = UDim2.new(1, 0, 0, 32), LayoutOrder = 1, TextTruncate = Enum.TextTruncate.AtEnd })
	mkLabel(win, box, { Text = cfg.Subtitle or "Script Hub", Font = Enum.Font.GothamMedium, TextSize = 16, Size = UDim2.new(1, 0, 0, 22), LayoutOrder = 2, TextTruncate = Enum.TextTruncate.AtEnd }, "Accent")
	mkLabel(win, box, { Text = "by " .. (cfg.Author or "Unknown"), TextSize = 13, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 3 }, "SubText")
	local info = tab:CreateSection({ Title = "Information", Opened = false })
	local grid = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 56), LayoutOrder = 1 }, info.Holder)
	create("UIGridLayout", { CellSize = UDim2.new(1 / 3, -6, 1, 0), CellPadding = UDim2.fromOffset(9, 0), SortOrder = Enum.SortOrder.LayoutOrder }, grid)
	local order = 0
	local function card(title, value)
		order = order + 1
		local c = create("Frame", { BorderSizePixel = 0, LayoutOrder = order }, grid)
		corner(c, 8)
		bind(win, c, "BackgroundColor3", "Element")
		bind(win, stroke(c), "Color", "Stroke")
		padding(c, 12, 6, 8, 6)
		create("UIListLayout", { VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }, c)
		mkLabel(win, c, { Text = title, TextSize = 12, Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 1 }, "SubText")
		return mkLabel(win, c, { Text = value, Font = Enum.Font.GothamMedium, TextSize = 15, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 2, TextTruncate = Enum.TextTruncate.AtEnd })
	end
	card("Script Name", cfg.ScriptName or "-")
	card("Author", cfg.Author or "-")
	local statusLbl = card("Status", cfg.Status or "...")
	local desc = tab:CreateSection({ Title = "Description", Opened = false })
	local d = desc:CreateParagraph({ Title = "", Content = cfg.Description or "..." })
	function tab:SetStatus(t) statusLbl.Text = t end
	function tab:SetDescription(t) d:Set({ Content = t }) end
	return tab
end

function Window:CreateSettings(cfg)
	cfg = cfg or {}
	local win = self
	local tab = self:CreateTab(cfg.TabName or "Settings", cfg.Icon)
	local appearance = tab:CreateSection({ Title = "Appearance", Opened = false })
	appearance:CreateDropdown({
		Name = "Theme", Desc = "Ganti warna UI",
		Options = Ujayy.ThemeNames, Default = self.ThemeName,
		Callback = function(v) win:SetTheme(v) end,
	})
	appearance:CreateSlider({
		Name = "UI Scale", Desc = "Perbesar / perkecil seluruh UI",
		Min = 0.6, Max = 1.3, Increment = 0.05, Default = 1,
		Callback = function(v) win:SetUIScale(v) end,
	})
	local iface = tab:CreateSection({ Title = "Interface", Opened = false })
	if not self.IsMobile then
		iface:CreateKeybind({
			Name = "Toggle Key", Desc = "Tombol show / hide UI", Default = self.ToggleKey,
			OnChanged = function(k) win:SetToggleKey(k) end,
		})
	end
	iface:CreateButton({ Name = "Minimize", Desc = "Kecilkan jadi bubble logo", Callback = function() win:Minimize() end })
	local conf = tab:CreateSection({ Title = "Config", Opened = false })
	local nameInput = conf:CreateInput({ Name = "Config Name", Default = "default", Placeholder = "nama config" })
	conf:CreateButton({
		Name = "Save Config", Desc = "Simpan semua elemen ber-Flag",
		Callback = function()
			local ok, err = win:SaveConfig(nameInput:Get())
			win:Notify({ Title = "Config", Content = ok and "Tersimpan!" or tostring(err), Duration = 3 })
		end,
	})
	conf:CreateButton({
		Name = "Load Config", Desc = "Muat config yang tersimpan",
		Callback = function()
			local ok, err = win:LoadConfig(nameInput:Get())
			win:Notify({ Title = "Config", Content = ok and "Berhasil dimuat!" or tostring(err), Duration = 3 })
		end,
	})
	local danger = tab:CreateSection({ Title = "Danger Zone", Opened = false })
	danger:CreateButton({ Name = "Destroy UI", Desc = "Tutup dan hapus UI", Callback = function() win:Destroy() end })
	return tab
end

function Window:SaveConfig(name)
	if not hasFS() then return false, "Executor tidak support writefile" end
	name = (name and name ~= "") and name or "default"
	local data = {}
	for flag, obj in pairs(self.Flags) do
		local ok, v = pcall(function() return obj:Get() end)
		if ok and v ~= nil then data[flag] = encodeValue(v) end
	end
	local folder = self.Folder
	pcall(function()
		if type(makefolder) == "function" and type(isfolder) == "function" then
			if not isfolder(folder) then makefolder(folder) end
			if not isfolder(folder .. "/config") then makefolder(folder .. "/config") end
		end
	end)
	local ok, err = pcall(function()
		writefile(folder .. "/config/" .. name .. ".json", HttpService:JSONEncode(data))
	end)
	if not ok then return false, err end
	return true
end

function Window:LoadConfig(name)
	if not hasFS() then return false, "Executor tidak support readfile" end
	name = (name and name ~= "") and name or "default"
	local path = self.Folder .. "/config/" .. name .. ".json"
	local ok, raw = pcall(function() return readfile(path) end)
	if not ok or not raw then return false, "Config tidak ditemukan" end
	local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
	if not ok2 or type(data) ~= "table" then return false, "File config rusak" end
	for flag, v in pairs(data) do
		local obj = self.Flags[flag]
		if obj and obj.Set then
			pcall(function() obj:Set(decodeValue(v)) end)
		end
	end
	return true
end

function Window:Tag(cfg)
	cfg = cfg or {}
	local win = self
	local chip = create("Frame", {
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22),
		BorderSizePixel = 0, BackgroundTransparency = 0.78,
	}, self._tagHolder)
	corner(chip, 6)
	if cfg.Color then chip.BackgroundColor3 = cfg.Color else bind(win, chip, "BackgroundColor3", "Accent") end
	padding(chip, 8, 0, 8, 0)
	local l = mkLabel(win, chip, {
		Text = cfg.Title or "v1.0", Font = Enum.Font.GothamBold, TextSize = 12,
		Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
	}, "Text")
	local obj = {}
	function obj:Set(t) l.Text = t end
	function obj:Destroy() chip:Destroy() end
	return obj
end

function Window:Notify(cfg)
	cfg = cfg or {}
	local win = self
	local f = create("Frame", {
		Size = UDim2.fromOffset(260, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.new(1, 280, 0, 0), BorderSizePixel = 0,
	}, self._notifHolder)
	corner(f, 10)
	padding(f, 12, 10, 12, 10)
	bind(win, f, "BackgroundColor3", "Background")
	bind(win, stroke(f, 1, 0.2), "Color", "Accent")
	listLayout(f, 3)
	mkLabel(win, f, { Text = cfg.Title or "Notification", Font = Enum.Font.GothamBold, TextSize = 14, Size = UDim2.new(1, 0, 0, 18), LayoutOrder = 1 })
	mkLabel(win, f, {
		Text = cfg.Content or "", TextSize = 12, TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 2,
	}, "SubText")
	tween(f, 0.3, { Position = UDim2.new(0, 0, 0, 0) })
	task.delay(cfg.Duration or 4, function()
		if f.Parent then
			tween(f, 0.3, { Position = UDim2.new(1, 280, 0, 0) })
			task.wait(0.35)
			f:Destroy()
		end
	end)
end

function Window:Dialog(cfg)
	cfg = cfg or {}
	local win = self
	local overlay = create("TextButton", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1,
		Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 50,
	}, self.Main)
	corner(overlay, 16)
	tween(overlay, 0.18, { BackgroundTransparency = 0.45 })
	local card = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 300, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BorderSizePixel = 0,
	}, overlay)
	corner(card, 12)
	bind(win, card, "BackgroundColor3", "Background")
	bind(win, stroke(card, 1, 0.2), "Color", "Accent")
	padding(card, 16, 14, 16, 14)
	listLayout(card, 8)
	mkLabel(win, card, { Text = cfg.Title or "Dialog", Font = Enum.Font.GothamBold, TextSize = 16, Size = UDim2.new(1, 0, 0, 22), LayoutOrder = 1 })
	mkLabel(win, card, {
		Text = cfg.Content or "", TextSize = 13, TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 2,
	}, "SubText")
	local row = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 34), LayoutOrder = 3 }, card)
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
	}, row)
	local closed = false
	local function close()
		if closed then return end
		closed = true
		tween(overlay, 0.15, { BackgroundTransparency = 1 })
		task.delay(0.15, function() overlay:Destroy() end)
	end
	for idx, b in ipairs(cfg.Buttons or { { Title = "OK", Variant = "Primary" } }) do
		local bt = create("TextButton", {
			Size = UDim2.fromOffset(96, 32), BorderSizePixel = 0, AutoButtonColor = false,
			Text = b.Title or "OK", Font = Enum.Font.GothamBold, TextSize = 13, LayoutOrder = idx,
		}, row)
		corner(bt, 8)
		if b.Variant == "Primary" then
			bind(win, bt, "BackgroundColor3", "Accent")
			bt.TextColor3 = Color3.fromRGB(10, 14, 28)
		else
			bind(win, bt, "BackgroundColor3", "Element")
			bind(win, bt, "TextColor3", "Text")
		end
		bt.MouseButton1Click:Connect(function()
			close()
			safe(b.Callback)
		end)
	end
	return { Close = close }
end

function Window:RequestClose()
	self:Dialog({
		Title = "Tutup Ujayy?",
		Content = "UI akan dihapus. Kamu bisa menjalankan script lagi untuk membukanya.",
		Buttons = {
			{ Title = "Batal" },
			{ Title = "Tutup", Variant = "Primary", Callback = function() self:Destroy() end },
		},
	})
end

function Window:Destroy()
	if self._destroyed then return end
	self._destroyed = true
	fire(self._hooks.destroy)
	for _, c in ipairs(self._connections) do
		pcall(function() c:Disconnect() end)
	end
	if self.Gui then self.Gui:Destroy() end
end

function Window:Minimize()
	if self._minimized or not self._ready then return end
	self._minimized = true
	self._lastPos = self.Main.Position
	self._lastSize = self.Main.Size
	local bubble, bs = self._bubble, self._bubbleScale
	tween(self.Main, 0.22, { Position = bubble.Position }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	tween(self._uiScale, 0.22, { Scale = 0.02 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	task.delay(0.22, function()
		if self._minimized and not self._destroyed then self.Main.Visible = false end
	end)
	bubble.Visible = true
	bs.Scale = 0
	task.delay(0.12, function()
		if self._minimized and not self._destroyed then
			tween(bs, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
		end
	end)
	fire(self._hooks.close)
end

function Window:Restore()
	if not self._minimized then return end
	self._minimized = false
	local bubble, bs = self._bubble, self._bubbleScale
	self.Main.Position = bubble.Position
	self._uiScale.Scale = 0.02
	self.Main.Visible = true
	tween(self.Main, 0.28, { Position = self._lastPos })
	tween(self._uiScale, 0.3, { Scale = self._userScale }, Enum.EasingStyle.Back)
	tween(bs, 0.15, { Scale = 0 })
	task.delay(0.16, function()
		if not self._minimized and not self._destroyed then bubble.Visible = false end
	end)
	fire(self._hooks.open)
end

function Window:Toggle()
	if self._minimized then self:Restore() else self:Minimize() end
end

function Window:Maximize()
	if not self._ready or self._minimized then return end
	local main, gui = self.Main, self.Gui
	local sc = self._uiScale.Scale
	if not self._maximized then
		self._maxRestore = { size = main.Size, pos = main.Position }
		self._maximized = true
		tween(main, 0.22, {
			Size = UDim2.fromOffset((gui.AbsoluteSize.X - 16) / sc, (gui.AbsoluteSize.Y - 16) / sc),
			Position = UDim2.fromScale(0.5, 0.5),
		})
	else
		self._maximized = false
		local r = self._maxRestore
		if r then tween(main, 0.22, { Size = r.size, Position = r.pos }) end
	end
end

function Window:_reveal()
	if self._destroyed then return end
	self._ready = true
	self.Main.Visible = true
	self._uiScale.Scale = 0.85 * self._userScale
	tween(self._uiScale, 0.35, { Scale = self._userScale }, Enum.EasingStyle.Back)
	fire(self._hooks.open)
end

function Window:_loader(cfg)
	local win = self
	local gui = self.Gui
	local card = create("CanvasGroup", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(300, 206), BorderSizePixel = 0, GroupTransparency = 1,
	}, gui)
	corner(card, 16)
	bind(win, card, "BackgroundColor3", "Background")
	bind(win, stroke(card, 2, 0.1), "Color", "Accent")
	local cardScale = create("UIScale", { Scale = 0.85 }, card)
	tween(card, 0.3, { GroupTransparency = 0 })
	tween(cardScale, 0.35, { Scale = 1 }, Enum.EasingStyle.Back)
	local trackRing = create("Frame", { Size = UDim2.fromOffset(64, 64), Position = UDim2.new(0.5, -32, 0, 22), BackgroundTransparency = 1 }, card)
	corner(trackRing, 32)
	bind(win, stroke(trackRing, 3, 0.75), "Color", "Stroke")
	local ring = create("Frame", { Size = UDim2.fromOffset(64, 64), Position = UDim2.new(0.5, -32, 0, 22), BackgroundTransparency = 1 }, card)
	corner(ring, 32)
	local rs = create("UIStroke", { Thickness = 3, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, ring)
	bind(win, rs, "Color", "Accent")
	local grad = create("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.45, 0.1),
			NumberSequenceKeypoint.new(0.55, 1),
			NumberSequenceKeypoint.new(1, 1),
		}),
	}, rs)
	local lg = logoNode(win, card, {
		Size = UDim2.fromOffset(34, 34), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 54),
	}, "Accent")
	local lgScale = create("UIScale", {}, lg)
	mkLabel(win, card, {
		Text = cfg.LoadingTitle or cfg.Name or "Ujayy", Font = Enum.Font.GothamBold, TextSize = 18,
		Position = UDim2.fromOffset(0, 100), Size = UDim2.new(1, 0, 0, 24), TextXAlignment = Enum.TextXAlignment.Center,
	})
	mkLabel(win, card, {
		Text = cfg.LoadingSubtitle or cfg.Subtitle or "", TextSize = 13,
		Position = UDim2.fromOffset(0, 124), Size = UDim2.new(1, 0, 0, 18), TextXAlignment = Enum.TextXAlignment.Center,
	}, "Accent")
	local status = mkLabel(win, card, {
		Text = "", TextSize = 12,
		Position = UDim2.fromOffset(0, 148), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = Enum.TextXAlignment.Center,
	}, "SubText")
	local barBg = create("Frame", { Size = UDim2.new(0, 240, 0, 6), Position = UDim2.new(0.5, -120, 0, 176), BorderSizePixel = 0 }, card)
	corner(barBg, 3)
	bind(win, barBg, "BackgroundColor3", "Sidebar")
	local fill = create("Frame", { Size = UDim2.fromScale(0, 1), BorderSizePixel = 0 }, barBg)
	corner(fill, 3)
	bind(win, fill, "BackgroundColor3", "Accent")
	local dur = cfg.LoadingDuration or 2.6
	local steps = cfg.LoadingSteps or { "Initializing...", "Loading assets...", "Building interface...", "Applying theme...", "Ready!" }
	local t0 = os.clock()
	local conn
	local finished = false
	local function finish()
		task.delay(0.25, function()
			if win._destroyed then return end
			tween(card, 0.3, { GroupTransparency = 1 })
			tween(cardScale, 0.3, { Scale = 1.08 })
			task.wait(0.32)
			if win._destroyed then return end
			card:Destroy()
			win:_reveal()
		end)
	end
	conn = RunService.Heartbeat:Connect(function()
		local el = os.clock() - t0
		grad.Rotation = (el * 360) % 360
		lgScale.Scale = 1 + 0.08 * math.sin(el * 5)
		local p = math.clamp(el / dur, 0, 1)
		fill.Size = UDim2.fromScale(1 - (1 - p) ^ 2, 1)
		local idx = math.clamp(math.floor(p * #steps) + 1, 1, #steps)
		status.Text = steps[idx]
		if p >= 1 and not finished then
			finished = true
			conn:Disconnect()
			finish()
		end
	end)
	table.insert(win._connections, conn)
end

function Ujayy:CreateWindow(cfg)
	cfg = cfg or {}
	local win = setmetatable({
		_bindings = {}, _refreshers = {}, _connections = {}, _tabs = {},
		_hooks = { open = {}, close = {}, destroy = {} },
		Flags = {}, Folder = cfg.Folder or "Ujayy",
		ThemeName = Themes[cfg.Theme] and cfg.Theme or "Blue",
		IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled,
		_userScale = 1, _minimized = false, _maximized = false, _ready = false, _destroyed = false,
	}, Window)
	win.Theme = Themes[win.ThemeName]
	win.Window = win
	win.ToggleKey = cfg.ToggleKey or Enum.KeyCode.RightShift
	win.LogoImage = getLogo(cfg.Logo)
	local guiParent = getGuiParent()
	local old = guiParent:FindFirstChild("UjayyUI")
	if old then old:Destroy() end
	local gui = create("ScreenGui", {
		Name = "UjayyUI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999, IgnoreGuiInset = true,
	})
	gui.Parent = guiParent
	win.Gui = gui
	local function screenSize()
		local s = gui.AbsoluteSize
		if s.X < 10 then
			local cam = workspace.CurrentCamera
			s = cam and cam.ViewportSize or Vector2.new(800, 600)
		end
		return s
	end
	local scr = screenSize()
	local sz = cfg.Size or (win.IsMobile and UDim2.fromOffset(500, 300) or UDim2.fromOffset(560, 400))
	local minSize = win.IsMobile and Vector2.new(360, 220) or Vector2.new(460, 280)
	minSize = Vector2.new(math.min(minSize.X, scr.X - 24), math.min(minSize.Y, scr.Y - 24))
	win.MinSize = minSize
	local w = math.max(math.min(sz.X.Offset, scr.X - 24), minSize.X)
	local h = math.max(math.min(sz.Y.Offset, scr.Y - 24), minSize.Y)
	local main = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(w, h), BorderSizePixel = 0, ClipsDescendants = true, Visible = false,
	}, gui)
	corner(main, 16)
	local ms = create("UIStroke", { Thickness = 2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, main)
	bind(win, main, "BackgroundColor3", "Background")
	bind(win, ms, "Color", "Accent")
	local uiScale = create("UIScale", { Scale = 1 }, main)
	win.Main, win._uiScale = main, uiScale
	local header = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 56) }, main)
	logoNode(win, header, { Size = UDim2.fromOffset(34, 34), Position = UDim2.fromOffset(14, 11) }, "Accent")
	win._title = mkLabel(win, header, {
		Text = cfg.Name or "Ujayy", Font = Enum.Font.GothamBold, TextSize = 19,
		Position = UDim2.fromOffset(58, 7), Size = UDim2.new(1, -250, 0, 24), TextTruncate = Enum.TextTruncate.AtEnd,
	})
	win._subtitle = mkLabel(win, header, {
		Text = cfg.Subtitle or "", TextSize = 13,
		Position = UDim2.fromOffset(58, 30), Size = UDim2.new(1, -250, 0, 18), TextTruncate = Enum.TextTruncate.AtEnd,
	}, "Accent")
	win._tagHolder = create("Frame", {
		BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -118, 0, 17),
		Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X,
	}, header)
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right,
		Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
	}, win._tagHolder)
	local function winButton(xOff, kind, cb)
		local b = create("TextButton", {
			BackgroundTransparency = 1, Text = "", Size = UDim2.fromOffset(30, 30),
			Position = UDim2.new(1, xOff, 0, 13), AutoButtonColor = false,
		}, header)
		corner(b, 8)
		bind(win, b, "BackgroundColor3", "Text")
		local function bar(bw, bh, rot)
			local fr = create("Frame", {
				Size = UDim2.fromOffset(bw, bh), AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5), Rotation = rot or 0, BorderSizePixel = 0,
			}, b)
			corner(fr, 1)
			bind(win, fr, "BackgroundColor3", "Text")
		end
		if kind == "min" then bar(12, 2, 0)
		elseif kind == "max" then
			local sq = create("Frame", {
				Size = UDim2.fromOffset(11, 11), AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 1,
			}, b)
			corner(sq, 2)
			bind(win, stroke(sq, 2, 0), "Color", "Text")
		else
			bar(15, 2, 45); bar(15, 2, -45)
		end
		b.MouseEnter:Connect(function() tween(b, 0.12, { BackgroundTransparency = 0.88 }) end)
		b.MouseLeave:Connect(function() tween(b, 0.12, { BackgroundTransparency = 1 }) end)
		b.MouseButton1Click:Connect(cb)
	end
	winButton(-40, "close", function()
		if cfg.ConfirmClose == false then win:Destroy() else win:RequestClose() end
	end)
	winButton(-74, "max", function() win:Maximize() end)
	winButton(-108, "min", function() win:Minimize() end)
	local body = create("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 56), Size = UDim2.new(1, 0, 1, -56) }, main)
	local sidebar = create("Frame", { Position = UDim2.fromOffset(12, 4), Size = UDim2.new(0, 170, 1, -16), BorderSizePixel = 0 }, body)
	corner(sidebar, 12)
	bind(win, sidebar, "BackgroundColor3", "Sidebar")
	bind(win, stroke(sidebar), "Color", "Stroke")
	local tabList = create("ScrollingFrame", {
		BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0,
	}, sidebar)
	padding(tabList, 8, 8, 8, 8)
	listLayout(tabList, 6)
	win._sidebar, win._tabList = sidebar, tabList
	win._pages = create("Frame", {
		BackgroundTransparency = 1, Position = UDim2.fromOffset(194, 4),
		Size = UDim2.new(1, -206, 1, -16), ClipsDescendants = true,
	}, body)
	local grip = create("Frame", {
		AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -3, 1, -3), Size = UDim2.fromOffset(24, 24),
		BackgroundTransparency = 1, Active = true, ZIndex = 10,
	}, main)
	for _, off in ipairs({ 0, 6 }) do
		local ln = create("Frame", {
			Size = UDim2.fromOffset(14 - off, 2), AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, -2 + off, 0.5, -2 + off), Rotation = -45, BorderSizePixel = 0, ZIndex = 10,
		}, grip)
		corner(ln, 1)
		bind(win, ln, "BackgroundColor3", "Accent")
	end
	local rsStart, rsSize, rsPos
	track(win, grip, function(i)
		rsStart = Vector2.new(i.Position.X, i.Position.Y)
		rsSize = Vector2.new(main.Size.X.Offset, main.Size.Y.Offset)
		rsPos = main.Position
		win._maximized = false
	end, function(i)
		if not rsStart then return end
		local sc = uiScale.Scale
		local d = (Vector2.new(i.Position.X, i.Position.Y) - rsStart) / sc
		local s2 = screenSize()
		local maxW = math.max((s2.X - 16) / sc, minSize.X)
		local maxH = math.max((s2.Y - 16) / sc, minSize.Y)
		local nw = math.clamp(rsSize.X + d.X, minSize.X, maxW)
		local nh = math.clamp(rsSize.Y + d.Y, minSize.Y, maxH)
		main.Size = UDim2.fromOffset(nw, nh)
		main.Position = UDim2.new(
			rsPos.X.Scale, rsPos.X.Offset + (nw - rsSize.X) * sc / 2,
			rsPos.Y.Scale, rsPos.Y.Offset + (nh - rsSize.Y) * sc / 2
		)
	end, function()
		rsStart = nil
	end)
	main:GetPropertyChangedSignal("Size"):Connect(function() win:_layout() end)
	local dStart, dPos
	track(win, header, function(i)
		if win._maximized then return end
		dStart = Vector2.new(i.Position.X, i.Position.Y)
		dPos = main.Position
	end, function(i)
		if not dStart then return end
		local d = Vector2.new(i.Position.X, i.Position.Y) - dStart
		main.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + d.X, dPos.Y.Scale, dPos.Y.Offset + d.Y)
	end, function()
		dStart = nil
	end)
	local bubble = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(40, math.floor(scr.Y * 0.45)),
		Size = UDim2.fromOffset(50, 50), BorderSizePixel = 0, Visible = false, Active = true, ZIndex = 5,
	}, gui)
	corner(bubble, 25)
	bind(win, bubble, "BackgroundColor3", "Background")
	bind(win, stroke(bubble, 2, 0.05), "Color", "Accent")
	logoNode(win, bubble, {
		Size = UDim2.fromOffset(28, 28), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), ZIndex = 6,
	}, "Accent")
	local bubbleScale = create("UIScale", { Scale = 1 }, bubble)
	win._bubble, win._bubbleScale = bubble, bubbleScale
	local bStart, bPos, bMoved
	track(win, bubble, function(i)
		bStart = Vector2.new(i.Position.X, i.Position.Y)
		bPos = bubble.Position
		bMoved = false
	end, function(i)
		if not bStart then return end
		local d = Vector2.new(i.Position.X, i.Position.Y) - bStart
		if d.Magnitude > 6 then bMoved = true end
		if bMoved then
			local s2 = screenSize()
			bubble.Position = UDim2.fromOffset(
				math.clamp(bPos.X.Offset + d.X, 25, s2.X - 25),
				math.clamp(bPos.Y.Offset + d.Y, 25, s2.Y - 25)
			)
		end
	end, function()
		if bStart and not bMoved then win:Restore() end
		bStart = nil
	end)
	table.insert(win._connections, UserInputService.InputBegan:Connect(function(i, gp)
		if not gp and i.KeyCode == win.ToggleKey and win._ready then win:Toggle() end
	end))
	win._notifHolder = create("Frame", {
		BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -16),
		Size = UDim2.fromOffset(260, 400), ZIndex = 100,
	}, gui)
	listLayout(win._notifHolder, 8).VerticalAlignment = Enum.VerticalAlignment.Bottom
	win:_layout()
	if cfg.LoadingScreen == false then
		win:_reveal()
	else
		win:_loader(cfg)
	end
	return win
end

return Ujayy
end)()

--==================================================
-- LOGIC + UI CALLS
--==================================================

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")
local LocalPlayer       = Players.LocalPlayer

local Remotes     = ReplicatedStorage:FindFirstChild("Remotes")
local GameRemotes = Remotes and Remotes:FindFirstChild("Game")
local EggPickup               = GameRemotes and GameRemotes:FindFirstChild("EggPickup")
local EggArrivalClaim         = GameRemotes and GameRemotes:FindFirstChild("EggArrivalClaim")
local CollectCandy            = GameRemotes and GameRemotes:FindFirstChild("CollectCandy")
local CandyState              = GameRemotes and GameRemotes:FindFirstChild("CandyState")
local GetCandyState           = GameRemotes and GameRemotes:FindFirstChild("GetCandyState")
local HalloweenCandyDeposited = GameRemotes and GameRemotes:FindFirstChild("HalloweenCandyDeposited")
local HalloweenCandySpoiled   = GameRemotes and GameRemotes:FindFirstChild("HalloweenCandySpoiled")

local EggsData = nil
pcall(function()
    EggsData = require(ReplicatedStorage.GameData:WaitForChild("Eggs"))
end)

local HIDDEN_RARITY = { Common=true, Rare=true, Epic=true, Legendary=true }
local RARITY_COLOR = {
    Epic      = Color3.fromRGB(180, 80, 255),
    Legendary = Color3.fromRGB(255, 200, 50),
    Mythic    = Color3.fromRGB(255, 120, 50),
    Divine    = Color3.fromRGB(255, 60, 60),
    Ethereal  = Color3.fromRGB(255, 255, 255),
}
local RARITY_TIER = { Common=1, Rare=2, Epic=3, Legendary=4, Mythic=5, Divine=6, Ethereal=7 }

local state = {
    infJump = false, speedValue = 16, jumpValue = 50,
    mutationWait = 10, baseEggPos = nil, baseCandyPos = nil,
    candyAutoCollect = false, candyReturnBase = true,
    candyIncludePumpkin = true, candyIncludeRitual = false,
    candyLoopMode = false, candyPickupDelay = 0.15,
    candyBetweenDelay = 1.5, candyCooldownPerCandy = 2, candyRunning = false,
    espEgg = false, espCandy = false, espPlayer = false, espYinYang = false,
    noclip = false, useMutation = false,
    instantSpam = 20, instantSpamDelay = 0.05, instantBreakOffset = 1,
    SAFE_POS     = Vector3.new(-5049, 41261, -3541),
    ALT_SAFE_POS = Vector3.new(-4990, 41274, -3649),
    TITIK_EGG    = Vector3.new(-5327, 40912, -3578),
    KAWAH        = Vector3.new(-5102, 41415, -3489),
    hideGarden = false, noLag = false, boostFps = false,
    webhookURL = "", webhookRarity = "Mythic",
    stats = { farmed = 0, skipped = 0, startTime = os.clock(),
        rarityCount = { Common=0, Rare=0, Epic=0, Legendary=0, Mythic=0, Divine=0, Ethereal=0 },
        bestEgg = nil },
}

local candyRespawnAt, candyAmounts, candyLastCollect = {}, {}, {}
local GLOBAL_CANDY_COOLDOWN = 0

local function GetRarity(name)
    if not EggsData then return "Common" end
    local d = EggsData[name]; return d and d.Rarity or "Common"
end
local function IsHiddenRarity(name) return HIDDEN_RARITY[GetRarity(name)] == true end
local function IsEggModel(o)
    if not o:IsA("Model") then return false end
    if o:GetAttribute("Egg") or o:GetAttribute("EggKey") then return true end
    if o:HasTag("Egg") then return true end
    return false
end
local function GetEggPos(o)
    local pos = o:GetAttribute("Position")
    if typeof(pos) == "Vector3" then return pos end
    local ok, pivot = pcall(function() return o:GetPivot() end)
    if ok and pivot then return pivot.Position end
    return nil
end
local function GetEggWeight(o)
    local w = o:GetAttribute("Weight")
    if typeof(w) == "number" then return w end
    return nil
end
local function ScanAllEggs()
    local eggs, seen = {}, {}
    local function add(o)
        if seen[o] then return end
        seen[o] = true
        local name = o:GetAttribute("Egg") or o.Name
        if IsHiddenRarity(name) then return end
        local pos = GetEggPos(o)
        if pos then
            table.insert(eggs, { model=o, name=name, pos=pos, weight=GetEggWeight(o) or 0, rarity=GetRarity(name) })
        end
    end
    local r = workspace:FindFirstChild("RenderedEggs")
    if r then for _, o in ipairs(r:GetChildren()) do if IsEggModel(o) then add(o) end end end
    local sd = ReplicatedStorage:FindFirstChild("ServerData")
    local ae = (sd or ReplicatedStorage):FindFirstChild("ActiveEggs")
    if ae then for _, o in ipairs(ae:GetChildren()) do
        if not o:GetAttribute("Delivering") then add(o) end
    end end
    return eggs
end
local function GetChar()
    local c = LocalPlayer.Character; if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end
local function GetHumanoid()
    local c = LocalPlayer.Character; if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
end
local lastTP = 0
local function TP(pos)
    local hrp = GetChar(); if not hrp then return false end
    local now = tick()
    local waitNeeded = 0.08 + math.random() * 0.04
    if now - lastTP < waitNeeded then task.wait(waitNeeded - (now - lastTP)) end
    lastTP = tick()
    hrp.CFrame = CFrame.new(pos)
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    task.wait(0.1); return true
end
local function UnequipAll()
    local char = LocalPlayer.Character; if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid"); if not humanoid then return end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") then humanoid:UnequipTools(); task.wait(0.05); break end
    end
    if humanoid.Sit then humanoid.Sit = false; task.wait(0.05) end
    humanoid.PlatformStand = false; task.wait(0.05)
end
local _cachedBaseplate, _lastBaseplateFetch = nil, 0
local function AutoGetBaseplate()
    if _cachedBaseplate and (tick() - _lastBaseplateFetch) < 2 then return _cachedBaseplate end
    local ok, plot = pcall(function()
        local general = require(ReplicatedStorage.GameServices:WaitForChild("General"))
        return general:GetPlot(LocalPlayer)
    end)
    if ok and plot then
        local bp = plot:FindFirstChild("Baseplate")
        if bp then
            _cachedBaseplate = bp.Position + Vector3.new(0, 5, 0)
            _lastBaseplateFetch = tick()
            return _cachedBaseplate
        end
    end
    return nil
end
local function PickupEgg(eggModel)
    if not EggPickup then return false end
    return pcall(function() EggPickup:FireServer(eggModel.Name) end)
end
local function ApplyInstantBypass()
    local basket = LocalPlayer:FindFirstChild("Basket")
    if not basket then return 0 end
    local now = workspace:GetServerTimeNow()
    local count = 0
    for _, egg in ipairs(basket:GetChildren()) do
        local ok = pcall(function()
            egg:SetAttribute("VolcanoDipped", true)
            egg:SetAttribute("BreakAt", now - state.instantBreakOffset)
            egg:SetAttribute("BreakGraceSeconds", 0)
            egg:SetAttribute("BreakSeconds", 0)
        end)
        if ok then count = count + 1 end
    end
    return count
end
local function FireInstantClaim()
    if not EggArrivalClaim then return false end
    local basket = LocalPlayer:FindFirstChild("Basket")
    if not basket then return false end
    local ids = {}
    for _, egg in ipairs(basket:GetChildren()) do table.insert(ids, egg.Name) end
    if #ids == 0 then return false end
    local basePos = AutoGetBaseplate() or (GetChar() and GetChar().Position)
    if not basePos then return false end
    for i = 1, state.instantSpam do
        pcall(function() EggArrivalClaim:FireServer(workspace:GetServerTimeNow(), basePos, ids) end)
        task.wait(state.instantSpamDelay)
    end
    return true
end
local WebhookQueue = { items = {}, processing = false }
local function ProcessWebhookQueue()
    if WebhookQueue.processing then return end
    WebhookQueue.processing = true
    task.spawn(function()
        while #WebhookQueue.items > 0 do
            local item = table.remove(WebhookQueue.items, 1)
            pcall(function() HttpService:PostAsync(item.url, item.body, Enum.HttpContentType.ApplicationJson) end)
            task.wait(0.6)
        end
        WebhookQueue.processing = false
    end)
end
local function SendWebhook(eggName, rarity, weight)
    if not state.webhookURL or state.webhookURL == "" then return end
    if (RARITY_TIER[rarity] or 0) < (RARITY_TIER[state.webhookRarity] or 5) then return end
    local data = {
        username = "Ujayy Notifier",
        embeds = {{ title = "Rare Egg Found!", color = 0x0091FF,
            fields = {
                { name="Player", value=LocalPlayer.Name, inline=true },
                { name="Egg", value=eggName, inline=true },
                { name="Rarity", value=rarity, inline=true },
                { name="Weight", value=string.format("%.1f kg", weight or 0), inline=true },
            },
            footer = { text = "Ujayy V1.0.5" },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        }}
    }
    table.insert(WebhookQueue.items, { url = state.webhookURL, body = HttpService:JSONEncode(data) })
    ProcessWebhookQueue()
end
local function IsValidated()
    return LocalPlayer:GetAttribute("VolcanoValidated") == true and LocalPlayer:GetAttribute("InVolcano") == true
end
local function PrepareVolcano()
    local hrp = GetChar(); if not hrp then return false end
    hrp.CFrame = CFrame.new(state.SAFE_POS); hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    local t = tick()
    while tick() - t < 2.5 do if IsValidated() then return true end task.wait(0.1) end
    hrp.CFrame = CFrame.new(state.ALT_SAFE_POS); hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    t = tick()
    while tick() - t < 2.5 do if IsValidated() then return true end task.wait(0.1) end
    return false
end
local function TPTrigger()
    local hrp = GetChar()
    local volcano = workspace:FindFirstChild("Volcano")
    if not hrp or not volcano then return false end
    local entrance = volcano:FindFirstChild("VolcanoEntrance")
    local validate = volcano:FindFirstChild("VolcanoValidate")
    if not entrance or not validate then return false end
    hrp.CFrame = CFrame.new(entrance.Position + Vector3.new(0, 5, 0))
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0); task.wait(0.3)
    hrp.CFrame = CFrame.new(validate.Position + Vector3.new(0, 5, 0))
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0); task.wait(0.3)
    return true
end
local function CariEgg(keyword)
    local r = workspace:FindFirstChild("RenderedEggs")
    if r then
        for _, o in ipairs(r:GetChildren()) do
            local name = o:GetAttribute("Egg") or o.Name
            if string.find(string.lower(name), string.lower(keyword)) then
                local pos = o:GetAttribute("Position")
                if not pos then
                    local ok, p = pcall(function() return o:GetPivot().Position end)
                    pos = ok and p
                end
                if pos then return { model=o, pos=pos, name=name, weight=GetEggWeight(o) or 0, rarity=GetRarity(name) } end
            end
        end
    end
    local sd = ReplicatedStorage:FindFirstChild("ServerData") or ReplicatedStorage
    local ae = sd:FindFirstChild("ActiveEggs")
    if ae then
        for _, o in ipairs(ae:GetChildren()) do
            local name = o:GetAttribute("Egg") or o.Name
            if string.find(string.lower(name), string.lower(keyword)) then
                local pos = o:GetAttribute("Position")
                if pos then return { model=o, pos=pos, name=name, weight=GetEggWeight(o) or 0, rarity=GetRarity(name) } end
            end
        end
    end
    return nil
end
local function RecordFarm(egg)
    state.stats.farmed = state.stats.farmed + 1
    local r = egg.rarity or "Common"
    state.stats.rarityCount[r] = (state.stats.rarityCount[r] or 0) + 1
    local w = egg.weight or 0
    if not state.stats.bestEgg or (RARITY_TIER[r] or 0) > (RARITY_TIER[state.stats.bestEgg.rarity] or 0)
       or ((RARITY_TIER[r] or 0) == (RARITY_TIER[state.stats.bestEgg.rarity] or 0) and w > (state.stats.bestEgg.weight or 0)) then
        state.stats.bestEgg = { name = egg.name, rarity = r, weight = w }
    end
    Notif("Egg Farmed!", string.format("[%s] %s (%.1f kg)", r, egg.name, w), 3)
    task.spawn(function() SendWebhook(egg.name, r, w) end)
end
local function ProcessNormalEgg(egg)
    UnequipAll(); task.wait(0.1)
    TP(egg.pos + Vector3.new(0, 3, 0)); task.wait(0.3)
    PickupEgg(egg.model); task.wait(0.5)
    local basket = LocalPlayer:FindFirstChild("Basket")
    local waitStart = tick()
    while tick() - waitStart < 3 do
        if basket and #basket:GetChildren() > 0 then break end
        task.wait(0.1)
    end
    if state.useMutation then
        print("[FARM] Mode: MUTASI KAWAH")
        TP(state.KAWAH + Vector3.new(0, 10, 0)); task.wait(0.2)
        local volcano = workspace:FindFirstChild("Volcano")
        local vTop = volcano and volcano:FindFirstChild("VolcanoTop")
        if vTop then TP(vTop.Position + Vector3.new(0, 30, 0)) end
        task.wait(state.mutationWait)
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) end
        task.wait(0.3)
        if EggArrivalClaim and basket and state.baseEggPos then
            local ids = {}
            for _, e in ipairs(basket:GetChildren()) do table.insert(ids, e.Name) end
            if #ids > 0 then
                pcall(function() EggArrivalClaim:FireServer(workspace:GetServerTimeNow(), state.baseEggPos, ids) end)
            end
        end
    else
        print("[FARM] Mode: INSTANT BYPASS")
        local count = ApplyInstantBypass()
        print("[BYPASS] Spoof", count, "egg")
        task.wait(0.2)
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) end
        task.wait(0.3)
        local ok = FireInstantClaim()
        print("[BYPASS] Claim:", ok)
    end
    RecordFarm(egg)
end
local function ProcessVolcanicEgg()
    local hrp = GetChar(); if not hrp then return end
    UnequipAll(); task.wait(0.05)
    local egg = nil
    local startT = tick()
    while tick() - startT < 300 do
        egg = CariEgg("volcanic")
        if egg then break end
        task.wait(0.5)
    end
    if not egg then return end
    TPTrigger(); task.wait(1.5)
    local ok = IsValidated() or PrepareVolcano()
    if not ok then return end
    TP(egg.pos + Vector3.new(0, 3, 0)); task.wait(0.4)
    PickupEgg(egg.model); task.wait(0.5)
    local basket = LocalPlayer:FindFirstChild("Basket")
    if state.useMutation then
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) else TP(state.KAWAH + Vector3.new(0, 10, 0)) end
        task.wait(0.3)
        local volcano = workspace:FindFirstChild("Volcano")
        local vTop = volcano and volcano:FindFirstChild("VolcanoTop")
        if vTop then TP(vTop.Position + Vector3.new(0, 30, 0)) else TP(state.KAWAH + Vector3.new(0, 10, 0)) end
        task.wait(state.mutationWait)
        if state.baseEggPos then TP(state.baseEggPos) end
    else
        ApplyInstantBypass(); task.wait(0.2)
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) end
        task.wait(0.3)
        FireInstantClaim()
    end
    RecordFarm(egg)
end
local FarmSingle = { selectedEggObj = nil, isRunning = false }
function FarmSingle.SelectEgg(eggName)
    FarmSingle.selectedEggObj = nil
    for _, e in ipairs(ScanAllEggs()) do
        if e.name == eggName then FarmSingle.selectedEggObj = e; break end
    end
end
function FarmSingle.Clear() FarmSingle.selectedEggObj = nil end
function FarmSingle.Start()
    if not FarmSingle.selectedEggObj or FarmSingle.isRunning then return end
    local hrp = GetChar(); if hrp then state.baseEggPos = hrp.Position end
    FarmSingle.isRunning = true
    task.spawn(function()
        local egg = FarmSingle.selectedEggObj
        if string.find(string.lower(egg.name), "volcanic") then ProcessVolcanicEgg()
        else ProcessNormalEgg(egg) end
        FarmSingle.isRunning = false
    end)
end
function FarmSingle.Stop() FarmSingle.isRunning = false end
local SmartFarm = {
    mode = false, running = false,
    filterRarity = { Epic=true, Legendary=true, Mythic=true, Divine=true, Ethereal=true },
    minWeight = 0, priority = "Rarity", cycleDelay = 2,
}
function SmartFarm.Pick()
    local eggs = ScanAllEggs()
    local filtered = {}
    for _, e in ipairs(eggs) do
        if SmartFarm.filterRarity[e.rarity] and (e.weight or 0) >= SmartFarm.minWeight then
            table.insert(filtered, e)
        else
            state.stats.skipped = state.stats.skipped + 1
        end
    end
    if #filtered == 0 then return nil end
    local hrp = GetChar()
    if SmartFarm.priority == "Rarity" then
        table.sort(filtered, function(a, b) return (RARITY_TIER[a.rarity] or 0) > (RARITY_TIER[b.rarity] or 0) end)
    elseif SmartFarm.priority == "Weight" then
        table.sort(filtered, function(a, b) return (a.weight or 0) > (b.weight or 0) end)
    elseif SmartFarm.priority == "Nearest" and hrp then
        table.sort(filtered, function(a, b) return (a.pos - hrp.Position).Magnitude < (b.pos - hrp.Position).Magnitude end)
    end
    return filtered[1]
end
function SmartFarm.Start()
    if SmartFarm.running then return end
    SmartFarm.mode = true; SmartFarm.running = true
    if not state.baseEggPos then
        local bp = AutoGetBaseplate()
        if bp then state.baseEggPos = bp end
    end
    task.spawn(function()
        while SmartFarm.mode do
            local ok, err = pcall(function()
                local target = SmartFarm.Pick()
                if target then ProcessNormalEgg(target) end
            end)
            if not ok then print("[SmartFarm] Error:", err) end
            task.wait(SmartFarm.cycleDelay)
        end
        SmartFarm.running = false
    end)
end
function SmartFarm.Stop() SmartFarm.mode = false end
local function CandyApplySnapshot()
    if not GetCandyState then return end
    local ok, result = pcall(function() return GetCandyState:InvokeServer() end)
    if not ok or type(result) ~= "table" then return end
    if type(result.RespawnAt) == "table" then
        for id, t in pairs(result.RespawnAt) do
            if type(id) == "string" and type(t) == "number" then candyRespawnAt[id] = t end
        end
    end
    if type(result.Amounts) == "table" then
        for id, amt in pairs(result.Amounts) do
            if type(id) == "string" and type(amt) == "number" then candyAmounts[id] = amt end
        end
    end
end
if CandyState then
    CandyState.OnClientEvent:Connect(function(id, respawnAt, amount)
        if type(id) == "string" then
            candyRespawnAt[id] = respawnAt
            if type(amount) == "number" then candyAmounts[id] = amount end
        end
    end)
end
if HalloweenCandyDeposited then
    HalloweenCandyDeposited.OnClientEvent:Connect(function() GLOBAL_CANDY_COOLDOWN = os.clock() end)
end
if HalloweenCandySpoiled then
    HalloweenCandySpoiled.OnClientEvent:Connect(function()
        print("[Candy] Bag penuh! Stop sementara...")
        state.candyAutoCollect = false
        state.candyRunning = false
        Notif("Bag Penuh!", "Candy gak bisa dipickup, deposit dulu.", 4)
    end)
end
local function FindCandyList()
    local list = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj:HasTag("HalloweenCandySpawn") then
            local isRitual  = obj:GetAttribute("RitualDrop") == true
            local isPumpkin = obj:GetAttribute("PumpkinDrop") == true
            local skip = (isRitual and not state.candyIncludeRitual) or (isPumpkin and not state.candyIncludePumpkin)
            if not skip then
                local id = obj:GetAttribute("Id")
                if type(id) ~= "string" or id == "" then id = obj:GetFullName() end
                table.insert(list, { part = obj, id = id, pos = obj.Position, isRitual = isRitual, isPumpkin = isPumpkin })
            end
        end
    end
    return list
end
local function IsCandyAvailable(candy)
    if LocalPlayer:GetAttribute("InHalloweenZone") ~= true then return false end
    local noSave = LocalPlayer:FindFirstChild("NoSaveData")
    local carried = noSave and noSave:FindFirstChild("CarriedCandy")
    if carried and carried:IsA("IntValue") and carried.Value > 0 then return false end
    local now = os.clock()
    local serverNow = workspace:GetServerTimeNow()
    local respawnAt = candyRespawnAt[candy.id]
    if respawnAt and serverNow < respawnAt then return false end
    local last = candyLastCollect[candy.id]
    if last and (now - last) < state.candyCooldownPerCandy then return false end
    if now < GLOBAL_CANDY_COOLDOWN then return false end
    return true
end
local function CollectOneCandy(candy)
    local hrp = GetChar(); if not hrp then return false end
    if not IsCandyAvailable(candy) then return false end
    hrp.CFrame = CFrame.new(candy.pos + Vector3.new(0, 3, 0))
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    task.wait(state.candyPickupDelay)
    local ok = pcall(function() CollectCandy:FireServer(candy.id) end)
    if not ok then return false end
    local now = os.clock()
    candyLastCollect[candy.id] = now
    GLOBAL_CANDY_COOLDOWN = now + 2
    return true
end
local function ReturnToBaseCandy()
    if not state.baseCandyPos then state.baseCandyPos = AutoGetBaseplate() end
    if not state.baseCandyPos then return false end
    local hrp = GetChar(); if not hrp then return false end
    hrp.CFrame = CFrame.new(state.baseCandyPos)
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    task.wait(0.3); return true
end
local function CandyCycleLoop()
    if state.candyRunning then return end
    state.candyRunning = true
    task.spawn(function()
        repeat
            local noSave = LocalPlayer:FindFirstChild("NoSaveData")
            local carried = noSave and noSave:FindFirstChild("CarriedCandy")
            if carried and carried.Value > 0 then
                task.wait(1)
            else
                local candies = FindCandyList()
                local hrp = GetChar()
                if hrp then
                    table.sort(candies, function(a, b)
                        return (a.pos - hrp.Position).Magnitude < (b.pos - hrp.Position).Magnitude
                    end)
                end
                local target = nil
                for _, candy in ipairs(candies) do
                    if IsCandyAvailable(candy) then target = candy; break end
                end
                if target then
                    CollectOneCandy(target)
                    if state.candyReturnBase then ReturnToBaseCandy() end
                    task.wait(state.candyBetweenDelay)
                else
                    task.wait(1)
                end
            end
            if not state.candyAutoCollect then break end
        until not state.candyAutoCollect
        state.candyRunning = false
    end)
end
local RenderedEggESP, RenderedCandyESP, RenderedPlayerESP, RenderedYinYangESP = {}, {}, {}, {}
local function ClearTable(tbl)
    for k, data in pairs(tbl) do
        if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
        if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
        if data.Anchor    then pcall(function() data.Anchor:Destroy()    end) end
        tbl[k] = nil
    end
end
local function BuildEggESP(eggData)
    if RenderedEggESP[eggData.model] then return end
    local pos = eggData.pos; if not pos then return end
    local color = RARITY_COLOR[eggData.rarity] or Color3.fromRGB(255, 30, 30)
    local weightStr = eggData.weight and eggData.weight > 0 and (" W:" .. string.format("%.1f", eggData.weight)) or ""
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.7; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color; hl.OutlineColor = color
    hl.Adornee = eggData.model; hl.Parent = eggData.model
    local anchor = Instance.new("Part")
    anchor.Anchored = true; anchor.CanCollide = false
    anchor.CanQuery = false; anchor.CanTouch = false
    anchor.Transparency = 1; anchor.Size = Vector3.new(0.5, 0.5, 0.5)
    anchor.Position = pos; anchor.Parent = workspace
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 60); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = anchor; bb.Parent = anchor
    local nL = Instance.new("TextLabel")
    nL.Size = UDim2.new(1, 0, 0.5, 0); nL.BackgroundTransparency = 1
    nL.Text = "[" .. eggData.rarity .. "] " .. eggData.name .. weightStr
    nL.TextColor3 = color; nL.TextStrokeTransparency = 0.3
    nL.Font = Enum.Font.GothamBold; nL.TextSize = 13; nL.Parent = bb
    local dL = Instance.new("TextLabel")
    dL.Size = UDim2.new(1, 0, 0.5, 0); dL.Position = UDim2.new(0, 0, 0.5, 0)
    dL.BackgroundTransparency = 1; dL.Text = "0m"
    dL.TextColor3 = Color3.fromRGB(255, 255, 255)
    dL.TextStrokeTransparency = 0.5; dL.Font = Enum.Font.Gotham
    dL.TextSize = 11; dL.Parent = bb
    RenderedEggESP[eggData.model] = { Highlight=hl, Billboard=bb, Anchor=anchor, Dist=dL }
end
local function RefreshEggESP()
    if not state.espEgg then ClearTable(RenderedEggESP); return end
    for _, e in ipairs(ScanAllEggs()) do BuildEggESP(e) end
    for egg, data in pairs(RenderedEggESP) do
        if egg.Parent then
            local pos = GetEggPos(egg)
            if pos and data.Anchor then data.Anchor.Position = pos end
        else
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
            if data.Anchor then data.Anchor:Destroy() end
            RenderedEggESP[egg] = nil
        end
    end
end
local function BuildCandyESP(candy)
    if RenderedCandyESP[candy.part] then return end
    local color = Color3.fromRGB(255, 130, 30)
    if candy.isRitual then color = Color3.fromRGB(180, 80, 255)
    elseif candy.isPumpkin then color = Color3.fromRGB(255, 200, 50) end
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.6; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color; hl.OutlineColor = color
    hl.Adornee = candy.part; hl.Parent = candy.part
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 150, 0, 40); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = candy.part; bb.Parent = candy.part
    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(1, 0, 0.5, 0); nameL.BackgroundTransparency = 1
    nameL.Text = "Candy"; nameL.TextColor3 = color
    nameL.TextStrokeTransparency = 0.3; nameL.Font = Enum.Font.GothamBold
    nameL.TextSize = 12; nameL.Parent = bb
    local distL = Instance.new("TextLabel")
    distL.Size = UDim2.new(1, 0, 0.5, 0); distL.Position = UDim2.new(0, 0, 0.5, 0)
    distL.BackgroundTransparency = 1; distL.Text = "0m"
    distL.TextColor3 = Color3.fromRGB(255, 255, 255)
    distL.TextStrokeTransparency = 0.5; distL.Font = Enum.Font.Gotham
    distL.TextSize = 11; distL.Parent = bb
    RenderedCandyESP[candy.part] = { Highlight=hl, Billboard=bb, Dist=distL, Part=candy.part }
end
local function RefreshCandyESP()
    if not state.espCandy then ClearTable(RenderedCandyESP); return end
    local current = {}
    for _, c in ipairs(FindCandyList()) do
        current[c.part] = true
        BuildCandyESP(c)
    end
    for part, data in pairs(RenderedCandyESP) do
        if not current[part] or not part.Parent then
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
            RenderedCandyESP[part] = nil
        end
    end
end
local function BuildPlayerESP(plr)
    if plr == LocalPlayer then return end
    if RenderedPlayerESP[plr] then return end
    local char = plr.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.7; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = Color3.fromRGB(255, 60, 60)
    hl.OutlineColor = Color3.fromRGB(255, 60, 60)
    hl.Adornee = char; hl.Parent = char
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 50); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = hrp; bb.Parent = hrp
    local nL = Instance.new("TextLabel")
    nL.Size = UDim2.new(1, 0, 0.5, 0); nL.BackgroundTransparency = 1
    nL.Text = plr.Name; nL.TextColor3 = Color3.fromRGB(255, 60, 60)
    nL.TextStrokeTransparency = 0.3; nL.Font = Enum.Font.GothamBold
    nL.TextSize = 13; nL.Parent = bb
    local dL = Instance.new("TextLabel")
    dL.Size = UDim2.new(1, 0, 0.5, 0); dL.Position = UDim2.new(0, 0, 0.5, 0)
    dL.BackgroundTransparency = 1; dL.Text = "0m"
    dL.TextColor3 = Color3.fromRGB(255, 255, 255)
    dL.TextStrokeTransparency = 0.5; dL.Font = Enum.Font.Gotham
    dL.TextSize = 11; dL.Parent = bb
    RenderedPlayerESP[plr] = { Highlight=hl, Billboard=bb, Dist=dL, Char=char }
end
local function RefreshPlayerESP()
    if not state.espPlayer then ClearTable(RenderedPlayerESP); return end
    for _, plr in ipairs(Players:GetPlayers()) do BuildPlayerESP(plr) end
    for plr, data in pairs(RenderedPlayerESP) do
        if not plr.Parent or not plr.Character or plr.Character ~= data.Char then
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
            RenderedPlayerESP[plr] = nil
        end
    end
end
local function FindYinYangSockets()
    local list, seen = {}, {}
    local function add(obj)
        if seen[obj] or not obj:IsA("BasePart") then return end
        local n = obj.Name
        if n == "YinSocket" or n == "YangSocket" then
            seen[obj] = true
            table.insert(list, obj)
        end
    end
    local rsv = workspace:FindFirstChild("RitualSealVisuals")
    if rsv then for _, obj in ipairs(rsv:GetDescendants()) do add(obj) end end
    for _, obj in ipairs(workspace:GetDescendants()) do add(obj) end
    return list
end
local function BuildYinYangESP(socket)
    if RenderedYinYangESP[socket] then return end
    if not socket.Parent then return end
    local isYin = socket.Name == "YinSocket"
    local color = isYin and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(255, 220, 80)
    local label = isYin and "YIN SOCKET" or "YANG SOCKET"
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.5; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color; hl.OutlineColor = color
    hl.Adornee = socket; hl.Parent = socket
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 140, 0, 40); bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = socket; bb.Parent = socket
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0.5, 0); lbl.BackgroundTransparency = 1
    lbl.Text = label; lbl.TextColor3 = color
    lbl.TextStrokeTransparency = 0.3; lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14; lbl.Parent = bb
    local distL = Instance.new("TextLabel")
    distL.Size = UDim2.new(1, 0, 0.5, 0); distL.Position = UDim2.new(0, 0, 0.5, 0)
    distL.BackgroundTransparency = 1; distL.Text = "0m"
    distL.TextColor3 = Color3.fromRGB(255, 255, 255)
    distL.TextStrokeTransparency = 0.5; distL.Font = Enum.Font.Gotham
    distL.TextSize = 11; distL.Parent = bb
    RenderedYinYangESP[socket] = { Highlight=hl, Billboard=bb, Dist=distL, Socket=socket }
end
local function RefreshYinYangESP()
    if not state.espYinYang then
        for k, data in pairs(RenderedYinYangESP) do
            if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
            if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
            RenderedYinYangESP[k] = nil
        end
        return
    end
    local current = {}
    for _, socket in ipairs(FindYinYangSockets()) do
        current[socket] = true
        BuildYinYangESP(socket)
    end
    for sock, data in pairs(RenderedYinYangESP) do
        if not current[sock] or not sock.Parent then
            if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
            if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
            RenderedYinYangESP[sock] = nil
        end
    end
end

local Window = Ujayy:CreateWindow({
    Name              = "Ujayy",
    Subtitle          = "by Xnowplee",
    Theme             = "Blue",
    Folder            = "Ujayy",
    ToggleKey         = Enum.KeyCode.RightShift,
    LoadingTitle      = "Ujayy Script Hub",
    LoadingSubtitle   = "Ride A Pet | by Xnowplee",
})
Window:Tag({ Title = "V1.0.5" })

local function Notif(title, content, duration)
    Window:Notify({ Title = title, Content = content, Duration = duration or 3 })
end

Window:CreateHome({
    Title = "Welcome!",
    Subtitle = "Ujayy Script Hub",
    Author = "Xnowplee",
    ScriptName = "Ujayy | Ride A Pet",
    Status = "Online",
    Description = "Ujayy Script Hub untuk Ride A Pet.\nVersi V1.0.5 (Free) - by Xnowplee",
})

local MainTab  = Window:CreateTab("Main Script", "rbxassetid://6031075931")   -- home
local FarmTab  = Window:CreateTab("Farm", "rbxassetid://6031091004")          -- pickaxe
local SmartTab = Window:CreateTab("Smart Farm", "rbxassetid://6031265976")    -- sparkle
local CandyTab = Window:CreateTab("Farm Candy", "rbxassetid://6034684930")    -- candy
local IntTab   = Window:CreateTab("Integration", "rbxassetid://6031094667")   -- link
local UtilTab  = Window:CreateTab("Utility", "rbxassetid://6031280882")       -- settings
local InfoTab  = Window:CreateTab("Info", "rbxassetid://6031075925")          -- info

local AuthorSection = MainTab:CreateSection({ Title = "Author", Opened = false })
AuthorSection:CreateParagraph({ Title = "Xnowplee", Content = "Script Developer | V1.0.5 (Free) | discord.gg/6byStpCzv" })

local MoveSection = MainTab:CreateSection({ Title = "Movement", Opened = true })
local infJumpToggle = MoveSection:CreateToggle({
    Name = "Infinite Jump", Desc = "Enable infinite jump", Default = false,
    Callback = function(v) state.infJump = v end,
})
local speedSlider = MoveSection:CreateSlider({
    Name = "Speed Control", Desc = "Adjust walk speed", Min = 16, Max = 200, Default = 16,
    Callback = function(v)
        state.speedValue = v
        local hum = GetHumanoid(); if hum then hum.WalkSpeed = v end
    end,
})
local jumpSlider = MoveSection:CreateSlider({
    Name = "Jump Control", Desc = "Adjust jump power", Min = 50, Max = 500, Default = 50,
    Callback = function(v)
        state.jumpValue = v
        local hum = GetHumanoid(); if hum then hum.JumpPower = v end
    end,
})
MoveSection:CreateButton({
    Name = "Reset Semua", Desc = "Reset speed, jump, inf jump",
    Callback = function()
        state.infJump = false; state.speedValue = 16; state.jumpValue = 50
        local hum = GetHumanoid()
        if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
        infJumpToggle:Set(false)
        speedSlider:Set(16)
        jumpSlider:Set(50)
    end,
})
UserInputService.JumpRequest:Connect(function()
    if state.infJump then
        local hum = GetHumanoid(); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local ModeSection = FarmTab:CreateSection({ Title = "Mode Farm", Opened = true })
ModeSection:CreateToggle({
    Name = "Mutasi Kawah Dulu",
    Desc = "ON = Mutasi kawah (aman) | OFF = Instant bypass",
    Default = false,
    Callback = function(v)
        state.useMutation = v
        print("[Ujayy] Mode:", v and "MUTASI KAWAH" or "INSTANT BYPASS")
        Notif("Mode Farm", v and "Mutasi Kawah" or "Instant Bypass", 2)
    end,
})
ModeSection:CreateParagraph({
    Title = "Info Mode",
    Content = "ON = Pickup → Drop kawah → Tunggu → Balik → Claim\nOFF = Pickup → Spoof Attribute → Balik → Spam Claim",
})

local BypassSection = FarmTab:CreateSection({ Title = "Bypass Settings", Opened = false })
BypassSection:CreateSlider({ Name = "Spam Claim Count", Min = 1, Max = 50, Default = 20, Callback = function(v) state.instantSpam = v end })
BypassSection:CreateSlider({ Name = "Spam Delay (s)", Min = 0.02, Max = 0.5, Increment = 0.01, Default = 0.05, Callback = function(v) state.instantSpamDelay = v end })
BypassSection:CreateSlider({ Name = "BreakAt Offset (s)", Min = 0.5, Max = 30, Increment = 0.5, Default = 1, Callback = function(v) state.instantBreakOffset = v end })

local FarmSection = FarmTab:CreateSection({ Title = "Farm Single", Opened = true })
local function getEggOptions()
    local opts = {}
    for _, e in ipairs(ScanAllEggs()) do
        local w = e.weight and e.weight > 0 and string.format(" W:%.1f", e.weight) or ""
        table.insert(opts, "["..e.rarity.."] "..e.name..w)
    end
    return opts
end
local eggDropdown = FarmSection:CreateDropdown({
    Name = "Pilih Egg", Options = getEggOptions(), Default = nil,
    Callback = function(opt)
        if not opt then return end
        local cleanName = opt:gsub("^%[%w+%]%s*", ""):gsub(" W:[%d%.]+", ""):gsub(" W:", "")
        FarmSingle.SelectEgg(cleanName)
    end,
})
FarmSection:CreateButton({
    Name = "Refresh Egg List (Reset)",
    Callback = function()
        FarmSingle.Clear()
        eggDropdown:Refresh(getEggOptions())
    end,
})
FarmSection:CreateButton({ Name = "Start Farm (1x)", Callback = function() FarmSingle.Start() end })
FarmSection:CreateButton({ Name = "Stop Farm", Callback = function() FarmSingle.Stop() end })

local VolcanicSection = FarmTab:CreateSection({ Title = "Volcanic", Opened = false })
VolcanicSection:CreateToggle({
    Name = "Enable Noclip", Desc = "Anti-collision", Default = false,
    Callback = function(v)
        state.noclip = v
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide ~= nil then
                if v then part.CanCollide = false
                elseif part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
            end
        end
    end,
})
VolcanicSection:CreateButton({ Name = "TP ke TITIK EGG", Callback = function() TP(state.TITIK_EGG + Vector3.new(0, 5, 0)) end })
VolcanicSection:CreateButton({ Name = "Test PrepareVolcano", Callback = function()
    local ok = PrepareVolcano()
    print("[Ujayy] Volcanic:", ok and "Prepare OK" or "Prepare GAGAL")
end })

task.spawn(function() while task.wait(5) do pcall(function() eggDropdown:Refresh(getEggOptions()) end) end end)

local SmartSection = SmartTab:CreateSection({ Title = "Smart Farm", Opened = true })
SmartSection:CreateToggle({
    Name = "Enable Smart Auto Farm", Desc = "Auto cycle farm", Default = false,
    Callback = function(v) if v then SmartFarm.Start() else SmartFarm.Stop() end end,
})

local FilterSection = SmartTab:CreateSection({ Title = "Filter Rarity", Opened = false })
FilterSection:CreateDropdown({
    Name = "Rarity yang di-farm", Multi = true,
    Options = { "Epic", "Legendary", "Mythic", "Divine", "Ethereal" },
    Default = { "Epic", "Legendary", "Mythic", "Divine", "Ethereal" },
    Callback = function(list)
        SmartFarm.filterRarity = {}
        if type(list) == "table" then
            for _, v in ipairs(list) do SmartFarm.filterRarity[v] = true end
        end
    end,
})
FilterSection:CreateSlider({
    Name = "Min Weight", Desc = "Filter berat minimum", Min = 0, Max = 500, Default = 0,
    Callback = function(v) SmartFarm.minWeight = v end,
})

local PrioritySection = SmartTab:CreateSection({ Title = "Priority", Opened = false })
PrioritySection:CreateDropdown({
    Name = "Priority Mode", Options = { "Rarity", "Weight", "Nearest" }, Default = "Rarity",
    Callback = function(v) SmartFarm.priority = v end,
})
PrioritySection:CreateSlider({
    Name = "Cycle Delay", Desc = "Jeda antar siklus (detik)", Min = 0.5, Max = 10, Increment = 0.5, Default = 2,
    Callback = function(v) SmartFarm.cycleDelay = v end,
})

local CandySection = CandyTab:CreateSection({ Title = "Auto Candy", Opened = true })
CandySection:CreateToggle({
    Name = "Auto Collect Candy", Default = false,
    Callback = function(v)
        state.candyAutoCollect = v
        if v then
            if not state.baseCandyPos then
                local bp = AutoGetBaseplate()
                if bp then state.baseCandyPos = bp end
            end
            CandyApplySnapshot()
            CandyCycleLoop()
            Notif("Auto Candy", "Started!", 2)
        end
    end,
})
CandySection:CreateToggle({ Name = "Loop Mode", Desc = "Ulang terus", Default = false, Callback = function(v) state.candyLoopMode = v end })
CandySection:CreateToggle({ Name = "Balik Base Setelah Pickup", Default = true, Callback = function(v) state.candyReturnBase = v end })
CandySection:CreateToggle({ Name = "Include Pumpkin Drop", Default = true, Callback = function(v) state.candyIncludePumpkin = v end })
CandySection:CreateToggle({ Name = "Include Ritual Drop", Default = false, Callback = function(v) state.candyIncludeRitual = v end })

local CandyDelaySection = CandyTab:CreateSection({ Title = "Delay", Opened = false })
CandyDelaySection:CreateSlider({ Name = "Pickup Delay", Min = 0.05, Max = 1, Increment = 0.05, Default = 0.15, Callback = function(v) state.candyPickupDelay = v end })
CandyDelaySection:CreateSlider({ Name = "Antar Candy Delay", Min = 0.5, Max = 5, Increment = 0.5, Default = 1.5, Callback = function(v) state.candyBetweenDelay = v end })
CandyDelaySection:CreateSlider({ Name = "Cooldown Per Candy", Min = 0.5, Max = 5, Increment = 0.5, Default = 2, Callback = function(v) state.candyCooldownPerCandy = v end })
CandyDelaySection:CreateButton({ Name = "Refresh Candy Snapshot", Callback = function() CandyApplySnapshot() end })
CandyDelaySection:CreateButton({
    Name = "Scan Candy Sekarang",
    Callback = function()
        local n = #FindCandyList()
        print("[Ujayy] Candy:", n, "candy ditemukan")
        Notif("Scan Candy", tostring(n) .. " candy ditemukan", 3)
    end,
})

local EspSection = IntTab:CreateSection({ Title = "ESP", Opened = true })
EspSection:CreateToggle({
    Name = "ESP Egg (Rarity + Weight)", Default = false,
    Callback = function(v)
        state.espEgg = v
        if v then RefreshEggESP() else ClearTable(RenderedEggESP) end
    end,
})
EspSection:CreateToggle({
    Name = "ESP Candy", Default = false,
    Callback = function(v)
        state.espCandy = v
        if v then RefreshCandyESP() else ClearTable(RenderedCandyESP) end
    end,
})
EspSection:CreateToggle({
    Name = "ESP Player", Default = false,
    Callback = function(v)
        state.espPlayer = v
        if v then RefreshPlayerESP() else ClearTable(RenderedPlayerESP) end
    end,
})
EspSection:CreateToggle({
    Name = "ESP YinYang Socket", Default = false,
    Callback = function(v)
        state.espYinYang = v
        RefreshYinYangESP()
        if v then
            local n = #FindYinYangSockets()
            Notif("ESP YinYang", "Found " .. n .. " socket(s)", 3)
        end
    end,
})
EspSection:CreateButton({
    Name = "Debug YinYang Sockets",
    Callback = function()
        local sockets = FindYinYangSockets()
        print("═══ YinYang Debug ═══")
        print("Total:", #sockets)
        for i, s in ipairs(sockets) do print(i, s:GetFullName()) end
        print("RitualSealVisuals exists:", workspace:FindFirstChild("RitualSealVisuals") ~= nil)
        print("═══════════════════")
        Notif("YinYang Debug", "Found " .. #sockets .. " socket(s)", 4)
    end,
})

local BaseSection = IntTab:CreateSection({ Title = "Simpen Base", Opened = false })
BaseSection:CreateButton({
    Name = "Simpen Base Buat Egg",
    Callback = function()
        local hrp = GetChar()
        if hrp then state.baseEggPos = hrp.Position end
        Notif("Base Saved", "Posisi egg base disimpen", 2)
    end,
})
BaseSection:CreateButton({
    Name = "Simpen Base Buat Candy",
    Callback = function()
        local hrp = GetChar()
        if hrp then state.baseCandyPos = hrp.Position end
        Notif("Base Saved", "Posisi candy base disimpen", 2)
    end,
})

local WebhookSection = IntTab:CreateSection({ Title = "Webhook Discord", Opened = false })
WebhookSection:CreateInput({
    Name = "Webhook URL", Placeholder = "https://discord.com/api/webhooks/...",
    Callback = function(t) state.webhookURL = t end,
})
WebhookSection:CreateDropdown({
    Name = "Notif Rarity Minimum",
    Options = { "Epic", "Legendary", "Mythic", "Divine", "Ethereal" }, Default = "Mythic",
    Callback = function(v) state.webhookRarity = v end,
})
WebhookSection:CreateButton({
    Name = "Test Webhook",
    Callback = function()
        if state.webhookURL == "" then Notif("Webhook", "URL kosong!", 2); return end
        SendWebhook("Test Egg", state.webhookRarity, 99.9)
        Notif("Webhook Test", "Terkirim ke Discord", 2)
    end,
})

local ServerSection = UtilTab:CreateSection({ Title = "Server", Opened = true })
ServerSection:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local ok, servers = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if ok and servers and servers.data then
            for _, s in ipairs(servers.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                    return
                end
            end
        end
    end,
})
ServerSection:CreateButton({ Name = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end })

local PerfSection = UtilTab:CreateSection({ Title = "Performance", Opened = false })
PerfSection:CreateToggle({
    Name = "No Lag", Default = false,
    Callback = function(v)
        state.noLag = v
        if v then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
                    obj.Enabled = false
                end
            end
        end
    end,
})
PerfSection:CreateToggle({
    Name = "Boost FPS", Default = false,
    Callback = function(v)
        state.boostFps = v
        if v then settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end
    end,
})
PerfSection:CreateToggle({
    Name = "Hide All Garden", Default = false,
    Callback = function(v)
        state.hideGarden = v
        local toHide = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (string.find(string.lower(obj.Name), "garden") or string.find(string.lower(obj.Name), "plant")) then
                table.insert(toHide, obj)
            end
        end
        if v then
            for _, obj in ipairs(toHide) do pcall(function() obj.Parent = nil end) end
        else
            Notif("Perf", "Hide Garden OFF — perlu rejoin", 3)
        end
    end,
})

local TPSection = UtilTab:CreateSection({ Title = "Teleport", Opened = true })
TPSection:CreateButton({ Name = "TP ke Base", Callback = function() local bp = AutoGetBaseplate() if bp then TP(bp) end end })
TPSection:CreateButton({ Name = "TP ke Volcano", Callback = function() TP(state.KAWAH + Vector3.new(0, 10, 0)) end })
TPSection:CreateButton({ Name = "TP ke TITIK EGG", Callback = function() TP(state.TITIK_EGG + Vector3.new(0, 5, 0)) end })

local AboutSection = InfoTab:CreateSection({ Title = "About", Opened = false })
AboutSection:CreateParagraph({
    Title = "Ujayy | Ride A Pet | Roblox",
    Content = "Version: V1.0.5 (Free)\nAuthor: Xnowplee\nUI: Ujayy UI v2\nLogic: ported from p.lua",
})

local DiscordSection = InfoTab:CreateSection({ Title = "Discord Community", Opened = false })
DiscordSection:CreateParagraph({ Title = "Join Our Discord", Content = "https://discord.gg/6byStpCzv" })
DiscordSection:CreateButton({
    Name = "Copy Discord Link",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/6byStpCzv")
            Notif("Discord", "Link disalin!", 2)
        else
            Notif("Discord", "Executor tidak support setclipboard", 3)
        end
    end,
})

local DebugSection = InfoTab:CreateSection({ Title = "Debug", Opened = false })
DebugSection:CreateButton({
    Name = "Debug All (Print Info)",
    Callback = function()
        print("═══ Ujayy Debug ═══")
        print("Version: V1.0.5")
        print("Mode:", state.useMutation and "MUTASI KAWAH" or "INSTANT BYPASS")
        print("Eggs found:", #ScanAllEggs())
        print("Candies found:", #FindCandyList())
        print("YinYang sockets:", #FindYinYangSockets())
        print("Players:", #Players:GetPlayers())
        print("Speed:", state.speedValue, "| Jump:", state.jumpValue)
        print("Inf Jump:", state.infJump, "| Noclip:", state.noclip)
        print("═══════════════════════")
        Notif("Debug", "Info printed", 3)
    end,
})
DebugSection:CreateButton({ Name = "Test Notif", Callback = function() Notif("Ujayy", "Notifikasi berfungsi!", 3) end })
DebugSection:CreateButton({
    Name = "Test Dialog",
    Callback = function()
        Window:Dialog({
            Title = "Dialog Test", Content = "Ini contoh dialog bawaan Ujayy UI.",
            Buttons = { { Title = "OK", Variant = "Primary" } },
        })
    end,
})
DebugSection:CreateButton({
    Name = "Test Bypass (Sekali)",
    Callback = function()
        local count = ApplyInstantBypass()
        Notif("Test Bypass", "Spoof " .. count .. " egg", 3)
        task.wait(0.3)
        local ok = FireInstantClaim()
        Notif("Test Bypass", "Claim: " .. tostring(ok), 3)
    end,
})

Window:CreateSettings()

RunService.Heartbeat:Connect(function()
    local hrp = GetChar()
    if not hrp then return end
    for _, data in pairs(RenderedEggESP) do
        if data.Dist and data.Anchor and data.Anchor.Parent then
            data.Dist.Text = string.format("%.0fm", (data.Anchor.Position - hrp.Position).Magnitude)
        end
    end
    for _, data in pairs(RenderedPlayerESP) do
        if data.Dist and data.Char then
            local h = data.Char:FindFirstChild("HumanoidRootPart")
            if h then data.Dist.Text = string.format("%.0fm", (h.Position - hrp.Position).Magnitude) end
        end
    end
    for _, data in pairs(RenderedCandyESP) do
        if data.Dist and data.Part and data.Part.Parent then
            data.Dist.Text = string.format("%.0fm", (data.Part.Position - hrp.Position).Magnitude)
        end
    end
    for _, data in pairs(RenderedYinYangESP) do
        if data.Dist and data.Socket and data.Socket.Parent then
            data.Dist.Text = string.format("%.0fm", (data.Socket.Position - hrp.Position).Magnitude)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if state.espEgg then pcall(RefreshEggESP) end
        if state.espCandy then pcall(RefreshCandyESP) end
        if state.espPlayer then pcall(RefreshPlayerESP) end
        if state.espYinYang then pcall(RefreshYinYangESP) end
        if state.noclip then
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end
end)

print("[Ujayy] Loaded — V1.0.5 | Ujayy UI v2 + logic p.lua")
print("[Ujayy] All systems ready!")
