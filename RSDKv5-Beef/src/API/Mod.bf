#if RETRO_USE_MOD_LOADER
namespace RSDK
{
    static
    {
        [System.Export, System.CLink]
        public static ModVersionInfo modInfo = .() { engineVer = ExportRevision, gameVer = 0, modLoaderVer = ExportLoaderVer };

#if RETRO_REV0U
        internal const uint8 ExportRevision = 3;
#elif RETRO_REV02
        internal const uint8 ExportRevision = 2;
#elif RETRO_REV01
        internal const uint8 ExportRevision = 1;
#else
        internal const uint8 ExportRevision = 0;
#endif

#if RETRO_MOD_LOADER_VER_2
        internal const uint8 ExportLoaderVer = 2;
#else
        internal const uint8 ExportLoaderVer = 1;
#endif
    }

    [System.CRepr] public struct ModVersionInfo
    {
        public uint8 engineVer;
        public uint8 gameVer;
        public uint8 modLoaderVer;
    }
    
    public enum ModCallbackEvents : int32
    {
        ONGAMESTARTUP,
        ONSTATICLOAD,
        ONSTAGELOAD,
        ONUPDATE,
        ONLATEUPDATE,
        ONSTATICUPDATE,
        ONDRAW,
        ONSTAGEUNLOAD,
        ONSHADERLOAD,
        ONVIDEOSKIPCB,
        ONSCANLINECB,
    }
    
    public enum ModSuper : int32
    {
        UPDATE,
        LATEUPDATE,
        STATICUPDATE,
        DRAW,
        CREATE,
        STAGELOAD,
        EDITORLOAD,
        EDITORDRAW,
        SERIALIZE
    }
    
    namespace Mod
    {
        static
        {
            public static char8* id = ":Unknown Mod ID:";

            // --------------------------------
            // Mod Callbacks & Public Functions
            // --------------------------------
    
            public static void AddModCallback(ModCallbackEvents callbackID, function void(void*) callback) => modTable.AddModCallback((.)callbackID, callback);
            public static void AddPublicFunction(char8* functionName, void* functionPtr) => modTable.AddPublicFunction(functionName, functionPtr);
            public static void* GetPublicFunction(char8* id, char8* functionName) => modTable.GetPublicFunction(id, functionName);
    
            // -------
            // Shaders
            // -------
    
            public static void LoadShader(char8* shaderName, bool32 linear) => modTable.LoadShader(shaderName, linear);
    
            // ----
            // Misc
            // ----
    
            public static void* GetGlobals() => modTable.GetGlobals();
    
            public static class List
            {
                public static bool32 LoadModInfo(char8* id, String* name, String* description, String* version, bool32* active) => modTable.LoadModInfo(id, name, description, version, active);
                public static void GetModPath(char8* id, String* result) => modTable.GetModPath(id, result);
                public static int32 GetModCount(bool32 active = 0) => modTable.GetModCount(active);
                public static char8* GetModIDByIndex(bool32 index) => modTable.GetModIDByIndex(index);
            }
    
            public static class Achievements
            {
                public static void Register(char8* identifier, char8* name, char8* desc) => modTable.RegisterAchievement(identifier, name, desc);
                public static void GetInfo(uint32 id, String* name, String* description, String* identifier, bool32* achieved) => modTable.GetAchievementInfo(id, name, description, identifier, achieved);
                public static int32 GetIndexByID(char8* identifier) => modTable.GetAchievementIndexByID(identifier);
                public static int32 GetCount() => modTable.GetAchievementCount();
            }
    
            public static class Settings
            {
                public static bool32 GetBool(char8* id, char8* key, bool32 fallback) => modTable.GetSettingsBool(id, key, fallback);
                public static int GetInteger(char8* id, char8* key, int32 fallback) => modTable.GetSettingsInteger(id, key, fallback);
                public static float GetFloat(char8* id, char8* key, float fallback) => modTable.GetSettingsFloat(id, key, fallback);
                public static void GetString(char8* id, char8* key, String* result, char8* fallback) => modTable.GetSettingsString(id, key, result, fallback);
                public static void SetBool(char8* key, bool32 val) => modTable.SetSettingsBool(key, val);
                public static void SetInteger(char8* key, int32 val) => modTable.SetSettingsInteger(key, val);
                public static void SetFloat(char8* key, float val) => modTable.SetSettingsFloat(key, val);
                public static void SetString(char8* key, String* val) => modTable.SetSettingsString(key, val);
                public static void SaveSettings() => modTable.SaveSettings();
            }
    
            public static class Config
            {
                public static bool32 GetBool(char8* id, bool32 fallback) => modTable.GetConfigBool(id, fallback);
                public static int GetInteger(char8* id, int32 fallback) => modTable.GetConfigInteger(id, fallback);
                public static float GetFloat(char8* id, float fallback) => modTable.GetConfigFloat(id, fallback);
                public static void GetString(char8* id, String* result, char8* fallback) => modTable.GetConfigString(id, result, fallback);
            }
    
    #if RETRO_MOD_LOADER_VER_2
            public static class Files
            {
                public static bool32 ExcludeFile(char8* id, char8* path) => modTable.ExcludeFile(id, path);
                public static bool32 ExcludeAllFiles(char8* id) => modTable.ExcludeAllFiles(id);
                public static bool32 ReloadFile(char8* id, char8* path) => modTable.ReloadFile(id, path);
                public static bool32 ReloadAllFiles(char8* id) => modTable.ReloadAllFiles(id);
            }
    
            public static class Engine
            {
                public static void* GetSpriteAnimation(uint16 id) => modTable.GetSpriteAnimation(id);
                public static void* GetSpriteSurface(uint16 id) => modTable.GetSpriteSurface(id);
                public static uint16* GetPaletteBank(uint8 id) => modTable.GetPaletteBank(id);
                public static uint8* GetActivePaletteBuffer() => modTable.GetActivePaletteBuffer();
                public static void GetRGB32To16Buffer(uint16** rgb32To16_R, uint16** rgb32To16_G, uint16** rgb32To16_B) => modTable.GetRGB32To16Buffer(rgb32To16_R, rgb32To16_G, rgb32To16_B);
                public static uint16* GetBlendLookupTable() => modTable.GetBlendLookupTable();
                public static uint16* GetSubtractLookupTable() => modTable.GetSubtractLookupTable();
                public static uint16* GetTintLookupTable() => modTable.GetTintLookupTable();
                public static uint GetMaskColor() => modTable.GetMaskColor();
                public static void* GetScanEdgeBuffer() => modTable.GetScanEdgeBuffer();
                public static void* GetCamera(uint8 id) => modTable.GetCamera(id);
                public static void* GetShader(uint8 id) => modTable.GetShader(id);
                public static void* GetModel(uint16 id) => modTable.GetModel(id);
                public static void* GetScene3D(uint16 id) => modTable.GetScene3D(id);
                public static void* GetSfx(uint16 id) => modTable.GetSfx(id);
                public static void* GetChannel(uint8 id) => modTable.GetChannel(id);
            }
    #endif
    
            public static void RegisterStateHook(function void() state, function bool32(bool32 skippedState) hook, bool32 priority) => modTable.RegisterStateHook(state, hook, priority);
        }
    }
}
#endif