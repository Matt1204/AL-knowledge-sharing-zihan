table 50111 "Demo Resource"
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
        field(5; "Phone (Flow)"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Demo Employee".Phone where("No." = field("No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    // // solution 1: modify in table trigger 
    trigger OnModify()
    var
        Employee: Record "Demo Employee";
    begin
        if Employee.Get(Rec."No.") then begin
            Employee.Phone := Rec.Phone;
            Employee.Modify(false);
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
    //     Employee: Record "Demo Employee";
    //     Coordinator: Codeunit "Cross Table Sync Coordinator";
    // begin
    //     if Coordinator.GetIsSyncActive() then
    //         exit;

    //     Coordinator.SetIsSyncActiveTrue();
    //     if Employee.Get(Rec."No.") then begin
    //         Employee.Phone := Rec.Phone;
    //         Employee.Modify(true);
    //     end;
    //     Coordinator.SetIsSyncActiveFalse();
    // end;


    // solution 4: check new value
    // trigger OnModify()
    // var
    //     Employee: Record "Demo Employee";
    // begin
    //     if xRec."Phone" = Rec."Phone" then
    //         exit;

    //     if Employee.Get(Rec."No.") then begin
    //         Employee.Phone := Rec.Phone;
    //         Employee.Modify(true);
    //     end;
    // end;


    // ------------------------------------------------------------
    // trigger OnModify()
    // var
    //     Setup: Codeunit "Demo EmpRes Setup";
    //     Employee: Record "Demo Employee";
    // begin
    //     if (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseTriggerEvent) then
    //         exit;

    //     if (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseSyncProgressCheck) and (Setup.GetIsSyncInProgress()) then
    //         exit;

    //     if (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseFieldUpdateCheck) and (xRec."Phone" = Rec."Phone") then
    //         exit;

    //     Setup.SetIsSyncInProgressTrue();
    //     if Employee.Get(Rec."No.") then begin
    //         Employee.Phone := Rec.Phone;
    //         Employee.Modify(Setup.GetIsRunTrigger());
    //     end;
    //     Setup.SetIsSyncInProgressFalse();
    // end;

}