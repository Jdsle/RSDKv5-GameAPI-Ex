namespace RSDK;
public class Dev
{
#if RETRO_REV02
    // Print Modes
    public const Int32 PRINT_NORMAL = 0;
    public const Int32 PRINT_POPUP = 1;
    public const Int32 PRINT_ERROR = 2;
    public const Int32 PRINT_FATAL = 3;

    // Viewable Variable Types
    public const Int32 VIEWVAR_INVALID = 0;
    public const Int32 VIEWVAR_BOOL = 1;
    public const Int32 VIEWVAR_UINT8 = 2;
    public const Int32 VIEWVAR_UINT16 = 3;
    public const Int32 VIEWVAR_UINT32 = 4;
    public const Int32 VIEWVAR_INT8 = 5;
    public const Int32 VIEWVAR_INT16 = 6;
    public const Int32 VIEWVAR_INT32 = 7;

    public static unsafe void Print(Int32 severity, string message, params object[] args) => RSDKTable.PrintLog(severity, string.Format(message, args));
    public static unsafe void PrintText(Int32 severity, string message) => RSDKTable.PrintText(severity, message);
    public static unsafe void PrintString(Int32 severity, ref String str) => RSDKTable.PrintString(severity, ref str);
    public static unsafe void PrintUInt32(Int32 severity, string message, UInt32 integer) => RSDKTable.PrintUInt32(severity, message, integer);
    public static unsafe void PrintInt32(Int32 severity, string message, Int32 integer) => RSDKTable.PrintInt32(severity, message, integer);
    public static unsafe void PrintFloat(Int32 severity, string message, float f) => RSDKTable.PrintFloat(severity, message, f);
    public static unsafe void PrintVector2(Int32 severity, string message, Int32 x, Int32 y) => RSDKTable.PrintVector2(severity, message, new Vector2(x, y));
    public static unsafe void PrintVector2(Int32 severity, string message, ref Vector2 vec) => RSDKTable.PrintVector2(severity, message, vec);
    public static unsafe void PrintVector2(Int32 severity, string message, Vector2 vec) => RSDKTable.PrintVector2(severity, message, vec);
    public static unsafe void PrintHitbox(Int32 severity, string message, ref Hitbox hitbox) => RSDKTable.PrintHitbox(severity, message, hitbox);
    public static unsafe void PrintHitbox(Int32 severity, string message, Hitbox hitbox) => RSDKTable.PrintHitbox(severity, message, hitbox);

    public static unsafe void ClearViewableVariables() => RSDKTable.ClearViewableVariables();
    public static unsafe void AddViewableVariable(string name, void* value, Int32 type, Int32 min, Int32 max) => RSDKTable.AddViewableVariable(name, value, type, min, max);
#else
    // Print Message Types
    public const int MESSAGE_STRING = 0;
    public const int MESSAGE_INT32 = 1;
    public const int MESSAGE_UINT32 = 2;
    public const int MESSAGE_FLOAT = 3;

    public static void Print(string message, Byte type) => RSDKTable.PrintMessage(message, type);
#endif
}