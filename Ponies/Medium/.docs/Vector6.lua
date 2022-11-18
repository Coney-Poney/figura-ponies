---@diagnostic disable: duplicate-set-field
---A vector that holds 6 numbers. Can be created using functions in the "vectors" api.
---@class Vector6
---@field x number The first coordinate of this vector. Can also be gotten with the indices "r" and [1].
---@field y number The second coordinate of this vector. Can also be gotten with the indices "g" and [2].
---@field z number The third coordinate of this vector. Can also be gotten with the indices "b" and [3].
---@field w number The fourth coordinate of this vector. Can also be gotten with the indices "a" and [4].
---@field t number The fifth coordinate of this vector. Can also be gotten with the index [5].
---@field h number The sixth coordinate of this vector. Can also be gotten with the index [6].
---@operator add(Vector6):Vector6
---@operator add(number):Vector6
---@operator sub(Vector6):Vector6
---@operator sub(number):Vector6
---@operator mul(Vector6):Vector6
---@operator mul(number):Vector6
---@operator div(Vector6):Vector6
---@operator div(number):Vector6
---@operator mod(Vector6):Vector6
---@operator mod(number):Vector6
---@operator unm:Vector6
local Vector6={}
---Adds the given vector or values to this one, and returns self for chaining.
---@param vec Vector6
---@return Vector6
function Vector6:add(vec) end
---Adds the given vector or values to this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function Vector6:add(x, y, z, w, t, h) end
---Returns the length of this vector.
---@return number
function Vector6:length() end
---Returns a copy of this vector with its values rounded down.
---@return Vector6
function Vector6:floor() end
---Returns a copy of this vector with its values rounded up.
---@return Vector6
function Vector6:ceil() end
---Scales this vector by the given factor, and returns self for chaining.
---@param factor number
---@return Vector6
function Vector6:scale(factor) end
---Offsets this vector by the given factor, adding the factor to all components, and returns self for chaining.
---@param factor number
---@return Vector6
function Vector6:offset(factor) end
---Returns the dot product of this vector with the other.
---@param vec Vector6
---@return number
function Vector6:dot(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param vec Vector6
---@return Vector6
function Vector6:set(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function Vector6:set(x, y, z, w, t, h) end
---Creates and returns a copy of this vector.
---@return Vector6
function Vector6:copy() end
---Modifies this vector so that its length is 1, unless its length was originally 0. Returns self for chaining.
---@return Vector6
function Vector6:normalize() end
---Resets this vector back to being all zeroes, and returns itself for chaining.
---@return Vector6
function Vector6:reset() end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param vec Vector6
---@return Vector6
function Vector6:reduce(vec) end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function Vector6:reduce(x, y, z, w, t, h) end
---Returns a copy of this vector with length 1, unless its length was originally 0.
---@return Vector6
function Vector6:normalized() end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param vec Vector6
---@return Vector6
function Vector6:sub(vec) end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function Vector6:sub(x, y, z, w, t, h) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param vec Vector6
---@return Vector6
function Vector6:mul(vec) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function Vector6:mul(x, y, z, w, t, h) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param vec Vector6
---@return Vector6
function Vector6:div(vec) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function Vector6:div(x, y, z, w, t, h) end
---Returns a modified copy of this vector, with its length clamped from minLength to maxLength. If the vector has length zero, then the copy does too.
---@param minLength number
---@param maxLength number
---@return Vector6
function Vector6:clamped(minLength, maxLength) end
---Returns a copy of this vector, in radians.
---@return Vector6
function Vector6:toRad() end
---Returns a copy of this vector, in degrees.
---@return Vector6
function Vector6:toDeg() end
---Returns the length of this vector squared. Suitable when you only care about relative lengths, because it avoids a square root.
---@return number
function Vector6:lengthSquared() end
---Modifies this vector so that its length is between minLength and maxLength. If the vector has length zero, it is unmodified. Returns self for chaining.
---@param minLength number
---@param maxLength number
---@return Vector6
function Vector6:clampLength(minLength, maxLength) end
---Calls the given function on each element of this vector, and sets the values of the vector to the returns. Returns self for chaining.
---@param func function
---@return Vector6
function Vector6:applyFunc(func) end
