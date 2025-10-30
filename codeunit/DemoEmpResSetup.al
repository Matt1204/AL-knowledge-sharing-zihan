codeunit 50112 "Demo EmpRes Setup"
{
    SingleInstance = true;

    var
        SyncMode: Enum "Demo EmpRes Sync Mode";

    procedure GetSyncMode(): Enum "Demo EmpRes Sync Mode"
    begin
        exit(SyncMode);
    end;

    procedure SetSyncMode(NewMode: Enum "Demo EmpRes Sync Mode")
    begin
        SyncMode := NewMode;
    end;
}

