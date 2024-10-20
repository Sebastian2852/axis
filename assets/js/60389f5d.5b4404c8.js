"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[517],{47395:e=>{e.exports=JSON.parse('{"functions":[{"name":"GetModule","desc":"Returns the module with that name","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Module"}],"function_type":"static","source":{"line":49,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddModule","desc":"Wrapper function for module system function\\n\\n    ","params":[{"name":"PathToModule","desc":"","lua_type":"ModuleScript"}],"returns":[],"function_type":"method","realm":["Server"],"source":{"line":77,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddModules","desc":"Adds the modules within the parent.\\n\\n\\n:::caution\\nThis only adds children, use AddModulesDeep to add descendants\\n:::\\n    ","params":[{"name":"Parent","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"method","realm":["Server"],"source":{"line":91,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddModulesDeep","desc":"Adds any modules within the parent folder, this includes in sub-folders\\n\\n    ","params":[{"name":"Parent","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"method","realm":["Server"],"source":{"line":104,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"CreateModule","desc":"Returns a table to use for the module. This table contains some axis-related stuff\\n\\n```lua\\nlocal MyModule = Axis.CreateModule {\\n    Name = \\"MyModule\\";\\n    Client = {};\\n}\\n\\nfunction MyModule:Init()\\n    print(\\"Init\\")\\nend\\n\\nfunction MyModule:Start()\\n    print(\\"Start\\")\\nend\\n\\nreturn MyModule\\n```\\n\\n\\n    ","params":[{"name":"ModuleDef","desc":"","lua_type":"ModuleDefinition"}],"returns":[{"desc":"","lua_type":"Module"}],"function_type":"static","realm":["Server"],"source":{"line":136,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"CreateSignal","desc":"Creates a marker that will turn the key into a remote signal once Axis\\nis booted\\n\\n```lua\\nlocal MyModule = Axis.CreateModule {\\n    Name = \\"MyModule\\";\\n    Client = {\\n        -- Create the signal marker, which will turn into a\\n        -- RemoteSignal when Axis.Start() is called:\\n        MySignal = Axis.CreateSignal();\\n    };\\n}\\n```\\n    ","params":[],"returns":[{"desc":"","lua_type":"SIGNAL_MARKER"}],"function_type":"static","source":{"line":157,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"CreateUnreliableSignal","desc":"Creates a marker that will turn the key into a unreliable remote signal\\nonce Axis is booted.\\n\\n:::warning Unreliable Events\\nInternally, this uses UnreliableRemoteEvents, which allows for\\nnetwork communication that is unreliable and unordered. This is\\nuseful for events that are not crucial for gameplay, since the\\ndelivery of the events may occur out of order or not at all.\\n\\nSee  the documentation for [UnreliableRemoteEvents](https://create.roblox.com/docs/reference/engine/classes/UnreliableRemoteEvent)\\nfor more info.\\n:::\\n    ","params":[],"returns":[{"desc":"","lua_type":"UNRELIABLE_SIGNAL_MARKER"}],"function_type":"static","source":{"line":177,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"CreateProperty","desc":"Returns a marker that will turn the key into a remote property\\none Axis is booted. An initial value can be passed.\\n\\nRemoteProperties are great for replicating data to all of\\nthe clients. Different data can also be set per client.\\n\\n```lua\\nlocal MyModule = Axis.CreateModule {\\n    Name = \\"MyModule\\",\\n    Client = {\\n        -- Create the property marker, which will turn into a\\n        -- RemoteProperty when Axis.Start() is called:\\n        MyProperty = Axis.CreateProperty(\\"HelloWorld\\"),\\n    },\\n}\\n```\\n    ","params":[{"name":"InitialValue","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"PROPERTY_MARKER"}],"function_type":"static","source":{"line":200,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddController","desc":"Wrapper function for controller system function\\n    ","params":[{"name":"ControllerScript","desc":"","lua_type":"ModuleScript"}],"returns":[],"function_type":"method","realm":["Client"],"source":{"line":219,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddControllers","desc":"Adds the controllers within the parent.\\n\\n\\n:::caution\\nThis only adds children, use AddControllersDeep to add descendants\\n:::\\n    ","params":[{"name":"Parent","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"method","realm":["Client"],"source":{"line":233,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"AddControllersDeep","desc":"Adds any controllers within the parent folder, this includes in sub-folders\\n\\n    ","params":[{"name":"Parent","desc":"","lua_type":"Folder"}],"returns":[],"function_type":"method","realm":["Client"],"source":{"line":246,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"CreateController","desc":"Wrapper function for controller system function\\n\\n```lua\\nlocal MyController = Axis.CreateController {\\n    Name = \\"MyController\\";\\n}\\n\\nfunction MyController:Init()\\n    print(\\"Init\\")\\nend\\n\\nfunction MyController:Start()\\n    print(\\"Start\\")\\nend\\n\\nreturn MyController\\n```\\n    ","params":[{"name":"ControllerDef","desc":"","lua_type":"Types.ControllerDefinition"}],"returns":[{"desc":"","lua_type":"Controller"}],"function_type":"static","realm":["Client"],"source":{"line":274,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"GetController","desc":"Wrapper function for controller system\\n    ","params":[{"name":"Name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"Controller"}],"function_type":"static","realm":["Client"],"source":{"line":283,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"Boot","desc":"Start core systems and initialize all core modules","params":[],"returns":[{"desc":"Was boot successful","lua_type":"boolean"}],"function_type":"method","source":{"line":292,"path":"Axis/ReplicatedStorage/Axis.luau"}}],"properties":[{"name":"Lib","desc":"Contains all the custom libraries axis provides","lua_type":"{Random: RandomLib}","readonly":true,"source":{"line":18,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"EventSystem","desc":"","lua_type":"EventSystem","readonly":true,"source":{"line":27,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"Promise","desc":"External promise library","lua_type":"Promise","readonly":true,"source":{"line":36,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"Bootstrap","desc":"","lua_type":"Bootstrap","private":true,"source":{"line":43,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"ModuleSystem","desc":"    ","lua_type":"ModuleSystem","realm":["Server"],"private":true,"readonly":true,"source":{"line":66,"path":"Axis/ReplicatedStorage/Axis.luau"}},{"name":"ControllerSystem","desc":"    ","lua_type":"ControllerSystem","realm":["Client"],"private":true,"readonly":true,"source":{"line":213,"path":"Axis/ReplicatedStorage/Axis.luau"}}],"types":[],"name":"Axis","desc":"The global axis module, contains everthing axis has to offer.","source":{"line":8,"path":"Axis/ReplicatedStorage/Axis.luau"}}')}}]);