using System.Runtime.CompilerServices;

namespace RSDK;

public static unsafe class Macro
{
    public const float RSDK_PI = 3.1415927f;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T MIN<T>(T a, T b) where T : IComparable<T> => a.CompareTo(b) < 0 ? a : b;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T Min<T>(T a, T b) where T : IComparable<T> => MIN(a, b);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T MAX<T>(T a, T b) where T : IComparable<T> => a.CompareTo(b) > 0 ? a : b;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T Max<T>(T a, T b) where T : IComparable<T> => MAX(a, b);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T CLAMP<T>(T value, T minimum, T maximum) where T : IComparable<T> => value.CompareTo(minimum) < 0 ? minimum : value.CompareTo(maximum) > 0 ? maximum : value;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T Clamp<T>(T value, T minimum, T maximum) where T : IComparable<T> => CLAMP(value, minimum, maximum);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T ABS<T>(T a) where T : IComparable<T> => a.CompareTo(default) >= 0 ? a : (dynamic)(-1) * (dynamic)a;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static T Abs<T>(T a) where T : IComparable<T> => ABS(a);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int SET_BIT(int value, int set, int pos) => value ^= (-set ^ (value)) & (1 << (pos));

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int GET_BIT(int b, int pos) => (b) >> (pos) & 1;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static void* INT_TO_VOID(int x) => (void*)(size_t)x;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static void* FLOAT_TO_VOID(float x) => INT_TO_VOID(*(int*)&x);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int VOID_TO_INT(void* x) => (int)(size_t)x;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static float VOID_TO_FLOAT(void* x) => *(float*)&x;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int TO_FIXED(int x) => (x) << 16;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static uint TO_FIXED(uint x) => (x) << 16;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static float TO_FIXED_F(int x) => (float)(x * 65536.0f);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static float TO_FIXED_F(float x) => x * 65536.0f;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int FROM_FIXED(int x) => (x) >> 16;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static uint FROM_FIXED(uint x) => (x) >> 16;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static float FROM_FIXED_F(int x) => (float)(x / 65536.0f);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static float FROM_FIXED_F(float x) => x / 65536.0f;
}

public unsafe static class MathR
{
    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Sin1024(int angle) => RSDKTable.Sin1024(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Cos1024(int angle) => RSDKTable.Cos1024(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Tan1024(int angle) => RSDKTable.Tan1024(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int ASin1024(int angle) => RSDKTable.ASin1024(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int ACos1024(int angle) => RSDKTable.ACos1024(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Sin512(int angle) => RSDKTable.Sin512(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Cos512(int angle) => RSDKTable.Cos512(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Tan512(int angle) => RSDKTable.Tan512(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int ASin512(int angle) => RSDKTable.ASin512(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int ACos512(int angle) => RSDKTable.ACos512(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Sin256(int angle) => RSDKTable.Sin256(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Cos256(int angle) => RSDKTable.Cos256(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Tan256(int angle) => RSDKTable.Tan256(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int ASin256(int angle) => RSDKTable.ASin256(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int ACos256(int angle) => RSDKTable.ACos256(angle);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int Rand(int min, int max) => RSDKTable.Rand(min, max);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static int RandSeeded(int min, int max, ref int seed) => RSDKTable.RandSeeded(min, max, ref seed);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static void SetRandSeed(int seed) => RSDKTable.SetRandSeed(seed);

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static byte ATan2(int x, int y) => RSDKTable.ATan2(x, y);
}
