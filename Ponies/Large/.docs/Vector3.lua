---@diagnostic disable: duplicate-set-field
---A vector that holds 3 numbers. Can be created using functions in the "vectors" api.
---@class Vector3
---@field x number The first coordinate of this vector. Can also be gotten with the indices "r" and [1].
---@field y number The second coordinate of this vector. Can also be gotten with the indices "g" and [2].
---@field z number The third coordinate of this vector. Can also be gotten with the indices "b" and [3].
---@operator add(Vector3):Vector3
---@operator add(number):Vector3
---@operator sub(Vector3):Vector3
---@operator sub(number):Vector3
---@operator mul(Vector3):Vector3
---@operator mul(number):Vector3
---@operator div(Vector3):Vector3
---@operator div(number):Vector3
---@operator mod(Vector3):Vector3
---@operator mod(number):Vector3
---@operator unm:Vector3
local Vector3={}
---Adds the given vector or values to this one, and returns self for chaining.
---@param vec Vector3
---@return Vector3
function Vector3:add(vec) end
---Adds the given vector or values to this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Vector3:add(x, y, z) end
---Returns the length of this vector.
---@return number
function Vector3:length() end
---Returns a copy of this vector with its values rounded down.
---@return Vector3
function Vector3:floor() end
---Returns a copy of this vector with its values rounded up.
---@return Vector3
function Vector3:ceil() end
---Scales this vector by the given factor, and returns self for chaining.
---@param factor number
---@return Vector3
function Vector3:scale(factor) end
---Offsets this vector by the given factor, adding the factor to all components, and returns self for chaining.
---@param factor number
---@return Vector3
function Vector3:offset(factor) end
---Transforms this vector by the given matrix, and returns self for chaining.
---@param mat Matrix3
---@return Vector3
function Vector3:transform(mat) end
---Returns the dot product of this vector with the other.
---@param vec Vector3
---@return number
function Vector3:dot(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param vec Vector3
---@return Vector3
function Vector3:set(vec) end
---Sets this vector to have the given values. Nil values are treated as zero. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Vector3:set(x, y, z) end
---Creates and returns a copy of this vector.
---@return Vector3
function Vector3:copy() end
---Modifies this vector so that its length is 1, unless its length was originally 0. Returns self for chaining.
---@return Vector3
function Vector3:normalize() end
---Resets this vector back to being all zeroes, and returns itself for chaining.
---@return Vector3
function Vector3:reset() end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param vec Vector3
---@return Vector3
function Vector3:reduce(vec) end
---Reduces this vector modulo the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Vector3:reduce(x, y, z) end
---Returns a copy of this vector with length 1, unless its length was originally 0.
---@return Vector3
function Vector3:normalized() end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param vec Vector3
---@return Vector3
function Vector3:sub(vec) end
---Subtracts the given vector or values from this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Vector3:sub(x, y, z) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param vec Vector3
---@return Vector3
function Vector3:mul(vec) end
---Multiplies the given vector or values into this one, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Vector3:mul(x, y, z) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param vec Vector3
---@return Vector3
function Vector3:div(vec) end
---Divides this vector by the given vector or values, and returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Vector3:div(x, y, z) end
---Returns a modified copy of this vector, with its length clamped from minLength to maxLength. If the vector has length zero, then the copy does too.
---@param minLength number
---@param maxLength number
---@return Vector3
function Vector3:clamped(minLength, maxLength) end
---Sets this vector to the cross product of itself and the other vector. Returns self for chaining.
---@param other Vector3
---@return Vector3
function Vector3:cross(other) end
---Returns a copy of this vector, in radians.
---@return Vector3
function Vector3:toRad() end
---Returns a copy of this vector, in degrees.
---@return Vector3
function Vector3:toDeg() end
---Returns the length of this vector squared. Suitable when you only care about relative lengths, because it avoids a square root.
---@return number
function Vector3:lengthSquared() end
---Modifies this vector so that its length is between minLength and maxLength. If the vector has length zero, it is unmodified. Returns self for chaining.
---@param minLength number
---@param maxLength number
---@return Vector3
function Vector3:clampLength(minLength, maxLength) end
---Calls the given function on each element of this vector, and sets the values of the vector to the returns. Returns self for chaining.
---@param func function
---@return Vector3
function Vector3:applyFunc(func) end
---Returns a new vector which is the cross product of this and the other one.
---@param other Vector3
---@return Vector3
function Vector3:crossed(other) end
---Returns the augmented form of this vector. The augmented form is Vector4 with a 1 in its W coordinate.
---@return Vector4
function Vector3:augmented() end
