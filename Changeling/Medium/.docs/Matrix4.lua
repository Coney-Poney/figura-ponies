---@diagnostic disable: duplicate-set-field
---A matrix with 4 rows and 4 columns.
---@class Matrix4
---@operator add(Matrix4):Matrix4
---@operator sub(Matrix4):Matrix4
---@operator mul(Matrix4):Matrix4
---@operator mul(Vector4):Vector4
local Matrix4={}
---Multiplies this matrix by the other matrix, with the other matrix on the left. Returns self for chaining.
---@param other Matrix4
---@return Matrix4
function Matrix4:multiply(other) end
---Adds the other matrix to this one. Returns self for chaining.
---@param other Matrix4
---@return Matrix4
function Matrix4:add(other) end
---Scales this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param vec Vector3
---@return Matrix4
function Matrix4:scale(vec) end
---Scales this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Matrix4
function Matrix4:scale(x, y, z) end
---Treats the given values as a vector, augments this vector with a 1, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param vec Vector3
---@return Vector3
function Matrix4:apply(vec) end
---Treats the given values as a vector, augments this vector with a 1, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Matrix4:apply(x, y, z) end
---Sets this matrix to have the same values as the matrix passed in. Returns self for chaining.
---@param other Matrix4
---@return Matrix4
function Matrix4:set(other) end
---Creates and returns a new copy of this matrix.
---@return Matrix4
function Matrix4:copy() end
---Resets this matrix back to the identity matrix. Returns self for chaining.
---@return Matrix4
function Matrix4:reset() end
---Rotates this matrix by the specified amount, changing the values inside. Angles are given in degrees. Returns self for chaining.
---@param vec Vector3
---@return Matrix4
function Matrix4:rotate(vec) end
---Rotates this matrix by the specified amount, changing the values inside. Angles are given in degrees. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Matrix4
function Matrix4:rotate(x, y, z) end
---Gets the given column of this matrix, as a vector. Indexing starts at 1, as usual.
---@param col integer
---@return Vector4
function Matrix4:getColumn(col) end
---Subtracts the other matrix from this one. Returns self for chaining.
---@param other Matrix4
---@return Matrix4
function Matrix4:sub(other) end
---Translates this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param vec Vector3
---@return Matrix4
function Matrix4:translate(vec) end
---Translates this matrix by the specified amount, changing the values inside. Returns self for chaining.
---@param x number
---@param y number
---@param z number
---@return Matrix4
function Matrix4:translate(x, y, z) end
---Returns a copy of this matrix, but inverted.
---@return Matrix4
function Matrix4:inverted() end
---Rotates this matrix around the Y axis by the specified number of degrees. Returns self for chaining.
---@param degrees number
---@return Matrix4
function Matrix4:rotateY(degrees) end
---Rotates this matrix around the X axis by the specified number of degrees. Returns self for chaining.
---@param degrees number
---@return Matrix4
function Matrix4:rotateX(degrees) end
---Deaugments this matrix, removing a row and column.
---@return Matrix3
function Matrix4:deaugmented() end
---Rotates this matrix around the Z axis by the specified number of degrees. Returns self for chaining.
---@param degrees number
---@return Matrix4
function Matrix4:rotateZ(degrees) end
---Inverts this matrix, changing the values inside. Returns self for chaining.
---@return Matrix4
function Matrix4:invert() end
---Transposes this matrix, changing the values inside. Transposing means to swap the rows and the columns. Returns self for chaining.
---@return Matrix4
function Matrix4:transpose() end
---Calculates and returns the determinant of this matrix.
---@return number
function Matrix4:det() end
---Gets the given row of this matrix, as a vector. Indexing starts at 1, as usual.
---@param row integer
---@return Vector4
function Matrix4:getRow(row) end
---Multiplies this matrix by the other matrix, with the other matrix on the right. Returns self for chaining.
---@param other Matrix4
---@return Matrix4
function Matrix4:rightMultiply(other) end
---Returns a copy of this matrix, but transposed. Transposing means to swap the rows and the columns.
---@return Matrix4
function Matrix4:transposed() end
---Treats the given values as a vector, augments this vector with a 0, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param vec Vector3
---@return Vector3
function Matrix4:applyDir(vec) end
---Treats the given values as a vector, augments this vector with a 0, multiplies it against the matrix, and returns a deaugmented vector of the first values.
---@param x number
---@param y number
---@param z number
---@return Vector3
function Matrix4:applyDir(x, y, z) end
