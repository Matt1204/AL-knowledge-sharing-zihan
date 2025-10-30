codeunit 50114 "Cross Table Sync Coordinator"
{
    SingleInstance = true;

    var
        IsSyncActive: Boolean;

    procedure GetIsSyncActive(): Boolean
    begin
        exit(IsSyncActive);
    end;

    procedure SetIsSyncActiveTrue()
    begin
        IsSyncActive := true;
    end;

    procedure SetIsSyncActiveFalse()
    begin
        IsSyncActive := false;
    end;
}


