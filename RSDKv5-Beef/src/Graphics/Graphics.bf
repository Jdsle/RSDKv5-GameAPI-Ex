namespace RSDK;

public enum DrawFX : uint8
{
    FX_NONE = 0,
    FX_FLIP = 1,
    FX_ROTATE = 2,
    // 3 - reserved for FX_ROTATE | FX_FLIP
    FX_SCALE = 4,
    // 5 - reserved for FX_SCALE | FX_FLIP
    // 6 - reserved for FX_SCALE | FX_ROTATE
    // 7 - reserved for FX_SCALE | FX_ROTATE | FX_FLIP
}

public enum FlipFlags : uint8
{
    FLIP_NONE,
    FLIP_X,
    FLIP_Y,
    FLIP_XY,
}

public enum Alignments : int32
{
    LEFT,
    RIGHT,
    CENTER,
}

public enum InkEffects : uint8
{
    INK_NONE,
    INK_BLEND,
    INK_ALPHA,
    INK_ADD,
    INK_SUB,
    INK_TINT,
    INK_MASKED,
    INK_UNMASKED,
}

public enum VideoSettingsValues : int32
{
    WINDOWED,
    BORDERED,
    EXCLUSIVEFS,
    VSYNC,
    TRIPLEBUFFERED,
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    FSWIDTH,
    FSHEIGHT,
    REFRESHRATE,
    SHADERSUPPORT,
    SHADERID,
    SCREENCOUNT,
#if RETRO_REV02
    DIMTIMER,
#endif
    STREAMSENABLED,
    STREAM_VOL,
    SFX_VOL,
    LANGUAGE,
    STORE,
    RELOAD,
    CHANGED,
    WRITE,
}

public struct Palette
{
    public this() => id = 0;
    public this(uint8 bankID) => id = bankID;

#if RETRO_REV02
    public void Load(char8 *path, uint16 disabledRows) => RSDKTable.LoadPalette(id, path, disabledRows);
#endif

#if RETRO_REV01
    public static uint16 *GetTintLookupTable() => RSDKTable.GetTintLookupTable();
#endif

#if RETRO_REV02
    public static void SetTintLookupTable(uint16 *lookupTable) => RSDKTable.SetTintLookupTable(lookupTable);
#endif

    public static void SetPaletteMask(color maskColor) => RSDKTable.SetPaletteMask(maskColor);

    public void SetEntry(uint8 index, color color) => RSDKTable.SetPaletteEntry(id, index, color);
    public color GetEntry(uint8 index)             => RSDKTable.GetPaletteEntry(id, index);

    public void SetActivePalette(int32 startLine, int32 endLine) => RSDKTable.SetActivePalette(id, startLine, endLine);

    public void Rotate(uint8 startIndex, uint8 endIndex, bool32 right)
    {
        RSDKTable.RotatePalette(id, startIndex, endIndex, right);
    }
    public void Copy(uint8 sourceBank, uint8 srcBankStart, uint8 destBankStart, uint8 count)
    {
        RSDKTable.CopyPalette(sourceBank, srcBankStart, id, destBankStart, count);
    }
    public void SetLimitedFade(uint8 srcBankA, uint8 srcBankB, uint16 blendAmount, int32 startIndex, int32 endIndex)
    {
        RSDKTable.SetLimitedFade(id, srcBankA, srcBankB, (.)blendAmount, startIndex, endIndex);
    }
#if RETRO_REV02
    public void BlendColors(color *srcColorsA, color *srcColorsB, int32 blendAmount, int32 startIndex, int32 count)
    {
        RSDKTable.BlendColors(id, srcColorsA, srcColorsB, blendAmount, startIndex, count);
    }
#endif

    public uint8 id;
}

static
{
    public static Palette[PALETTE_BANK_COUNT] paletteBank = .(.(0), .(1), .(2), .(3), .(4), .(5), .(6), .(7));;
}

public static class Graphics
{
    // -------
    // Cameras
    // -------

    public static void AddCamera(Vector2* targetPos, int32 offsetX, int32 offsetY, bool32 worldRelative) => RSDKTable.AddCamera(targetPos, offsetX, offsetY, worldRelative);
    public static void ClearCameras() => RSDKTable.ClearCameras();

    // -------
    // Drawing
    // -------

    public static void DrawLine(int32 x1, int32 y1, int32 x2, int32 y2, color color, int32 alpha, InkEffects inkEffect, bool32 screenRelative)
    {
        RSDKTable.DrawLine(x1, y1, x2, y2, color, alpha, (.)inkEffect, screenRelative);
    }

    public static void DrawRect(int32 x, int32 y, int32 width, int32 height, color color, int32 alpha, InkEffects inkEffect, bool32 screenRelative)
    {
        RSDKTable.DrawRect(x, y, width, height, color, alpha, (.)inkEffect, screenRelative);
    }

    public static void DrawCircle(int32 x, int32 y, int32 radius, color color, int32 alpha, InkEffects inkEffect, bool screenRelative)
    {
        RSDKTable.DrawCircle(x, y, radius, color, alpha, (.)inkEffect, screenRelative);
    }

    public static void DrawCircleOutline(int32 x, int32 y, int32 innerRadius, int32 outerRadius, uint32 color, int32 alpha, uint8 inkEffect,
        bool32 screenRelative)
    {
        RSDKTable.DrawCircleOutline(x, y, innerRadius, outerRadius, color, alpha, inkEffect, screenRelative);
    }

    public static void DrawFace(Vector2* vertices, int32 vertCount, int32 r, int32 g, int32 b, int32 alpha, InkEffects inkEffect)
    {
        RSDKTable.DrawFace(vertices, vertCount, r, g, b, alpha, (.)inkEffect);
    }

    public static void DrawBlendedFace(Vector2* vertices, color* vertColors, int32 vertCount, int32 alpha, InkEffects inkEffect)
    {
        RSDKTable.DrawBlendedFace(vertices, vertColors, vertCount, alpha, (.)inkEffect);
    }

    public static void DrawDeformedSprite(SpriteSheet sheet, int32 inkEffect, int32 alpha)
    {
        RSDKTable.DrawDeformedSprite(sheet.id, inkEffect, alpha);
    }

    public static void DrawTile(Tile* tiles, int32 countX, int32 countY, Vector2* position, Vector2* offset, bool32 screenRelative)
    {
        RSDKTable.DrawTile((.)tiles, countX, countY, position, offset, screenRelative);
    }

    public static void CopyTile(uint16 dest, uint16 src, uint16 count)
    {
        RSDKTable.CopyTile(dest, src, count);
    }

    public static void DrawAniTiles(SpriteSheet sheet, uint16 tileIndex, uint16 srcX, uint16 srcY, uint16 width, uint16 height)
    {
        RSDKTable.DrawAniTiles(sheet.id, tileIndex, srcX, srcY, width, height);
    }

    public static void FillScreen(color color, int32 alphaR, int32 alphaG, int32 alphaB)
    {
        RSDKTable.FillScreen(color, alphaR, alphaG, alphaB);
    }

    // ------------------
    // Screens & Displays
    // ------------------

    public static void GetDisplayInfo(int32* displayID, int32* width, int32* height, int32* refreshRate, char8* text)
    {
        RSDKTable.GetDisplayInfo(displayID, width, height, refreshRate, text);
    }
    public static void GetWindowSize(int32* width, int32* height)                  => RSDKTable.GetWindowSize(width, height);
    public static int32 SetScreenSize(uint8 screenID, uint16 width, uint16 height) => RSDKTable.SetScreenSize(screenID, width, height);

    public static void SetClipBounds(uint8 screenID, int32 x1, int32 y1, int32 x2, int32 y2) => RSDKTable.SetClipBounds(screenID, x1, y1, x2, y2);
#if RETRO_REV02
    public static void SetScreenVertices(uint8 startVert2P_S1, uint8 startVert2P_S2, uint8 startVert3P_S1, uint8 startVert3P_S2, uint8 startVert3P_S3)
    {
        RSDKTable.SetScreenVertices(startVert2P_S1, startVert2P_S2, startVert3P_S1, startVert3P_S2, startVert3P_S3);
    }
#endif

    // ---------------------
    // Window/Video Settings
    // ---------------------

    public static int32 GetVideoSetting(VideoSettingsValues id)             => RSDKTable.GetVideoSetting((.)id);
    public static void SetVideoSetting(VideoSettingsValues id, int32 value) => RSDKTable.SetVideoSetting((.)id, value);
    public static void UpdateWindow()                                       => RSDKTable.UpdateWindow();

    // ------------------
    // Entities & Objects
    // ------------------

    public static int32 GetDrawListRefSlot(uint8 drawGroup, uint16 listPos) => RSDKTable.GetDrawListRefSlot(drawGroup, listPos);
    public static void* GetDrawListRef(uint8 drawGroup, uint16 listPos)     => RSDKTable.GetDrawListRef(drawGroup, listPos);
    public static T* GetDrawListRef<T>(uint8 drawGroup, uint16 entitySlot)  => (T*)RSDKTable.GetDrawListRef(drawGroup, entitySlot);

    public static void AddDrawListRef(uint8 drawGroup, uint16 entitySlot) => RSDKTable.AddDrawListRef(drawGroup, entitySlot);

    public static void SwapDrawListEntries(uint8 drawGroup, uint16 slot1, uint16 slot2, uint16 count) => RSDKTable.SwapDrawListEntries(drawGroup, slot1, slot2, count);
    public static void SetDrawGroupProperties(uint8 drawGroup, bool32 sorted, function void() hookCB) => RSDKTable.SetDrawGroupProperties(drawGroup, sorted, hookCB);
}
