"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[409],{51697:e=>{e.exports=JSON.parse('{"functions":[{"name":"ConvertName","desc":"Convert the name into a usable one","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"string\\r\\n"}],"function_type":"static","private":true,"source":{"line":16,"path":"Axis/ReplicatedStorage/Core/EventSystem.luau"}},{"name":"NewEvent","desc":"Creates a new event","params":[{"name":"EventName","desc":"","lua_type":"string"}],"returns":[],"function_type":"static","source":{"line":24,"path":"Axis/ReplicatedStorage/Core/EventSystem.luau"}},{"name":"OnEvent","desc":"Get the `on event` script connection for the event.","params":[{"name":"EventName","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"RBXScriptSignal"}],"function_type":"method","errors":[{"lua_type":"\\"Invalid name; no holder\\"","desc":"The passed event name is incorrect and doesn\'t exist."},{"lua_type":"\\"Client unsupported\\"","desc":"Client `OnEvent` functions are not yet supported."},{"lua_type":"\\"Cannot find events\\"","desc":"The event name was valid but the actual event objects cannot be found"}],"source":{"line":49,"path":"Axis/ReplicatedStorage/Core/EventSystem.luau"}},{"name":"FireEvent","desc":"Fires the event for both the server and the client","params":[{"name":"EventName","desc":"","lua_type":"string"},{"name":"...","desc":"Arguments to be passed to the events","lua_type":"any"}],"returns":[],"function_type":"method","errors":[{"lua_type":"\\"Invalid name; no holder\\"","desc":"The passed event name is incorrect and doesn\'t exist."},{"lua_type":"\\"Cannot find events\\"","desc":"The event name was valid but the actual event objects cannot be found"}],"source":{"line":81,"path":"Axis/ReplicatedStorage/Core/EventSystem.luau"}}],"properties":[],"types":[],"name":"EventSystem","desc":"A cross realm event system.","tags":["Unfinished"],"source":{"line":9,"path":"Axis/ReplicatedStorage/Core/EventSystem.luau"}}')}}]);