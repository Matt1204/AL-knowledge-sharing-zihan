codeunit 50113 "Demo EmpRes EventSubs"
{
    // ------------------------------------------------------------
    // subscribe to Employee table
    [EventSubscriber(ObjectType::Table, Database::"Demo Employee", 'OnBeforeModifyEvent', '', false, false)]
    local procedure HandleEmployeeBeforeModify(var Rec: Record "Demo Employee"; var xRec: Record "Demo Employee"; RunTrigger: Boolean)
    var
        Setup: Codeunit "Demo EmpRes Setup";
        Resource: Record "Demo Resource";
    begin
        // // solution 2: modify in trigger event
        // if Resource.Get(Rec."No.") then begin
        //     Resource.Phone := Rec.Phone;
        //     Resource.Modify(Setup.GetIsRunTrigger());
        // end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Demo Employee", 'OnAfterModifyEvent', '', false, false)]
    local procedure HandleEmployeeAfterModify(var Rec: Record "Demo Employee"; var xRec: Record "Demo Employee"; RunTrigger: Boolean)
    begin
    end;


    // ------------------------------------------------------------
    // subscribe to Resource table

    [EventSubscriber(ObjectType::Table, Database::"Demo Resource", 'OnBeforeModifyEvent', '', false, false)]
    local procedure HandleResourceBeforeModify(var Rec: Record "Demo Resource"; var xRec: Record "Demo Resource"; RunTrigger: Boolean)
    var
        Setup: Codeunit "Demo EmpRes Setup";
        Emp: Record "Demo Employee";
    begin
        // // solution 2: modify in trigger event
        // if Emp.Get(Rec."No.") then begin
        //     Emp.Phone := Rec.Phone;
        //     Emp.Modify(Setup.GetIsRunTrigger());
        // end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Demo Resource", 'OnAfterModifyEvent', '', false, false)]
    local procedure HandleResourceAfterModify(var Rec: Record "Demo Resource"; var xRec: Record "Demo Resource"; RunTrigger: Boolean)
    begin
    end;
}

