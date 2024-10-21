"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[44],{58074:e=>{e.exports=JSON.parse('{"functions":[{"name":"Add","desc":"Add a module to the module list","params":[{"name":"ModuleScript","desc":"","lua_type":"ModuleScript"}],"returns":[],"function_type":"method","source":{"line":33,"path":"Axis/Core/ModuleSystem.luau"}},{"name":"Exists","desc":"Checks wether a module exists by name","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","source":{"line":42,"path":"Axis/Core/ModuleSystem.luau"}},{"name":"Create","desc":"Create a module","params":[{"name":"ModuleDef","desc":"","lua_type":"ModuleDefinition"}],"returns":[{"desc":"","lua_type":"Module"}],"function_type":"static","source":{"line":57,"path":"Axis/Core/ModuleSystem.luau"}},{"name":"Start","desc":"Initializes and starts all added modules","params":[],"returns":[{"desc":"","lua_type":"Promise"}],"function_type":"method","private":true,"source":{"line":80,"path":"Axis/Core/ModuleSystem.luau"}},{"name":"GetModule","desc":"Returns the module with that name","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Module"}],"function_type":"static","errors":[{"lua_type":"\\"Name must be a string\\"","desc":"The passed name is not a string"},{"lua_type":"\\"Could not find module ...\\"","desc":"A module does not exist with the passed name"}],"source":{"line":127,"path":"Axis/Core/ModuleSystem.luau"}}],"properties":[{"name":"Modules","desc":"","lua_type":"{[string] :any}}","readonly":true,"source":{"line":27,"path":"Axis/Core/ModuleSystem.luau"}}],"types":[{"name":"ModuleDefinition","desc":"","fields":[{"name":"Name","lua_type":"string","desc":""},{"name":"Client","lua_type":"table?","desc":""},{"name":"[any]","lua_type":"any","desc":""}],"source":{"line":17,"path":"Axis/Core/Types.luau"}},{"name":"Module","desc":"","fields":[{"name":"Name","lua_type":"string","desc":""},{"name":"Client","lua_type":"table?","desc":""},{"name":"AxisNetworking","lua_type":"any","desc":""},{"name":"[any]","lua_type":"any","desc":""}],"source":{"line":31,"path":"Axis/Core/Types.luau"}}],"name":"ModuleSystem","desc":"Internal module only to be used by Axis itself","realm":["Server"],"source":{"line":7,"path":"Axis/Core/ModuleSystem.luau"}}')}}]);