using System;

namespace RSDK;

public static class Attributes
{
    public static bool32 IsDefault<T>(StringView name) => typeof(T).GetMethod(name).Get().HasCustomAttribute<DefaultEventAttribute>();
}

[AttributeUsage(.Field, .ReflectAttribute, ReflectUser = .All)]
public struct EditableAttribute : Attribute, IOnTypeInit
{
    [Comptime]
    public void OnTypeInit(Type entityType, Self* prev)
    {
    }
}

[AttributeUsage(.Method, .ReflectAttribute, ReflectUser = .All)]
public struct DefaultEventAttribute : Attribute, IOnTypeInit
{
    [Comptime]
    public void OnTypeInit(Type entityType, Self* prev)
    {
    }
}

[AttributeUsage(.Struct, .ReflectAttribute, ReflectUser = .All)]
public struct RegisterObjectAttribute : Attribute, IOnTypeInit
{
    public this() { }

    [Comptime]
    public void OnTypeInit(Type entityType, Self* prev)
    {
        if (entityType.IsGenericParam)
            return;

        System.String name = entityType.GetName(.. scope .());
        System.String events = scope .();

        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).Update(),");
        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).LateUpdate(),");
        events.Append("() => [System.Friend]Self.StaticUpdate(),");
        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).Draw(),");
        events.Append("(data) => [System.Friend]((Self*)sceneInfo.entity).Create(data),");
        events.Append("() => [System.Friend]Self.StageLoad(),");
#if GAME_INCLUDE_EDITOR
        events.Append("() => [System.Friend]Self.EditorLoad(),");
        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).EditorDraw(),");
#else
        events.Append("null");
        events.Append("null");
#endif
        events.Append("() => { Serialize.Internal<Self>(); [System.Friend]Self.Serialize(); },");
#if RETRO_REV0U
        events.Append("(sVars) => { GameObject.InitStatic(sVars); [System.Friend]Self.StaticLoad((.)sVars); }");
#else
        events.Append("null");
#endif

        Compiler.EmitTypeBody(entityType, scope $"""
                                [System.Reflect]\npublic static Static* sVars = GameObject.[System.Friend]RegisterObject<Self, Static>(ref sVars, "{name}", {events});
                                """);
    }
}

[AttributeUsage(.Struct, .ReflectAttribute, ReflectUser = .All)]
public struct RegisterStaticVarsAttribute : Attribute, IOnTypeInit
{
    public this() { }

    [Comptime]
    public void OnTypeInit(Type entityType, Self* prev)
    {
        if (entityType.IsGenericParam)
            return;

        System.String name = entityType.GetName(.. scope .());

        Compiler.EmitTypeBody(entityType, scope $"""
                                [System.Reflect]\npublic static Static* sVars = GameObject.[System.Friend]RegisterStaticVars<Self, Static>(ref sVars, "{name}");\n
                                """);
    }
}

#if RETRO_USE_MOD_LOADER
[AttributeUsage(.Struct, .ReflectAttribute, ReflectUser = .All)]
public struct ModRegisterObjectAttribute : Attribute, IOnTypeInit
{
    public System.String inherit;

    public this(System.String _inherit = "") { this.inherit = _inherit; }

    [Comptime]
    public void OnTypeInit(Type entityType, Self* prev)
    {
        if (entityType.IsGenericParam)
            return;

        System.String name = entityType.GetName(.. scope .());
        System.String events = scope .();

        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).Update(),");
        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).LateUpdate(),");
        events.Append("() => [System.Friend]Self.StaticUpdate(),");
        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).Draw(),");
        events.Append("(data) => [System.Friend]((Self*)sceneInfo.entity).Create(data),");
        events.Append("() => [System.Friend]Self.StageLoad(),");
#if GAME_INCLUDE_EDITOR
        events.Append("() => [System.Friend]Self.EditorLoad(),");
        events.Append("() => [System.Friend]((Self*)sceneInfo.entity).EditorDraw(),");
#else
        events.Append("null");
        events.Append("null");
#endif
        events.Append("() => { [System.Friend]Serialize.Internal<Self>(); [System.Friend]Self.Serialize(); },");
#if RETRO_REV0U
        events.Append("(sVars) => { GameObject.InitStatic(sVars); [System.Friend]Self.StaticLoad((.)sVars); }");
#else
        events.Append("null");
#endif


        Compiler.EmitTypeBody(entityType, scope $"""
                                [System.Reflect]\npublic static Static* sVars = GameObject.[System.Friend]ModRegisterObject<Self, Static, ModStatic>(ref sVars, ref modSVars, "{name}", \n{events}, "{this.inherit}");\n
                                [System.Reflect]\npublic static ModStatic* modSVars = null;\n
                                """);
    }
}
#endif

/* Old RegisterObject attribute - this works similar to the C++ one
[AttributeUsage(.Class | .Struct, .ReflectAttribute, ReflectUser = .All)]
public struct RegisterObjectAttribute : Attribute, IOnTypeInit
{
    public this() { }

    [Comptime]
    public void OnTypeInit(Type entityType, Self* prev)
    {
        if (entityType.IsGenericParam)
            return;

        System.String obj = entityType.GetName(.. scope .());
        System.String regFns = scope .();

#if GAME_INCLUDE_EDITOR
        #if RETRO_REV0U
        regFns.Append("=> _Update, => _LateUpdate, => StaticUpdate, => _Draw, => _Create, => StageLoad, => EditorLoad, => _EditorDraw, => Serialize, => StaticLoad");
        #else
        regFns.Append("=> _Update, => _LateUpdate, => StaticUpdate, => _Draw, => _Create, => StageLoad, => EditorLoad, => _EditorDraw, => Serialize, => null");
        #endif
#else
        #if RETRO_REV0U
        regFns.Append("=> _Update, => _LateUpdate, => StaticUpdate, => _Draw, => _Create, => StageLoad, => null, => null, => Serialize, => StaticLoad");
        #else
        regFns.Append("=> _Update, => _LateUpdate, => StaticUpdate, => _Draw, => Create, => StageLoad, => null, => null, => Serialize, => null");
        #endif
#endif

        Compiler.EmitTypeBody(entityType, scope $"""
                                [System.Reflect] public static Static* sVars = GameObject.[System.Friend]RegisterObject<Self, Static>(ref sVars, "{obj}", {regFns});

                                public static void _Create(void* data) => (*(Self*)(void*)&sceneInfo.entity).Create(data);
                                public static void _Draw() => (*(Self*)(void*)&sceneInfo.entity).Draw();
                                public static void _Update() => (*(Self*)(void*)&sceneInfo.entity).Update();
                                public static void _LateUpdate() => (*(Self*)(void*)&sceneInfo.entity).LateUpdate();\n
                                """);

#if GAME_INCLUDE_EDITOR
        Compiler.EmitTypeBody(entityType, scope $"public static void _EditorDraw() => (*(Self*)(void*)&sceneInfo.entity).EditorDraw();");
#endif
    }
}
*/