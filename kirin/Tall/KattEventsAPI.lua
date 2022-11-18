--╔══════════════════════════════════════════════════════════════════════════╗--
--║                                                                          ║--
--║  ██  ██  ██████  ██████   █████    ██    ██████   ████    ████    ████   ║--
--║  ██ ██     ██      ██    ██       ████     ██    ██  ██  ██          ██  ║--
--║  ████      ██      ██    ██       █  █     ██     █████  █████    ████   ║--
--║  ██ ██     ██      ██    ██      ██████    ██        ██  ██  ██  ██      ║--
--║  ██  ██  ██████    ██     █████  ██  ██    ██     ████    ████    ████   ║--
--║                                                                          ║--
--╚══════════════════════════════════════════════════════════════════════════╝--

--v1.2

---@class Subscription
---@field func function
---@field name string

---@class KattEvent
---@field subscribers Subscription[]
---@field queuedFunctions {func:function,predicate:fun():boolean}[]
local KattEvent = {
  subscribers = {},
  queuedFunctions={}
}

---Creates a new Event.
---@return KattEvent
function KattEvent.new()
  local event = {
    subscribers = {},
    queuedFunctions={}
  }
  setmetatable(event, {
    __index = KattEvent,
    __len = function(e)
      return #e.subscribers
    end
  })
  KattEvent:invoke(event)
  return event
end

---Registers the given function to the given event. When the event is invoked, the function will be run.
---Functions are run in the order they were registered. The optional name parameter is used when you wish to later remove a function from the event.
---@param func function
---@param name string?
function KattEvent:register(func, name)
  if type(func) ~= "function" then error('argument "func" must be a function.', 2) end
  if name ~= nil and type(name) ~= "string" then error('argument "name" must be a string or nil.', 2) end
  table.insert(self.subscribers, { func = func, name = name })
end

---Removes the the function with the given index from the Event.
---Default index is 1, removing the oldest function registered.
---A name can instead be provided to remove all the functions with that name.
---@param name string
---@return integer
function KattEvent:remove(name)
  local removed = 0
  for i = 1, #self.subscribers do
    if self.subscribers[i - removed].name == name then
      table.remove(self.subscribers, i - removed)
      removed = removed + 1
    end
  end
  return removed
end

---Clears the given event of all it's functions.
function KattEvent:clear()
  while #self.subscribers > 0 do
    table.remove(self.subscribers)
  end
end

---Invokes the event, calling all it's functions with the given arguments.
---@param ... any
function KattEvent:invoke(...)
  for _, subscription in pairs(self.subscribers) do
    subscription.func(...)
  end
  local removed = 0
  for i=1,#self.queuedFunctions do
    if self.queuedFunctions[i - removed].predicate() then
      self.queuedFunctions[i - removed].func()
      table.remove(self.queuedFunctions,i-removed)
      removed=removed+1
    end
  end
end

---Waits until the predicate returns true, then runs the given function. The predicate will only be checked when the event is invoked.
---@param predicate fun():boolean
---@param func function
function KattEvent:runOnce(predicate,func)
  table.insert(self.queuedFunctions,{predicate=predicate,func=func})
end

return KattEvent
