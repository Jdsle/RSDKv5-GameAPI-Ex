namespace RSDK;

static
{
    // RSDKv5/EngineAPI.bf
    public const int SCREEN_XMAX = 1280;
    public const int SCREEN_YSIZE = 240;

    // RSDKv5/Game/Collision.bf
    public const int TILE_SIZE = 16;

    // RSDKv5/Audio/Audio.bf
    public const int CHANNEL_COUNT = 0x10;

    // RSDKv5/Game/Object.bf
    public const int OBJECT_COUNT = 0x400;
    public const int RESERVE_ENTITY_COUNT = 0x40;
    public const int TEMPENTITY_COUNT = 0x100;
    public const int SCENEENTITY_COUNT = 0x800;
    public const int ENTITY_COUNT = RESERVE_ENTITY_COUNT + SCENEENTITY_COUNT + TEMPENTITY_COUNT;
    public const int TEMPENTITY_START = ENTITY_COUNT - TEMPENTITY_COUNT;

    public const int TYPE_COUNT = 0x100;
    public const int TYPEGROUP_COUNT = TYPE_COUNT + 4;

    // RSDKv5/Graphics/Graphics.bf
    public const int PALETTE_BANK_COUNT = 0x8;
    public const int PALETTE_BANK_SIZE  = 0x100;
    public const int SCREEN_YCENTER = SCREEN_YSIZE / 2;
    public const int LAYER_COUNT = 8;
    public const int DRAWGROUP_COUNT = 16;
#if RETRO_REV02
    public const int SCREEN_COUNT = 4;
#else
    public const int SCREEN_COUNT = 2;
#endif
    public const int CAMERA_COUNT = 4;
}

// API Variables
static
{
    public const int PLAYER_COUNT = 4;

#if RETRO_REV02
    public const int FILTER_NONE  = 0 << 0;
    public const int FILTER_SLOT1 = 1 << 0;
    public const int FILTER_SLOT2 = 1 << 1;
    public const int FILTER_SLOT3 = 1 << 2;
    public const int FILTER_SLOT4 = 1 << 3;
    public const int FILTER_SLOT5 = 1 << 4;
    public const int FILTER_SLOT6 = 1 << 5;
    public const int FILTER_SLOT7 = 1 << 6;
    public const int FILTER_SLOT8 = 1 << 7;
    public const int FILTER_ANY   = FILTER_SLOT1 | FILTER_SLOT2 | FILTER_SLOT3 | FILTER_SLOT4 | FILTER_SLOT5 | FILTER_SLOT6 | FILTER_SLOT7 | FILTER_SLOT8;
#endif

#if RETRO_REV0U
    public const int NOTIFY_DEATH_EVENT         = 0x80;
    public const int NOTIFY_TOUCH_SIGNPOST      = 0x81;
    public const int NOTIFY_HUD_ENABLE          = 0x82;
    public const int NOTIFY_ADD_COIN            = 0x83;
    public const int NOTIFY_KILL_ENEMY          = 0x84;
    public const int NOTIFY_SAVESLOT_SELECT     = 0x85;
    public const int NOTIFY_FUTURE_PAST         = 0x86;
    public const int NOTIFY_GOTO_FUTURE_PAST    = 0x87;
    public const int NOTIFY_BOSS_END            = 0x88;
    public const int NOTIFY_SPECIAL_END         = 0x89;
    public const int NOTIFY_DEBUGPRINT          = 0x8A;
    public const int NOTIFY_KILL_BOSS           = 0x8B;
    public const int NOTIFY_TOUCH_EMERALD       = 0x8C;
    public const int NOTIFY_STATS_ENEMY         = 0x8D;
    public const int NOTIFY_STATS_CHARA_ACTION  = 0x8E;
    public const int NOTIFY_STATS_RING          = 0x8F;
    public const int NOTIFY_STATS_MOVIE         = 0x90;
    public const int NOTIFY_STATS_PARAM_1       = 0x91;
    public const int NOTIFY_STATS_PARAM_2       = 0x92;
    public const int NOTIFY_CHARACTER_SELECT    = 0x93;
    public const int NOTIFY_SPECIAL_RETRY       = 0x94;
    public const int NOTIFY_TOUCH_CHECKPOINT    = 0x95;
    public const int NOTIFY_ACT_FINISH          = 0x96;
    public const int NOTIFY_1P_VS_SELECT        = 0x97;
    public const int NOTIFY_CONTROLLER_SUPPORT  = 0x98;
    public const int NOTIFY_STAGE_RETRY         = 0x99;
    public const int NOTIFY_SOUND_TRACK         = 0x9A;
    public const int NOTIFY_GOOD_ENDING         = 0x9B;
    public const int NOTIFY_BACK_TO_MAINMENU    = 0x9C;
    public const int NOTIFY_LEVEL_SELECT_MENU   = 0x9D;
    public const int NOTIFY_PLAYER_SET          = 0x9E;
    public const int NOTIFY_EXTRAS_MODE         = 0x9F;
    public const int NOTIFY_SPIN_DASH_TYPE      = 0xA0;
    public const int NOTIFY_TIME_OVER           = 0xA1;
    public const int NOTIFY_TIMEATTACK_MODE     = 0xA2;
    public const int NOTIFY_STATS_BREAK_OBJECT  = 0xA3;
    public const int NOTIFY_STATS_SAVE_FUTURE   = 0xA4;
    public const int NOTIFY_STATS_CHARA_ACTION2 = 0xA5;

    public const int NOTIFY_1000                = 1000;
    public const int NOTIFY_1001                = 1001;
    public const int NOTIFY_1002                = 1002;
    public const int NOTIFY_PLAYER_SAVED_VALUES = 1003;
    public const int NOTIFY_1004                = 1004;
    public const int NOTIFY_1005                = 1005;
    public const int NOTIFY_TITLECARD_INIT      = 1006;
    public const int NOTIFY_1007                = 1007;
#endif
}