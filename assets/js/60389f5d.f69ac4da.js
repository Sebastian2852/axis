"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[517],{47395:e=>{e.exports=JSON.parse('{"functions":[{"name":"AddModule","desc":"Adds a module to Axis. This lets other modules use it awell as the client.\\n\\n```lua\\nAxis:AddModule(Somwhere.Module)\\n```\\n\\n    ","params":[{"name":"PathToModule","desc":"","lua_type":"ModuleScript"}],"returns":[],"function_type":"method","realm":["Server"],"source":{"line":65,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddModules","desc":"Adds the modules within the parent.\\n\\n\\n:::caution\\nThis only adds children, use AddModulesDeep to add descendants\\n:::\\n    ","params":[{"name":"Parent","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"method","source":{"line":78,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddModulesDeep","desc":"Adds any modules within the parent folder, this includes in sub-folders\\n\\n    ","params":[{"name":"Parent","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"method","source":{"line":90,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"CreateModule","desc":"Returns a table to use for the module. This table contains some axis-related stuff\\n\\n```lua\\nlocal MyModule = Axis.CreateModule {\\n    Name = \\"MyModule\\";\\n    Client = {};\\n}\\n\\nfunction MyModule:Init()\\n    print(\\"Init\\")\\nend\\n\\nfunction MyModule:Start()\\n    print(\\"Start\\")\\nend\\n\\nreturn MyModule\\n```\\n\\n\\n    ","params":[{"name":"ModuleDef","desc":"","lua_type":"ModuleDefinition"}],"returns":[{"desc":"","lua_type":"Module"}],"function_type":"static","realm":["Server"],"source":{"line":122,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"Boot","desc":"Start core systems and initialize all core modules","params":[],"returns":[{"desc":"Was boot successful","lua_type":"boolean"}],"function_type":"method","source":{"line":132,"path":"Axis/ReplicatedStorage/Axis.luau"}}],"properties":[{"name":"Lib","desc":"Contains all the custom libraries axis provides","lua_type":"{}","readonly":true,"source":{"line":18,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"EventSystem","desc":"","lua_type":"EventSystem","readonly":true,"source":{"line":27,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"Promise","desc":"External promise library","lua_type":"Promise","readonly":true,"source":{"line":36,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"Bootstrap","desc":"    ","lua_type":"Bootstrap","realm":["Server"],"private":true,"source":{"line":45,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"ModuleSystem","desc":"    ","lua_type":"ModuleSystem","realm":["Server"],"private":true,"readonly":true,"source":{"line":54,"path":"Axis/ReplicatedStorage/Axis.luau"}}],"types":[],"name":"Axis","desc":"The global axis module, contains everthing axis has to offer.","source":{"line":8,"path":"Axis/ReplicatedStorage/Axis.luau"}}')}}]);