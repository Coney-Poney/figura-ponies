---@diagnostic disable: duplicate-set-field
---A vector that holds 5 numbers. Can be created using functions in the "vectors" api.
---@class Vector5
---@field x number The first coordinate of this vector. Can also be gotten with the indices "r" and [1].
---@field y number The second coordinate of this vector. Can also be gotten with the indices "g" and [2].
---@field z number The third coordinate of this vector. Can also be gotten with the indices "b" and [3].
---@field w number The fourth coordinate of this vector. Can also be gotten with the indices "a" and [4].
---@field t number The fifth coordinate of this vector. Can also be gotten with the index [5].
---@operator add(Vector5):Vector5
---@operator add(number):Vector5
---@operator sub(Vector5):Vector5
---@operator sub(number):Vector5
---@operator mul(Vector5):Vector5
---@operator mul(number):Vector5
---@operator div(Vector5):Vector5
---@operator div(number):Vector5
---@operator mod(Vector5):Vector5
---@operator mod(number):Vector5
---@operator unm:Vector5
local Vector5={}
---Adds the given vector or values to this one, and returns self for chaining.
---@param vec Vector5
---@return Vector5
function Vector5:add(vec) end
---Adds the given vector or values to this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function Vector5:add(x, y, z, w, t) end
---Returns the length of this vector.
---@return number
function Vector5:length() end
---Returns a copy of this vector with its values rounded down.
---@return Vector5
function Vector5:floor() end
---Returns a copy of this vector with its values rounded up.
---@return Vector5
function Vector5:ceil() end
---Scales this vector by the given factor, and returns self for chaining.
---@param factor number
---@return Vector5
function Vector5:scale(factor) end
---Offsets this vector by the given factor, adding the factor to all components, and returns self for chaining.
---@param factor number
---@return Vector5
function Vector5:offset(factor) end
---Returns the dot product of this vector with the other.
---@param vec Vector5
---@return number
function Vector5:dot(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param vec Vector5
---@return Vector5
function Vector5:set(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function Vector5:set(x, y, z, w, t) end
---Creates and returns a copy of this vector.
---@return Vector5
function Vector5:copy() end
---Modifies this vector so that its length is 1, unless its length was originally 0. Returns self for chaining.
---@return Vector5
function Vector5:normalize() end
---Resets this vector back to being all zeroes, and returns itself for chaining.
---@return Vector5
function Vector5:reset() end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param vec Vector5
---@return Vector5
function Vector5:reduce(vec) end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function Vector5:reduce(x, y, z, w, t) end
---Returns a copy of this vector with length 1, unless its length was originally 0.
---@return Vector5
function Vector5:normalized() end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param vec Vector5
---@return Vector5
function Vector5:sub(vec) end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function Vector5:sub(x, y, z, w, t) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param vec Vector5
---@return Vector5
function Vector5:mul(vec) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function Vector5:mul(x, y, z, w, t) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param vec Vector5
---@return Vector5
function Vector5:div(vec) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function Vector5:div(x, y, z, w, t) end
---Returns a modified copy of this vector, with its length clamped from minLength to maxLength. If the vector has length zero, then the copy does too.
---@param minLength number
---@param maxLength number
---@return Vector5
function Vector5:clamped(minLength, maxLength) end
---Returns a copy of this vector, in radians.
---@return Vector5
function Vector5:toRad() end
---Returns a copy of this vector, in degrees.
---@return Vector5
function Vector5:toDeg() end
---Returns the length of this vector squared. Suitable when you only care about relative lengths, because it avoids a square root.
---@return number
function Vector5:lengthSquared() end
---Modifies this vector so that its length is between minLength and maxLength. If the vector has length zero, it is unmodified. Returns self for chaining.
---@param minLength number
---@param maxLength number
---@return Vector5
function Vector5:clampLength(minLength, maxLength) end
---Calls the given function on each element of this vector, and sets the values of the vector to the returns. Returns self for chaining.
---@param func function
---@return Vector5
function Vector5:applyFunc(func) end
