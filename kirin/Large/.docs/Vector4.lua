---@diagnostic disable: duplicate-set-field
---A vector that holds 4 numbers. Can be created using functions in the "vectors" api.
---@class Vector4
---@field x number The first coordinate of this vector. Can also be gotten with the indices "r" and [1].
---@field y number The second coordinate of this vector. Can also be gotten with the indices "g" and [2].
---@field z number The third coordinate of this vector. Can also be gotten with the indices "b" and [3].
---@field w number The fourth coordinate of this vector. Can also be gotten with the indices "a" and [4].
---@operator add(Vector4):Vector4
---@operator add(number):Vector4
---@operator sub(Vector4):Vector4
---@operator sub(number):Vector4
---@operator mul(Vector4):Vector4
---@operator mul(number):Vector4
---@operator div(Vector4):Vector4
---@operator div(number):Vector4
---@operator mod(Vector4):Vector4
---@operator mod(number):Vector4
---@operator unm:Vector4
local Vector4={}
---Adds the given vector or values to this one, and returns self for chaining.
---@param vec Vector4
---@return Vector4
function Vector4:add(vec) end
---Adds the given vector or values to this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function Vector4:add(x, y, z, w) end
---Returns the length of this vector.
---@return number
function Vector4:length() end
---Returns a copy of this vector with its values rounded down.
---@return Vector4
function Vector4:floor() end
---Returns a copy of this vector with its values rounded up.
---@return Vector4
function Vector4:ceil() end
---Scales this vector by the given factor, and returns self for chaining.
---@param factor number
---@return Vector4
function Vector4:scale(factor) end
---Offsets this vector by the given factor, adding the factor to all components, and returns self for chaining.
---@param factor number
---@return Vector4
function Vector4:offset(factor) end
---Transforms this vector by the given matrix, and returns self for chaining.
---@param mat Matrix4
---@return Vector4
function Vector4:transform(mat) end
---Returns the dot product of this vector with the other.
---@param vec Vector4
---@return number
function Vector4:dot(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param vec Vector4
---@return Vector4
function Vector4:set(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function Vector4:set(x, y, z, w) end
---Creates and returns a copy of this vector.
---@return Vector4
function Vector4:copy() end
---Modifies this vector so that its length is 1, unless its length was originally 0. Returns self for chaining.
---@return Vector4
function Vector4:normalize() end
---Resets this vector back to being all zeroes, and returns itself for chaining.
---@return Vector4
function Vector4:reset() end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param vec Vector4
---@return Vector4
function Vector4:reduce(vec) end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function Vector4:reduce(x, y, z, w) end
---Returns a copy of this vector with length 1, unless its length was originally 0.
---@return Vector4
function Vector4:normalized() end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param vec Vector4
---@return Vector4
function Vector4:sub(vec) end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function Vector4:sub(x, y, z, w) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param vec Vector4
---@return Vector4
function Vector4:mul(vec) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function Vector4:mul(x, y, z, w) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param vec Vector4
---@return Vector4
function Vector4:div(vec) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function Vector4:div(x, y, z, w) end
---Returns a modified copy of this vector, with its length clamped from minLength to maxLength. If the vector has length zero, then the copy does too.
---@param minLength number
---@param maxLength number
---@return Vector4
function Vector4:clamped(minLength, maxLength) end
---Returns a copy of this vector, in radians.
---@return Vector4
function Vector4:toRad() end
---Returns a copy of this vector, in degrees.
---@return Vector4
function Vector4:toDeg() end
---Returns the length of this vector squared. Suitable when you only care about relative lengths, because it avoids a square root.
---@return number
function Vector4:lengthSquared() end
---Modifies this vector so that its length is between minLength and maxLength. If the vector has length zero, it is unmodified. Returns self for chaining.
---@param minLength number
---@param maxLength number
---@return Vector4
function Vector4:clampLength(minLength, maxLength) end
---Calls the given function on each element of this vector, and sets the values of the vector to the returns. Returns self for chaining.
---@param func function
---@return Vector4
function Vector4:applyFunc(func) end
