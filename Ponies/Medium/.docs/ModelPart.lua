---@diagnostic disable: duplicate-set-field
---Represents a node in the model tree, basically a group/cube/mesh in Blockbench. Each bbmodel file is itself a ModelPart, and all of your models are contained in a global ModelPart called "models".
---@class ModelPart
---@field [string] ModelPart Children of ModelParts can be accessed by indexing their names from their Parent.
local ModelPart={}
---The name of this model part.
---@return string
function ModelPart:getName() end
---Gets the parent part of this part. If this part has no parent, returns nil.
---@return ModelPart
function ModelPart:getParent() end
---Returns whether this part is a "GROUP", a "CUBE", or a "MESH".
---@return "GROUP" | "CUBE" | "MESH"
function ModelPart:getType() end
---Sets the color multiplier for this part. Values are RGB from 0 to 1. Default values are 1, indicating white/no color change.
---@param color Vector3
---@return nil
function ModelPart:setColor(color) end
---Sets the color multiplier for this part. Values are RGB from 0 to 1. Default values are 1, indicating white/no color change.
---@param r number
---@param g number
---@param b number
---@return nil
function ModelPart:setColor(r, g, b) end
---Adds a new Item Render Task on this part.
---@param taskName string
---@return ItemTask
function ModelPart:addItem(taskName) end
---Gets the children of this part, stored in a table.
---@return ModelPart[]
function ModelPart:getChildren() end
---Sets the scale factor for this part. Nil values for scale are assumed to be 1.
---@param scale Vector3
---@return nil
function ModelPart:setScale(scale) end
---Sets the scale factor for this part. Nil values for scale are assumed to be 1.
---@param x number
---@param y number
---@param z number
---@return nil
function ModelPart:setScale(x, y, z) end
---Gets the Render Task with the given name from this part.
---@return RenderTask[]
function ModelPart:getTask() end
---Gets the Render Task with the given name from this part.
---@param taskName string
---@return RenderTask
function ModelPart:getTask(taskName) end
---Sets this part to be visible or invisible. The default value is nil, meaning the part copies its visibility from its parent part.
---@param visible boolean
---@return nil
function ModelPart:setVisible(visible) end
---Gets whether or not this model part is visible. The default value is nil, meaning it copies the visibility of its parent part during rendering.
---@return boolean
function ModelPart:getVisible() end
---Returns the position matrix for this model part. The Raw version of the function is different in that it doesn't recalculate the matrix before getting it.
---@return Matrix4
function ModelPart:getPositionMatrixRaw() end
---Sets the secondary texture override of this part. Check the TextureType types in the list docs. If using "resource", the second parameter should indicate the path to the Minecraft texture you want to use.
---@param textureType TextureTypes
---@return nil
function ModelPart:setSecondaryTexture(textureType) end
---Sets the secondary texture override of this part. Check the TextureType types in the list docs. If using "resource", the second parameter should indicate the path to the Minecraft texture you want to use.
---@param resource TextureTypes
---@param path string
---@return nil
function ModelPart:setSecondaryTexture(resource, path) end
---Sets the current secondary render type of this model part. Nil by default, meaning the part copies the secondary render type of its parent during rendering. Check the docs list command for all render types.
---@param renderType RenderTypes
---@return nil
function ModelPart:setSecondaryRenderType(renderType) end
---Gets the current primary render type of this model part. Nil by default, meaning the part copies the primary render type of its parent.
---@return RenderTypes
function ModelPart:getPrimaryRenderType() end
---Sets the current primary render type of this model part. Nil by default, meaning the part copies the primary render type of its parent during rendering. Check the docs list command for all render types.
---@param renderType RenderTypes
---@return nil
function ModelPart:setPrimaryRenderType(renderType) end
---Gets the current secondary render type of this model part. Nil by default, meaning the part copies the secondary render type of its parent.
---@return RenderTypes
function ModelPart:getSecondaryRenderType() end
---Gets the rotation of the model part, including its rotation in blockbench. For relative rotation values, check out the "offset" rot functions.
---@return Vector3
function ModelPart:getRot() end
---Gets the position of the model part, as an offset from its position in blockbench. Only changes from {0,0,0} when you call setPos().
---@return Vector3
function ModelPart:getPos() end
---Sets the offset pivot point for this part. Nil values are assumed to be 0. For absolute pivot point values, check out the non-offset pivot functions.
---@param offsetPivot Vector3
---@return nil
function ModelPart:offsetPivot(offsetPivot) end
---Sets the offset pivot point for this part. Nil values are assumed to be 0. For absolute pivot point values, check out the non-offset pivot functions.
---@param x number
---@param y number
---@param z number
---@return nil
function ModelPart:offsetPivot(x, y, z) end
---Sets the offset rotation for this part. Nil values for rotation are assumed to be 0. Angles are given in degrees. For absolute rotation values, check out the non-offset rot functions.
---@param offsetRot Vector3
---@return nil
function ModelPart:offsetRot(offsetRot) end
---Sets the offset rotation for this part. Nil values for rotation are assumed to be 0. Angles are given in degrees. For absolute rotation values, check out the non-offset rot functions.
---@param x number
---@param y number
---@param z number
---@return nil
function ModelPart:offsetRot(x, y, z) end
---Gets the offset pivot of the model part, offset from its pivot in blockbench. For absolute pivot point values, check out the non-offset pivot functions.
---@return Vector3
function ModelPart:getOffsetPivot() end
---Gets the pivot point of the model part, including its pivot in blockbench. For relative values, check out the "offset" pivot functions.
---@return Vector3
function ModelPart:getPivot() end
---Gets the rotation offset provided by the currently active animation of this model part.
---@return Vector3
function ModelPart:getAnimRot() end
---Sets the given matrix as the position matrix for this model part. The normal matrix is automatically calculated as the inverse transpose of this matrix. Calling this DOES NOT CHANGE the values of position, rot, or scale in the model part. If you call setPos() or a similar function, the effects of setMatrix() will be overwritten.
---@param matrix Matrix4
---@return nil
function ModelPart:setMatrix(matrix) end
---Gets the scale multiplier provided by the currently active animation of this model part.
---@return Vector3
function ModelPart:getAnimScale() end
---Gets the position offset provided by the currently active animation of this model part.
---@return Vector3
function ModelPart:getAnimPos() end
---Sets the position offset for this part from its blockbench position. Nil values for position are assumed to be 0.
---@param pos Vector3
---@return nil
function ModelPart:setPos(pos) end
---Sets the position offset for this part from its blockbench position. Nil values for position are assumed to be 0.
---@param x number
---@param y number
---@param z number
---@return nil
function ModelPart:setPos(x, y, z) end
---Sets the absolute rotation for this part. Nil values for rotation are assumed to be 0. Angles are given in degrees. For relative rotation values, check out the "offset" rot functions.
---@param rot Vector3
---@return nil
function ModelPart:setRot(rot) end
---Sets the absolute rotation for this part. Nil values for rotation are assumed to be 0. Angles are given in degrees. For relative rotation values, check out the "offset" rot functions.
---@param x number
---@param y number
---@param z number
---@return nil
function ModelPart:setRot(x, y, z) end
---Gets the width, height of this part's texture in pixels. If this part has multiple different-sized textures on it, it throws an error instead.
---@return Vector2
function ModelPart:getTextureSize() end
---Gets the scale of the model part, as a multiple of its blockbench size. Only changes from {1,1,1} when you call setScale().
---@return Vector3
function ModelPart:getScale() end
---Sets the absolute pivot for this part. Nil values are assumed to be 0. For relative pivot offsets, check out the "offset" pivot functions.
---@param pivot Vector3
---@return nil
function ModelPart:setPivot(pivot) end
---Sets the absolute pivot for this part. Nil values are assumed to be 0. For relative pivot offsets, check out the "offset" pivot functions.
---@param x number
---@param y number
---@param z number
---@return nil
function ModelPart:setPivot(x, y, z) end
---Sets the primary texture override of this part. Check the TextureType types in the list docs. If using "resource", the second parameter should indicate the path to the Minecraft texture you want to use.
---@param textureType TextureTypes
---@return nil
function ModelPart:setPrimaryTexture(textureType) end
---Sets the primary texture override of this part. Check the TextureType types in the list docs. If using "resource", the second parameter should indicate the path to the Minecraft texture you want to use.
---@param resource TextureTypes
---@param path string
---@return nil
function ModelPart:setPrimaryTexture(resource, path) end
---Returns the normal matrix for this model part. The Raw version of the function is different in that it doesn't recalculate the matrix before returning it.
---@return Matrix3
function ModelPart:getNormalMatrixRaw() end
---Gets the offset rotation of the model part, offset from its rotation in blockbench. For absolute rotation values, check out the non-offset rot functions.
---@return Vector3
function ModelPart:getOffsetRot() end
---Recalculates the normal matrix for this model part, based on its current position, rotation, scale, and pivot, then returns this matrix.
---@return Matrix3
function ModelPart:getNormalMatrix() end
---Gets a matrix which transforms a point from this part's position to a world location. Recommended to use this in POST_RENDER, as by then the matrix is updated. In RENDER it will be 1 frame behind the part's visual position for that frame. Also, if the model is not rendered in-world, the part's matrix will not be updated. Paperdoll rendering and other UI rendering will not affect this matrix.
---@return Matrix4
function ModelPart:partToWorldMatrix() end
---Recalculates the matrix for this model part, based on its current position, rotation, scale, and pivot, then returns this matrix.
---@return Matrix4
function ModelPart:getPositionMatrix() end
---Adds a new Block Render Task on this part.
---@param taskName string
---@return BlockTask
function ModelPart:addBlock(taskName) end
---Sets the UV matrix of this part. This matrix is applied to all UV points during the transform, with the UVs treated as homogeneous vectors. setUV() and setUVPixels() are actually just simpler ways of setting this matrix.
---@param matrix Matrix3
---@return nil
function ModelPart:setUVMatrix(matrix) end
---Sets the UV of this part in pixels. Automatically divides by the results of getTextureSize(), so you can just input the number of pixels you want the UV to scroll by. Errors if the part has multiple different-sized textures.
---@param uv Vector2
---@return nil
function ModelPart:setUVPixels(uv) end
---Sets the UV of this part in pixels. Automatically divides by the results of getTextureSize(), so you can just input the number of pixels you want the UV to scroll by. Errors if the part has multiple different-sized textures.
---@param u number
---@param v number
---@return nil
function ModelPart:setUVPixels(u, v) end
---Sets the light level to be used when rendering this part. Values you give are 0 to 15, indicating the block light and sky light levels you want to use. Passing nil will reset the lighting override for this part.
---@param light Vector2
---@return nil
function ModelPart:setLight(light) end
---Sets the light level to be used when rendering this part. Values you give are 0 to 15, indicating the block light and sky light levels you want to use. Passing nil will reset the lighting override for this part.
---@param blockLight integer
---@param skyLight integer
---@return nil
function ModelPart:setLight(blockLight, skyLight) end
---Sets the UV of this part. This function is normalized, meaning it works with values 0 to 1. If you say setUV(0.5, 0.25), for example, it will scroll by half of your texture width to the right, and one fourth of the texture width downwards.
---@param uv Vector2
---@return nil
function ModelPart:setUV(uv) end
---Sets the UV of this part. This function is normalized, meaning it works with values 0 to 1. If you say setUV(0.5, 0.25), for example, it will scroll by half of your texture width to the right, and one fourth of the texture width downwards.
---@param u number
---@param v number
---@return nil
function ModelPart:setUV(u, v) end
---Gets the light level you set earlier to this part. Does not interact with Minecraft's lighting system, only retrieving values you set earlier with setLight().
---@return Vector2
function ModelPart:getLight() end
---Gets the opacity multiplier of this part. Note that opacity settings will only take effect if the part has a suitable Render Type for them, mainly TRANSLUCENT. Check out modelPart.setPrimaryRenderType() for how to do this.
---@return number
function ModelPart:getOpacity() end
---Sets the opacity multiplier of this part. Note that opacity settings will only take effect if the part has a suitable Render Type for them, mainly TRANSLUCENT. Check out modelPart.setPrimaryRenderType() for how to do this.
---@param opacity number
---@return nil
function ModelPart:setOpacity(opacity) end
---Returns the current parent type of the part.
---@return ParentTypes
function ModelPart:getParentType() end
---Adds a new Text Render Task on this part.
---@param taskName string
---@return TextTask
function ModelPart:addText(taskName) end
---Sets the parent type of the part. See the ParentType parts in the list docs for legal types.
---@param parentType ParentTypes
---@return nil
function ModelPart:setParentType(parentType) end
---Removes the Task with the given name from this part.
---@param taskName string
---@return nil
function ModelPart:removeTask(taskName) end
---Gets the color multiplier of this part. Values are RGB from 0 to 1. Default values are 1, indicating white/no color change.
---@return Vector3
function ModelPart:getColor() end
