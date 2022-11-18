---@diagnostic disable: duplicate-set-field
---A global API which provides functions dedicated to creating and otherwise manipulating vectors. Accessed using the name "vectors".
---@class VectorsAPI
local VectorsAPI={}
---Creates and returns a vector of the appropriate size to hold the arguments passed in. For example, if you call vec(3, 4, 0, 2), then the function will return a Vector4 containing those values. There is a global alias "vec" for this function, meaning the "vectors." can be omitted.
---@param x number
---@param y number
---@return Vector2
function VectorsAPI.vec(x, y) end
---Creates and returns a vector of the appropriate size to hold the arguments passed in. For example, if you call vec(3, 4, 0, 2), then the function will return a Vector4 containing those values. There is a global alias "vec" for this function, meaning the "vectors." can be omitted.
---@param x number
---@param y number
---@param z number
---@return Vector3
function VectorsAPI.vec(x, y, z) end
---Creates and returns a vector of the appropriate size to hold the arguments passed in. For example, if you call vec(3, 4, 0, 2), then the function will return a Vector4 containing those values. There is a global alias "vec" for this function, meaning the "vectors." can be omitted.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function VectorsAPI.vec(x, y, z, w) end
---Creates and returns a vector of the appropriate size to hold the arguments passed in. For example, if you call vec(3, 4, 0, 2), then the function will return a Vector4 containing those values. There is a global alias "vec" for this function, meaning the "vectors." can be omitted.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function VectorsAPI.vec(x, y, z, w, t) end
---Creates and returns a vector of the appropriate size to hold the arguments passed in. For example, if you call vec(3, 4, 0, 2), then the function will return a Vector4 containing those values. There is a global alias "vec" for this function, meaning the "vectors." can be omitted.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function VectorsAPI.vec(x, y, z, w, t, h) end
---Creates and returns a Vector3 with the given values. Nil values become zero.
---@param x number
---@param y number
---@param z number
---@return Vector3
function VectorsAPI.vec3(x, y, z) end
---Creates and returns a Vector2 with the given values. Nil values become zero.
---@param x number
---@param y number
---@return Vector2
function VectorsAPI.vec2(x, y) end
---Creates and returns a Vector4 with the given values. Nil values become zero.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function VectorsAPI.vec4(x, y, z, w) end
---Parses a hex string color into a RGB format vector. The hex "#" is optional, and it can have any length, however only the first 6 hex digits are evaluated, short hex (length 3) is also supported. For example, "#42" is the same as "420000", and "F0B" is the same as "FF00BB"
---@param hex string
---@return Vector3
function VectorsAPI.hexToRGB(hex) end
---Creates and returns a Vector6 with the given values. Nil values become zero.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function VectorsAPI.vec6(x, y, z, w, t, h) end
---Creates and returns a Vector5 with the given values. Nil values become zero.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function VectorsAPI.vec5(x, y, z, w, t) end
---Converts a position in the world into a position relative to the viewer's screen.
---@param vec Vector3
---@return Vector4
function VectorsAPI.worldToScreenSpace(vec) end
---Converts a position in the world into a position relative to the viewer's screen.
---@param x number
---@param y number
---@param z number
---@return Vector4
function VectorsAPI.worldToScreenSpace(x, y, z) end
---Rotates a vector relative to a rotation vector.
---@param angle number
---@param vec Vector3
---@param axis Vector3
---@return Vector3
function VectorsAPI.rotateAroundAxis(angle, vec, axis) end
---Rotates a vector relative to a rotation vector.
---@param angle number
---@param x number
---@param y number
---@param z number
---@param axis Vector3
---@return Vector3
function VectorsAPI.rotateAroundAxis(angle, x, y, z, axis) end
---Rotates a vector relative to a rotation vector.
---@param angle number
---@param vec Vector3
---@param axisX number
---@param axisY number
---@param axisZ number
---@return Vector3
function VectorsAPI.rotateAroundAxis(angle, vec, axisX, axisY, axisZ) end
---Rotates a vector relative to a rotation vector.
---@param angle number
---@param x number
---@param y number
---@param z number
---@param axisX number
---@param axisY number
---@param axisZ number
---@return Vector3
function VectorsAPI.rotateAroundAxis(angle, x, y, z, axisX, axisY, axisZ) end
---Converts a position in the world into a position relative to the viewer's camera.
---@param vec Vector3
---@return Vector3
function VectorsAPI.toCameraSpace(vec) end
---Converts a position in the world into a position relative to the viewer's camera.
---@param x number
---@param y number
---@param z number
---@return Vector3
function VectorsAPI.toCameraSpace(x, y, z) end
---Converts the given color from integer format to RGB format.
---@param color integer
---@return Vector3
function VectorsAPI.intToRGB(color) end
---Gets an rgb vector with a shifting hue based on the given speed value and how much time the game is opened.
---@param speed number
---@return Vector3
function VectorsAPI.rainbow(speed) end
---Gets an rgb vector with a shifting hue based on the given speed value and how much time the game is opened.
---@param speed number
---@param offset number
---@return Vector3
function VectorsAPI.rainbow(speed, offset) end
---Gets an rgb vector with a shifting hue based on the given speed value and how much time the game is opened.
---@param speed number
---@param offset number
---@param saturation number
---@param light number
---@return Vector3
function VectorsAPI.rainbow(speed, offset, saturation, light) end
---Converts the given color from RGB format to integer format.
---@param rgb Vector3
---@return integer
function VectorsAPI.rgbToInt(rgb) end
---Converts the given color from RGB format to integer format.
---@param r number
---@param g number
---@param b number
---@return integer
function VectorsAPI.rgbToInt(r, g, b) end
---Converts the given color from HSV format to RGB format.
---@param hsv Vector3
---@return Vector3
function VectorsAPI.hsvToRGB(hsv) end
---Converts the given color from HSV format to RGB format.
---@param h number
---@param s number
---@param v number
---@return Vector3
function VectorsAPI.hsvToRGB(h, s, v) end
---Converts the given color from RGB format to HSV format.
---@param rgb Vector3
---@return Vector3
function VectorsAPI.rgbToHSV(rgb) end
---Converts the given color from RGB format to HSV format.
---@param r number
---@param g number
---@param b number
---@return Vector3
function VectorsAPI.rgbToHSV(r, g, b) end
---Converts the given color from RGB format to HEX format. The "#" is not included on the return hex.
---@param rgb Vector3
---@return string
function VectorsAPI.rgbToHex(rgb) end
---Converts the given color from RGB format to HEX format. The "#" is not included on the return hex.
---@param r number
---@param g number
---@param b number
---@return string
function VectorsAPI.rgbToHex(r, g, b) end
