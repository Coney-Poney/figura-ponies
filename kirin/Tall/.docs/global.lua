---@diagnostic disable: duplicate-set-field
---The global instance of the ActionWheelAPI and its subtypes.
---@type ActionWheelAPI
action_wheel={}
---The global instance of the "animations" table and its subtypes.
---@type table<string,table<string,Animation>>
animations={}
---A table containing all the metatables for Figura's object types. The metatables are editable.
---@type table<Classes,{__index:table|function,__newindex:function,__tostring:function,__add:function,__sub:function,__mul:function,__div:function,__mod:function,__eq:function,__lt:function,__le:function,__unm:function,__len:function}>
figuraMetatables={}
---The global instance of the NameplateAPI and its subtypes.
---@type NameplateAPI
nameplate={}
---The global instance of the WorldAPI and its subtypes.
---@type WorldAPI
world={}
---The global instance of the VanillaModelAPI and its subtypes.
---@type VanillaModelAPI
vanilla_model={}
---The global instance of the Avatar Models and its subtypes.
---@type ModelPart
models={}
---The global instance of the EntityAPI and its subtypes.
---@type PlayerAPI
player={}
---The global instance of the EventsAPI and its subtypes.
---@type EventsAPI
events={}
---The global instance of the KeybindAPI and its subtypes.
---@type KeybindAPI
keybind={}
---The global instance of the VectorsAPI and its subtypes.
---@type VectorsAPI
vectors={}
---The global instance of the MatricesAPI and its subtypes.
---@type MatricesAPI
matrices={}
---The global instance of ClientAPI.
---@type ClientAPI
client={}
---The global instance of HostAPI.
---@type HostAPI
host={}
---The global instance of AvatarAPI.
---@type AvatarAPI
avatar={}
---The global instance of ParticleAPI.
---@type ParticleAPI
particles={}
---The global instance of SoundAPI.
---@type SoundAPI
sounds={}
---The global instance of RendererAPI.
---@type RendererAPI
renderer={}
---An alias for player, just in case the user of your avatar isn't a player. (Foreshadowing?)
---@type EntityAPI
user={}
---The global instance of PingAPI.
---@type PingAPI
pings={}
---An alias for print().
---@param arg any
---@return nil
function log(arg) end
---A function that writes its arguments to chat. Even though the syntax says only one argument, you can put as many as you want. All of them will print, and they'll be separated by some spaces.
---@param arg any
---@return nil
function print(arg) end
---The require() function takes the name of one of your scripts, without the .lua extension. If this script has not been already run before, it will run that script and return the value that script returns. If it has been run before, then it will not run the file again, but it will return the same thing as the first time. If a required script has no returns, then require() will return true. If the name you give isn't any of your scripts, it will error.
---@param scriptName string
---@return any
function require(scriptName) end
---The first argument is either a Table, or it's a Userdata, which refers to any of the added Figura types. Prints the table out to chat, specially formatted. If userdata is passed in, it is automatically converted to a table or string, and displayed. In the case of tables inside of tables, the "maxDepth" parameter will be used to determine how far to go. BE CAREFUL WITH RECURSIVE TABLES! If you try to print a table too deeply, then your game may freeze while it calculates everything to print, and you may have to restart your client if you go too crazy with it. Default value for maxDepth is 1.
---@param table table
---@return nil
function printTable(table) end
---The first argument is either a Table, or it's a Userdata, which refers to any of the added Figura types. Prints the table out to chat, specially formatted. If userdata is passed in, it is automatically converted to a table or string, and displayed. In the case of tables inside of tables, the "maxDepth" parameter will be used to determine how far to go. BE CAREFUL WITH RECURSIVE TABLES! If you try to print a table too deeply, then your game may freeze while it calculates everything to print, and you may have to restart your client if you go too crazy with it. Default value for maxDepth is 1.
---@param javaObject userdata
---@return nil
function printTable(javaObject) end
---The first argument is either a Table, or it's a Userdata, which refers to any of the added Figura types. Prints the table out to chat, specially formatted. If userdata is passed in, it is automatically converted to a table or string, and displayed. In the case of tables inside of tables, the "maxDepth" parameter will be used to determine how far to go. BE CAREFUL WITH RECURSIVE TABLES! If you try to print a table too deeply, then your game may freeze while it calculates everything to print, and you may have to restart your client if you go too crazy with it. Default value for maxDepth is 1.
---@param table table
---@param maxDepth integer
---@return nil
function printTable(table, maxDepth) end
---The first argument is either a Table, or it's a Userdata, which refers to any of the added Figura types. Prints the table out to chat, specially formatted. If userdata is passed in, it is automatically converted to a table or string, and displayed. In the case of tables inside of tables, the "maxDepth" parameter will be used to determine how far to go. BE CAREFUL WITH RECURSIVE TABLES! If you try to print a table too deeply, then your game may freeze while it calculates everything to print, and you may have to restart your client if you go too crazy with it. Default value for maxDepth is 1.
---@param javaObject userdata
---@param maxDepth integer
---@return nil
function printTable(javaObject, maxDepth) end
---An alias for printJson().
---@param json string
---@return nil
function logJson(json) end
---An alias for printTable().
---@param table table
---@return nil
function logTable(table) end
---An alias for printTable().
---@param javaObject userdata
---@return nil
function logTable(javaObject) end
---An alias for printTable().
---@param table table
---@param maxDepth integer
---@return nil
function logTable(table, maxDepth) end
---An alias for printTable().
---@param javaObject userdata
---@param maxDepth integer
---@return nil
function logTable(javaObject, maxDepth) end
---Takes a Minecraft json string as an argument, and prints it to the chat formatted.
---@param json string
---@return nil
function printJson(json) end
---An alias for "vectors.vec", since it's used so often.
---@param x number
---@param y number
---@return Vector2
function vec(x, y) end
---An alias for "vectors.vec", since it's used so often.
---@param x number
---@param y number
---@param z number
---@return Vector3
function vec(x, y, z) end
---An alias for "vectors.vec", since it's used so often.
---@param x number
---@param y number
---@param z number
---@param w number
---@return Vector4
function vec(x, y, z, w) end
---An alias for "vectors.vec", since it's used so often.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@return Vector5
function vec(x, y, z, w, t) end
---An alias for "vectors.vec", since it's used so often.
---@param x number
---@param y number
---@param z number
---@param w number
---@param t number
---@param h number
---@return Vector6
function vec(x, y, z, w, t, h) end
---Figura overrides lua's type() function. When used on Figura types, returns the type's name as seen in the docs and in the figuraMetatables global. When called on a table that has a metatable with a __type key, returns the corresponding value.
---@param var any
---@return Classes | "nil" | "number" | "string" | "boolean" | "table" | "function" | "thread" | "userdata"
function type(var) end
