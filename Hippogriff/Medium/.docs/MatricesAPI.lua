---@diagnostic disable: duplicate-set-field
---A global API which provides functions dedicated to creating and otherwise manipulating matrices. Accessed using the name "matrices".
---@class MatricesAPI
local MatricesAPI={}
---Creates a new Matrix2 that scales by the specified factors.
---@param vec Vector2
---@return Matrix2
function MatricesAPI.scale2(vec) end
---Creates a new Matrix2 that scales by the specified factors.
---@param x number
---@param y number
---@return Matrix2
function MatricesAPI.scale2(x, y) end
---Creates a Matrix3 using the given parameters as columns. If you call the function with no parameters, returns the 3x3 identity matrix.
---@return Matrix3
function MatricesAPI.mat3() end
---Creates a Matrix3 using the given parameters as columns. If you call the function with no parameters, returns the 3x3 identity matrix.
---@param col1 Vector3
---@param col2 Vector3
---@param col3 Vector3
---@return Matrix3
function MatricesAPI.mat3(col1, col2, col3) end
---Creates a Matrix2 using the given parameters as columns. If you call the function with no parameters, returns the 2x2 identity matrix.
---@return Matrix2
function MatricesAPI.mat2() end
---Creates a Matrix2 using the given parameters as columns. If you call the function with no parameters, returns the 2x2 identity matrix.
---@param col1 Vector2
---@param col2 Vector2
---@return Matrix2
function MatricesAPI.mat2(col1, col2) end
---Creates a Matrix4 using the given parameters as columns. If you call the function with no parameters, returns the 4x4 identity matrix.
---@return Matrix4
function MatricesAPI.mat4() end
---Creates a Matrix4 using the given parameters as columns. If you call the function with no parameters, returns the 4x4 identity matrix.
---@param col1 Vector4
---@param col2 Vector4
---@param col3 Vector4
---@param col4 Vector4
---@return Matrix4
function MatricesAPI.mat4(col1, col2, col3, col4) end
---Creates a new Matrix4 that translates by the specified offset.
---@param vec Vector3
---@return Matrix4
function MatricesAPI.translate4(vec) end
---Creates a new Matrix4 that translates by the specified offset.
---@param x number
---@param y number
---@param z number
---@return Matrix4
function MatricesAPI.translate4(x, y, z) end
---Creates a new Matrix3 that rotates by the specified angle around the Y axis. Angle is given in degrees.
---@param angle number
---@return Matrix3
function MatricesAPI.yRotation3(angle) end
---Creates a new Matrix4 that rotates by the specified angle around the Y axis. Angle is given in degrees.
---@param angle number
---@return Matrix4
function MatricesAPI.yRotation4(angle) end
---Creates a new Matrix4 that scales by the specified factors.
---@param vec Vector3
---@return Matrix4
function MatricesAPI.scale4(vec) end
---Creates a new Matrix4 that scales by the specified factors.
---@param x number
---@param y number
---@param z number
---@return Matrix4
function MatricesAPI.scale4(x, y, z) end
---Creates a new Matrix3 that rotates by the specified angle around the X axis. Angle is given in degrees.
---@param angle number
---@return Matrix3
function MatricesAPI.xRotation3(angle) end
---Creates a new Matrix4 that rotates by the specified angle around the Z axis. Angle is given in degrees.
---@param angle number
---@return Matrix4
function MatricesAPI.zRotation4(angle) end
---Creates a new Matrix3 that rotates by the specified angles. Angles are given in degrees, and the rotation order is ZYX.
---@param vec Vector3
---@return Matrix3
function MatricesAPI.rotation3(vec) end
---Creates a new Matrix3 that rotates by the specified angles. Angles are given in degrees, and the rotation order is ZYX.
---@param x number
---@param y number
---@param z number
---@return Matrix3
function MatricesAPI.rotation3(x, y, z) end
---Creates a new Matrix2 that rotates by the specified angle. Angle is given in degrees.
---@param angle number
---@return Matrix2
function MatricesAPI.rotation2(angle) end
---Creates a new Matrix3 that scales by the specified factors.
---@param vec Vector3
---@return Matrix3
function MatricesAPI.scale3(vec) end
---Creates a new Matrix3 that scales by the specified factors.
---@param x number
---@param y number
---@param z number
---@return Matrix3
function MatricesAPI.scale3(x, y, z) end
---Creates a new Matrix4 that rotates by the specified angle around the X axis. Angle is given in degrees.
---@param angle number
---@return Matrix4
function MatricesAPI.xRotation4(angle) end
---Creates a new Matrix4 that rotates by the specified angles. Angles are given in degrees, and the rotation order is ZYX.
---@param vec Vector3
---@return Matrix4
function MatricesAPI.rotation4(vec) end
---Creates a new Matrix4 that rotates by the specified angles. Angles are given in degrees, and the rotation order is ZYX.
---@param x number
---@param y number
---@param z number
---@return Matrix4
function MatricesAPI.rotation4(x, y, z) end
---Creates a new Matrix3 that translates by the specified offset.
---@param vec Vector2
---@return Matrix3
function MatricesAPI.translate3(vec) end
---Creates a new Matrix3 that translates by the specified offset.
---@param x number
---@param y number
---@return Matrix3
function MatricesAPI.translate3(x, y) end
---Creates a new Matrix3 that rotates by the specified angle around the Z axis. Angle is given in degrees.
---@param angle number
---@return Matrix3
function MatricesAPI.zRotation3(angle) end
