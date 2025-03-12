namespace RSDK;

[System.CRepr] public struct Vector2
{
    // ---------
    // Variables
    // ---------

    public int32 x = 0, y = 0;

    // ------------
    // Constructors
    // ------------

    public this()
    {
        x = 0;
        y = 0;
    }

    public this(Self other)
    {
        x = other.x;
        y = other.y;
    }

    public this(Self* other)
    {
        x = other.x;
        y = other.y;
    }

    public this(int32 X, int32 Y)
    {
        x = X;
        y = Y;
    }

    // ---------
    // Functions
    // ---------

    public bool32 CheckOnScreen(Self* range) mut => RSDKTable.CheckPosOnScreen(&this, range);

    public Self ToFixed() mut
    {
        Self v = this;
        v.x <<= 16;
        v.y <<= 16;
        return v;
    }

    public Self FromFixed() mut
    {
        Self v = this;
        x >>= 16;
        y >>= 16;
        return v;
    }

    // ---------
    // Operators
    // ---------

    public void operator +=(Self other) mut
    {
        x += other.x;
        y += other.y;
    }
    public void operator -=(Self other) mut
    {
        x -= other.x;
        y -= other.y;
    }
    public void operator *=(Self other) mut
    {
        x *= other.x;
        y *= other.y;
    }
    public void operator /=(Self other) mut
    {
        x /= other.x;
        y /= other.y;
    }
    public void operator &=(Self other) mut
    {
        x &= other.x;
        y &= other.y;
    }
    public void operator %=(Self other) mut
    {
        x %= other.x;
        y %= other.y;
    }
    public void operator ^=(Self other) mut
    {
        x ^= other.x;
        y ^= other.y;
    }

    public static Self operator +(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x += rhs.x;
        val.y += rhs.y;
        return val;
    }
    public static Self operator -(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x -= rhs.x;
        val.y -= rhs.y;
        return val;
    }
    public static Self operator *(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x *= rhs.x;
        val.y *= rhs.y;
        return val;
    }
    public static Self operator /(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x /= rhs.x;
        val.y /= rhs.y;
        return val;
    }
    public static Self operator &(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x &= rhs.x;
        val.y &= rhs.y;
        return val;
    }
    public static Self operator %(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x %= rhs.x;
        val.y %= rhs.y;
        return val;
    }
    public static Self operator ^(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x ^= rhs.x;
        val.y ^= rhs.y;
        return val;
    }
    public static Self operator <<(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x <<= rhs.x;
        val.y <<= rhs.y;
        return val;
    }
    public static Self operator >>(ref Self lhs, ref Self rhs)
    {
        Self val = lhs;
        val.x >>= rhs.x;
        val.y >>= rhs.y;
        return val;
    }
}