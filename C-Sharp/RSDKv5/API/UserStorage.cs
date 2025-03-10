﻿using System.Text;

namespace RSDK;

#if RETRO_REV02
public unsafe class Auth
{
    public void ClearPrerollErrors() => APITable.ClearPrerollErrors();
    public void TryAuth() => APITable.TryAuth();
    public static int GetUserAuthStatus() => APITable.GetUserAuthStatus();
    public static bool32 GetUsername(ref String username) => APITable.GetUsername(ref username);
}
#endif

public unsafe class Storage
{
    // load user file from game dir
    public static bool32 LoadFile(string fileName, void* buffer, uint size) => RSDKTable.LoadUserFile(fileName, buffer, size);
    public static bool32 SaveFile(string fileName, void* buffer, uint size) => RSDKTable.SaveUserFile(fileName, buffer, size);

#if RETRO_REV02
    // load user file from user dir (e.g. cloud saves or etc)
    public static void LoadUserFile(string fileName, void* buffer, uint size, delegate* unmanaged<int, void> callback) => APITable.LoadUserFile(fileName, buffer, size, callback);
    public static void SaveUserFile(string fileName, void* buffer, uint size, delegate* unmanaged<int, void> callback, bool32 compressed) => APITable.SaveUserFile(fileName, buffer, size, callback, compressed);
    public static void DeleteUserFile(string fileName, delegate* unmanaged<int, void> callback) => APITable.DeleteUserFile(fileName, callback);

    // Storage
    public static void TryInitStorage() => APITable.TryInitStorage();
    public static int GetStorageStatus() => APITable.GetStorageStatus();
    public static int GetSaveStatus() => APITable.GetSaveStatus();
    public static void ClearSaveStatus() => APITable.ClearSaveStatus();
    public static void SetSaveStatusContinue() => APITable.SetSaveStatusContinue();
    public static void SetSaveStatusOK() => APITable.SetSaveStatusOK();
    public static void SetSaveStatusForbidden() => APITable.SetSaveStatusForbidden();
    public static void SetSaveStatusError() => APITable.SetSaveStatusError();
    public static void SetNoSave(bool32 noSave) => APITable.SetNoSave(noSave);
    public static bool32 GetNoSave() { return APITable.GetNoSave(); }

    public struct UserDB
    {
        public UserDB() { }

        public enum Types
        {
            DBVAR_UNKNOWN,
            DBVAR_BOOL,
            DBVAR_UINT8,
            DBVAR_UINT16,
            DBVAR_UINT32,
            DBVAR_UINT64, // unimplemented in RSDKv5
            DBVAR_INT8,
            DBVAR_INT16,
            DBVAR_INT32,
            DBVAR_INT64, // unimplemented in RSDKv5
            DBVAR_FLOAT,
            DBVAR_DOUBLE,  // unimplemented in RSDKv5
            DBVAR_VECTOR2, // unimplemented in RSDKv5
            DBVAR_VECTOR3, // unimplemented in RSDKv5
            DBVAR_VECTOR4, // unimplemented in RSDKv5
            DBVAR_COLOR,
            DBVAR_STRING,
            DBVAR_HASHMD5, // unimplemented in RSDKv5
        }

        public ushort id;

        // Management
        public void Init() => id = unchecked((ushort)-1);
        public void Init(string name, string arg1, string arg2, string arg3, string arg4, string arg5) => id = APITable.InitUserDB(name, arg1, arg2, arg3, arg4, arg5);

        public void Load(string filename, delegate* unmanaged<int, void> callback) => id = APITable.LoadUserDB(filename, callback);
        public void Save(delegate* unmanaged<int, void> callback) => APITable.SaveUserDB(id, callback);
        public void Clear() => APITable.ClearUserDB(id);
        public static void ClearAll() => APITable.ClearAllUserDBs();

        public bool32 Loaded() => id != unchecked((ushort)-1);

        public bool32 Matches(UserDB other) => id == other.id;
        public bool32 Matches(UserDB* other)
        {
            if (other != null)
                return id == other->id;
            else
                return id == unchecked((ushort)-1);
        }

        // Sorting
        public void SetupSorting() => APITable.SetupUserDBRowSorting(id);
        public void Sort(int type, string name, bool32 sortAscending) => APITable.SortDBRows(id, type, name, sortAscending);
        public bool32 RowsChanged() => APITable.GetUserDBRowsChanged(id);
        public void AddSortFilter(Types type, string name, void* value) => APITable.AddRowSortFilter(id, (int)type, name, value);
        public int SortedRowCount() => APITable.GetSortedUserDBRowCount(id);
        public int GetSortedRowID(ushort row) => APITable.GetSortedUserDBRowID(id, row);

        // Rows
        public int AddRow() => APITable.AddUserDBRow(id);
        public void RemoveRow(ushort row) => APITable.RemoveDBRow(id, row);
        public void RemoveAllRows(ushort row) => APITable.RemoveAllDBRows(id);
        public uint GetRowUUID(ushort row) => APITable.GetUserDBRowUUID(id, row);
        public int GetRowByID(uint uuid) => APITable.GetUserDBRowByID(id, uuid);
        public void GetRowCreationTime(ushort row, StringBuilder buffer, uint bufferSize, string format) => APITable.GetUserDBRowCreationTime(id, row, buffer, bufferSize, format);


        // Values
        public void SetValue(int row, Types type, string name, void* value) => APITable.SetUserDBValue(id, (uint)row, (int)type, name, value);
        public void GetValue(int row, Types type, string name, void* value) => APITable.GetUserDBValue(id, (uint)row, (int)type, name, value);
    }
#endif
}