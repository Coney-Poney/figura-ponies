---@diagnostic disable: duplicate-set-field
---Contains functions which Figura adds to the default Lua "math" library table.
---@class math
---@field playerScale number The constant of the player scaling related to the world.
---@field worldScale number The constant of the world scaling related with the player.
math={}
---Rounds the given number to the nearest whole integer.
---@param value number
---@return number
function math.round(value) end
---Returns the sign of the given number. Returns 1 if the number is positive, -1 if it's negative, and 0 if it's 0.
---@param value number
---@return number
function math.sign(value) end
---Maps the given value from one range to another. For example, if you have a value of 20 in the range 0-200, and you want to map it to the range 100-200, the result will be 110.
---@param value number
---@param oldMin number
---@param oldMax number
---@param newMin number
---@param newMax number
---@return number
function math.map(value, oldMin, oldMax, newMin, newMax) end
---Returns the shortest angle between two angles. For example, if you have an angle of 350 degrees and you want to get the shortest angle between it and 0 degrees, the result will be 10 degrees.
---@param from number
---@param to number
---@return number
function math.shortAngle(from, to) end
---Linearly interpolates from its first argument to its second argument, with the third argument as the parameter. Works on both regular numbers and vectors.
---@param a number
---@param b number
---@param t number
---@return number
function math.lerp(a, b, t) end
---Linearly interpolates from its first argument to its second argument, with the third argument as the parameter. Works on both regular numbers and vectors.
---@param a Vector2
---@param b Vector2
---@param t number
---@return Vector2
function math.lerp(a, b, t) end
---Linearly interpolates from its first argument to its second argument, with the third argument as the parameter. Works on both regular numbers and vectors.
---@param a Vector3
---@param b Vector3
---@param t number
---@return Vector3
function math.lerp(a, b, t) end
---Linearly interpolates from its first argument to its second argument, with the third argument as the parameter. Works on both regular numbers and vectors.
---@param a Vector4
---@param b Vector4
---@param t number
---@return Vector4
function math.lerp(a, b, t) end
---Linearly interpolates from its first argument to its second argument, with the third argument as the parameter. Works on both regular numbers and vectors.
---@param a Vector5
---@param b Vector5
---@param t number
---@return Vector5
function math.lerp(a, b, t) end
---Linearly interpolates from its first argument to its second argument, with the third argument as the parameter. Works on both regular numbers and vectors.
---@param a Vector6
---@param b Vector6
---@param t number
---@return Vector6
function math.lerp(a, b, t) end
---Similar to the default lerp function, but numbers are limited to the range of 0-360. Lerp is done towards the shortest angle. For example, a lerp of 340 and 20, with factor of 0.75, will return 310.
---@param a number
---@param b number
---@param t number
---@return number
function math.lerpAngle(a, b, t) end
---Clamps the given value between min and max.
---@param value number
---@param min number
---@param max number
---@return number
function math.clamp(value, min, max) end
