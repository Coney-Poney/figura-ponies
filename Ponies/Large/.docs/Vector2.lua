---@diagnostic disable: duplicate-set-field
---A vector that holds 2 numbers. Can be created using functions in the "vectors" api.
---@class Vector2
---@field x number The first coordinate of this vector. Can also be gotten with the indices "r" and [1].
---@field y number The second coordinate of this vector. Can also be gotten with the indices "g" and [2].
---@operator add(Vector2):Vector2
---@operator add(number):Vector2
---@operator sub(Vector2):Vector2
---@operator sub(number):Vector2
---@operator mul(Vector2):Vector2
---@operator mul(number):Vector2
---@operator div(Vector2):Vector2
---@operator div(number):Vector2
---@operator mod(Vector2):Vector2
---@operator mod(number):Vector2
---@operator unm:Vector2
local Vector2={}
---Adds the given vector or values to this one, and returns self for chaining.
---@param vec Vector2
---@return Vector2
function Vector2:add(vec) end
---Adds the given vector or values to this one, and returns self for chaining.
---@param x number
---@param y number
---@return Vector2
function Vector2:add(x, y) end
---Returns the length of this vector.
---@return number
function Vector2:length() end
---Returns a copy of this vector with its values rounded down.
---@return Vector2
function Vector2:floor() end
---Returns a copy of this vector with its values rounded up.
---@return Vector2
function Vector2:ceil() end
---Scales this vector by the given factor, and returns self for chaining.
---@param factor number
---@return Vector2
function Vector2:scale(factor) end
---Offsets this vector by the given factor, adding the factor to all components, and returns self for chaining.
---@param factor number
---@return Vector2
function Vector2:offset(factor) end
---Transforms this vector by the given matrix, and returns self for chaining.
---@param mat Matrix2
---@return Vector2
function Vector2:transform(mat) end
---Returns the dot product of this vector with the other.
---@param vec Vector2
---@return number
function Vector2:dot(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param vec Vector2
---@return Vector2
function Vector2:set(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param x number
---@param y number
---@return Vector2
function Vector2:set(x, y) end
---Creates and returns a copy of this vector.
---@return Vector2
function Vector2:copy() end
---Modifies this vector so that its length is 1, unless its length was originally 0. Returns self for chaining.
---@return Vector2
function Vector2:normalize() end
---Resets this vector back to being all zeroes, and returns itself for chaining.
---@return Vector2
function Vector2:reset() end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param vec Vector2
---@return Vector2
function Vector2:reduce(vec) end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@return Vector2
function Vector2:reduce(x, y) end
---Returns a copy of this vector with length 1, unless its length was originally 0.
---@return Vector2
function Vector2:normalized() end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param vec Vector2
---@return Vector2
function Vector2:sub(vec) end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param x number
---@param y number
---@return Vector2
function Vector2:sub(x, y) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param vec Vector2
---@return Vector2
function Vector2:mul(vec) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param x number
---@param y number
---@return Vector2
function Vector2:mul(x, y) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param vec Vector2
---@return Vector2
function Vector2:div(vec) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@return Vector2
function Vector2:div(x, y) end
---Returns a modified copy of this vector, with its length clamped from minLength to maxLength. If the vector has length zero, then the copy does too.
---@param minLength number
---@param maxLength number
---@return Vector2
function Vector2:clamped(minLength, maxLength) end
---Returns a copy of this vector, in radians.
---@return Vector2
function Vector2:toRad() end
---Returns a copy of this vector, in degrees.
---@return Vector2
function Vector2:toDeg() end
---Returns the length of this vector squared. Suitable when you only care about relative lengths, because it avoids a square root.
---@return number
function Vector2:lengthSquared() end
---Modifies this vector so that its length is between minLength and maxLength. If the vector has length zero, it is unmodified. Returns self for chaining.
---@param minLength number
---@param maxLength number
---@return Vector2
function Vector2:clampLength(minLength, maxLength) end
---Calls the given function on each element of this vector, and sets the values of the vector to the returns. Returns self for chaining.
---@param func function
---@return Vector2
function Vector2:applyFunc(func) end
