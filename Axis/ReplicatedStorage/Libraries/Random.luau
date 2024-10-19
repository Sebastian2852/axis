--[=[
    @class RandomLib
    @tag library
]=]
local RandomLib = {}
RandomLib.__index = RandomLib

--[=[
The roblox RandomLib object

@within RandomLib
@prop _Object Random
@private
]=]
RandomLib._Object = nil

--[=[
    Create a new RandomLib instance. If no seed is provided a random one is used. See [here](https://create.roblox.com/docs/reference/engine/datatypes/Random#new)
    @param Seed number?
    @return RandomLib
]=]
function RandomLib.new(Seed :number?)
    local self = setmetatable({}, RandomLib)
    self._Object = Random.new(Seed)
    return self
end

--[=[
    Generate a random number between `Min` and `Max`

    @param Min number
    @param Max number

    @return number
]=]
function RandomLib:GenerateNumber(Min :number, Max :number) :number
    if Min >= Max then
        error("Min must be less than max (Min = "..tostring(Min).."; Max = "..tostring(Max)..")")
        return 0
    end
    return self._Object:NextNumber(Min, Max)
end

--[=[
    Generate a set of random integer between `Min` and `Max` and returns them as a table

    @param Min number
    @param Max number
    @param Amount number

    @return {number}
]=]
function RandomLib:GenerateIntegers(Amount :number, Min :number, Max :number) :{number}
    local Generated = {}
    for Count = 1, Amount do
        table.insert(Generated, self._Object:NextInteger(Min, Max))
    end
    return Generated
end

--[=[
    Generate a random integer between `Min` and `Max`

    @param Min number
    @param Max number
    @param Amount number

    @return number
]=]
function RandomLib:GenerateInteger(Min :number, Max :number, Amount :number) :number
    return self._Object:NextInteger(Min, Max)
end

--[=[
    Generates a random unit vector with a random direction. Return vectors are uniformly distributed over the unit sphere.
    @return Vector3
]=]
function RandomLib:GenerateUnitVector() :Vector3
    return self._Object:NextUnitVector()
end

--[=[
    Set a new seed for RNG. If none is provided a random one is used. See [here](https://create.roblox.com/docs/reference/engine/datatypes/Random#new)
    @param Seed number?
]=]
function RandomLib:ResetSeed(Seed :number?)
    self._Object = Random.new(Seed)
end

--[=[
    Delete all data held by the instance
]=]
function RandomLib:Destroy()
    self._Object = nil
end


return RandomLib

