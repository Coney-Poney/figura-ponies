---@diagnostic disable: duplicate-set-field
---A matrix with 2 rows and 2 columns.
---@class Matrix2
---@operator add(Matrix2):Matrix2
---@operator sub(Matrix2):Matrix2
---@operator mul(Matrix2):Matrix2
---@operator mul(Vector2):Vector2
local Matrix2={}
---Multiplies this matrix by the other matrix, with the other matrix on the left. Returns self for chaining.
---@param other Matrix2
---@return Matrix2
function Matrix2:multiply(other) end
---Adds the other matrix to this one. Returns self for chaining.
---@param other Matrix2
---@return Matrix2
function Matrix2:add(other) end
---Scales this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param vec Vector2
---@return Matrix2
function Matrix2:scale(vec) end
---Scales this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param x number
---@param y number
---@return Matrix2
function Matrix2:scale(x, y) end
---Treats the given values as a vector, augments this vector with a 1, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param x number
---@return number
function Matrix2:apply(x) end
---Sets this matrix to have the same values as the matrix passed in. Returns self for chaining.
---@param other Matrix2
---@return Matrix2
function Matrix2:set(other) end
---Creates and returns a new copy of this matrix.
---@return Matrix2
function Matrix2:copy() end
---Resets this matrix back to the identity matrix. Returns self for chaining.
---@return Matrix2
function Matrix2:reset() end
---Rotates this matrix by the specified amount, changing the values inside. Angles are given in degrees. Returns self for chaining.
---@param degrees number
---@return Matrix2
function Matrix2:rotate(degrees) end
---Gets the given column of this matrix, as a vector. Indexing starts at 1, as usual.
---@param col integer
---@return Vector2
function Matrix2:getColumn(col) end
---Subtracts the other matrix from this one. Returns self for chaining.
---@param other Matrix2
---@return Matrix2
function Matrix2:sub(other) end
---Returns a copy of this matrix, but inverted.
---@return Matrix2
function Matrix2:inverted() end
---Inverts this matrix, changing the values inside. Returns self for chaining.
---@return Matrix2
function Matrix2:invert() end
---Transposes this matrix, changing the values inside. Transposing means to swap the rows and the columns. Returns self for chaining.
---@return Matrix2
function Matrix2:transpose() end
---Augments this matrix, adding an additional row and column. Puts a 1 along the diagonal in the new spot, and the rest are zero.
---@return Matrix3
function Matrix2:augmented() end
---Calculates and returns the determinant of this matrix.
---@return number
function Matrix2:det() end
---Gets the given row of this matrix, as a vector. Indexing starts at 1, as usual.
---@param row integer
---@return Vector2
function Matrix2:getRow(row) end
---Multiplies this matrix by the other matrix, with the other matrix on the right. Returns self for chaining.
---@param other Matrix2
---@return Matrix2
function Matrix2:rightMultiply(other) end
---Returns a copy of this matrix, but transposed. Transposing means to swap the rows and the columns.
---@return Matrix2
function Matrix2:transposed() end
---Treats the given values as a vector, augments this vector with a 0, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param x number
---@return number
function Matrix2:applyDir(x) end
