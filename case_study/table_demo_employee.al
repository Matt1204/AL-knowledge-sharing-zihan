table 50110 "Demo Employee"
{

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Phone; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    // solution 1: modify in table trigger
    trigger OnModify()
    var
        Resource: Record "Demo Resource";
    begin
        if Resource.Get(Rec."No.") then begin
            Resource.Phone := Rec.Phone;
            Resource.Modify(true);
        end;
    end;


    // // solution 2: modify in trigger event
    // trigger OnModify()
    // begin
    //     // Skip, not updating here.
    // end;


    // // solution 3: check update operation exists
    // trigger OnModify()
    // var
    //     Resource: Record "Demo Resource";
    //     Coordinator: Codeunit "Cross Table Sync Coordinator";
    // begin
    //     if Coordinator.GetIsSyncActive() then
    //         exit;

    //     Coordinator.SetIsSyncActiveTrue();
    //     if Resource.Get(Rec."No.") then begin
    //         Resource.Phone := Rec.Phone;
    //         Resource.Modify(true);
    //     end;
    //     Coordinator.SetIsSyncActiveFalse();
    // end;

    // // solution 4: check new value
    // trigger OnModify()
    // var
    //     Resource: Record "Demo Resource";
    // begin
    //     if xRec."Phone" = Rec."Phone" then
    //         exit;

    //     if Resource.Get(Rec."No.") then begin
    //         Resource.Phone := Rec.Phone;
    //         Resource.Modify(true);
    //     end;
    // end;


    // ------------------------------------------------------------
    // trigger OnModify()
    // var
    //     Setup: Codeunit "Demo EmpRes Setup";
    //     Resource: Record "Demo Resource";
    // begin
    //     if (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseTriggerEvent) then
    //         exit;

    //     // use a global variable to prevent recursive update, only 1 update operation at a time
    //     if (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseSyncProgressCheck) and (Setup.GetIsSyncInProgress()) then
    //         exit;

    //     if (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseFieldUpdateCheck) and (xRec."Phone" = Rec."Phone") then
    //         exit;

    //     Setup.SetIsSyncInProgressTrue();
    //     if Resource.Get(Rec."No.") then begin
    //         Resource.Phone := Rec.Phone;
    //         Resource.Modify(Setup.GetIsRunTrigger());
    //     end;
    //     Setup.SetIsSyncInProgressFalse();
    // end;
}