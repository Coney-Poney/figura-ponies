---@diagnostic disable: duplicate-set-field
---A matrix with 3 rows and 3 columns.
---@class Matrix3
---@operator add(Matrix3):Matrix3
---@operator sub(Matrix3):Matrix3
---@operator mul(Matrix3):Matrix3
---@operator mul(Vector3):Vector3
local Matrix3={}
---Multiplies this matrix by the other matrix, with the other matrix on the left. Returns self for chaining.
---@param other Matrix3
---@return Matrix3
function Matrix3:multiply(other) end
---Adds the other matrix to this one. Returns self for chaining.
---@param other Matrix3
---@return Matrix3
function Matrix3:add(other) end
---Scales this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param vec Vector3
---@return Matrix3
function Matrix3:scale(vec) end
---Scales this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Matrix3
function Matrix3:scale(x, y, z) end
---Treats the given values as a vector, augments this vector with a 1, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param vec Vector2
---@return Vector2
function Matrix3:apply(vec) end
---Treats the given values as a vector, augments this vector with a 1, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param x number
---@param y number
---@return Vector2
function Matrix3:apply(x, y) end
---Sets this matrix to have the same values as the matrix passed in. Returns self for chaining.
---@param other Matrix3
---@return Matrix3
function Matrix3:set(other) end
---Creates and returns a new copy of this matrix.
---@return Matrix3
function Matrix3:copy() end
---Resets this matrix back to the identity matrix. Returns self for chaining.
---@return Matrix3
function Matrix3:reset() end
---Rotates this matrix by the specified amount, changing the values inside. Angles are given in degrees. Returns self for chaining.
---@param vec Vector3
---@return Matrix3
function Matrix3:rotate(vec) end
---Rotates this matrix by the specified amount, changing the values inside. Angles are given in degrees. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Matrix3
function Matrix3:rotate(x, y, z) end
---Gets the given column of this matrix, as a vector. Indexing starts at 1, as usual.
---@param col integer
---@return Vector3
function Matrix3:getColumn(col) end
---Subtracts the other matrix from this one. Returns self for chaining.
---@param other Matrix3
---@return Matrix3
function Matrix3:sub(other) end
---Translates this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param vec Vector2
---@return Matrix3
function Matrix3:translate(vec) end
---Translates this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param x number
---@param y number
---@return Matrix3
function Matrix3:translate(x, y) end
---Returns a copy of this matrix, but inverted.
---@return Matrix3
function Matrix3:inverted() end
---Rotates this matrix around the Y axis by the specified number of degrees. Returns self for chaining.
---@param degrees number
---@return Matrix3
function Matrix3:rotateY(degrees) end
---Rotates this matrix around the X axis by the specified number of degrees. Returns self for chaining.
---@param degrees number
---@return Matrix3
function Matrix3:rotateX(degrees) end
---Deaugments this matrix, removing a row and column.
---@return Matrix2
function Matrix3:deaugmented() end
---Rotates this matrix around the Z axis by the specified number of degrees. Returns self for chaining.
---@param degrees number
---@return Matrix3
function Matrix3:rotateZ(degrees) end
---Inverts this matrix, changing the values inside. Returns self for chaining.
---@return Matrix3
function Matrix3:invert() end
---Transposes this matrix, changing the values inside. Transposing means to swap the rows and the columns. Returns self for chaining.
---@return Matrix3
function Matrix3:transpose() end
---Augments this matrix, adding an additional row and column. Puts a 1 along the diagonal in the new spot, and the rest are zero.
---@return Matrix4
function Matrix3:augmented() end
---Calculates and returns the determinant of this matrix.
---@return number
function Matrix3:det() end
---Gets the given row of this matrix, as a vector. Indexing starts at 1, as usual.
---@param row integer
---@return Vector3
function Matrix3:getRow(row) end
---Multiplies this matrix by the other matrix, with the other matrix on the right. Returns self for chaining.
---@param other Matrix3
---@return Matrix3
function Matrix3:rightMultiply(other) end
---Returns a copy of this matrix, but transposed. Transposing means to swap the rows and the columns.
---@return Matrix3
function Matrix3:transposed() end
---Treats the given values as a vector, augments this vector with a 0, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param vec Vector2
---@return Vector2
function Matrix3:applyDir(vec) end
---Treats the given values as a vector, augments this vector with a 0, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param x number
---@param y number
---@return Vector2
function Matrix3:applyDir(x, y) end
