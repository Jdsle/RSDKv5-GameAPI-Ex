using System;

namespace RSDK;

public static class Serialize
{
    internal const VariableTypes VAR_INVALID = (.)100;

    public static VariableTypes GetSerializeType(Type type)
    {
        if (type == typeof(uint8) || type == typeof(UInt8))
            return .VAR_UINT8;

        if (type == typeof(uint16) || type == typeof(UInt16))
            return .VAR_UINT16;

        if (type == typeof(uint) || type == typeof(uint32) || type == typeof(UInt) || type == typeof(UInt32))
            return .VAR_UINT32;

        if (type == typeof(int8) || type == typeof(Int8))
            return .VAR_INT8;

        if (type == typeof(int16) || type == typeof(Int16))
            return .VAR_INT16;

        if (type == typeof(int) || type == typeof(int32) || type == typeof(Int) || type == typeof(Int32))
            return .VAR_INT32;

        if (type == typeof(bool32))
            return .VAR_BOOL;

        if (type == typeof(RSDK.String))
            return .VAR_STRING;

        if (type == typeof(Vector2))
            return .VAR_VECTOR2;

        if (type == typeof(float))
            return .VAR_FLOAT;

        if (type == typeof(color))
            return .VAR_COLOR;

        return .VAR_INVALID;
    }

    public static void Internal<T>()
    {
        var object = typeof(T);

        object.GetField("sVars").Value.GetValue<GameObject.Static*>(null, var sVars);

        for (let field in object.GetFields(.Instance | .Public | .NonPublic))
        {
            VariableTypes type = GetSerializeType(field.FieldType);
            if (sVars != null && field.HasCustomAttribute<EditableAttribute>() && type != .VAR_INVALID)
            {
                sVars.EditableVar(type, field.Name.Ptr, (.)field.MemberOffset);
            }
        }
    }
}