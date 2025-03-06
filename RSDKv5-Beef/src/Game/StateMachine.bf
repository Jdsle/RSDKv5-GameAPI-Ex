namespace RSDK;

[System.CRepr] public struct StateMachine
{
    public enum Priority : uint8
    {
        NORMAL   = 0,
        LOCKED = 0xFF,
    }

    public void Init() mut => System.Internal.MemSet(&this, 0, sizeof(Self));

    public bool32 Set(function void(GameObject.Entity this) statePtr, Priority priorityType = .NORMAL) mut
    {
        if (priorityType < this.priority || this.priority == .LOCKED)
            return false;

        ptr = statePtr;
        timer = 0;
        priority = priorityType;

        return true;
    }

    public bool32 SetAndRun(function void(GameObject.Entity this) statePtr, GameObject.Entity* self, Priority priorityType = .NORMAL) mut
    {
        bool32 applied = Set(statePtr, priorityType);
        if (applied)
            Run(self);
        return applied;
    }

    public bool32 QueueForTime(function void(GameObject.Entity this) statePtr, int32 duration, Priority priorityType = .NORMAL) mut
    {
        if (priorityType < this.priority || this.priority == .LOCKED)
            return false;

        ptr      = statePtr;
        timer    = duration;
        priority = priorityType;

        return true;
    }

    public void Run(GameObject.Entity* entity) mut
    {
        if (timer != 0)
            timer--;
        if (ptr == null)
            return;

#if RETRO_USE_MOD_LOADER
        modTable.StateMachineRun(*(function void()*)&ptr);
#else
        ptr(entity);
#endif
    }


    public bool32 Matches(function void(GameObject.Entity this) other) => ptr == other;

    public void Copy(Self* other) mut => System.Internal.MemCpy(&this, other, sizeof(Self));

    private function void(GameObject.Entity this) ptr;
    public int32 timer;
    public Priority priority;
}