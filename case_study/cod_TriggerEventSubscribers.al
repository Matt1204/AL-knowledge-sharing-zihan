codeunit 50113 "Demo EmpRes EventSubs"
{
    // ------------------------------------------------------------
    // modify Employee
    [EventSubscriber(ObjectType::Table, Database::"Demo Employee", 'OnBeforeModifyEvent', '', false, false)]
    local procedure HandleEmployeeBeforeModify(var Rec: Record "Demo Employee"; var xRec: Record "Demo Employee"; RunTrigger: Boolean)
    var
        Setup: Codeunit "Demo EmpRes Setup";
        Resource: Record "Demo Resource";
        Employee: Record "Demo Employee";
        ValDuringTransaction: Text;
    begin
        Employee.Get(Rec."No.");
        ValDuringTransaction := Employee.Phone;
        // Rec.Validate(Rec.Phone, Rec.Phone + 'modified');
        // sleep(2000);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Demo Employee", 'OnAfterModifyEvent', '', false, false)]
    local procedure HandleEmployeeAfterModify(var Rec: Record "Demo Employee"; var xRec: Record "Demo Employee"; RunTrigger: Boolean)
    var
        Employee: Record "Demo Employee";
        ValDuringTransaction: Text;
    begin
        Employee.Get(Rec."No.");
        ValDuringTransaction := Employee.Phone;
    end;


    // ------------------------------------------------------------
    // insert Employee
    [EventSubscriber(ObjectType::Table, Database::"Demo Employee", 'OnBeforeInsertEvent', '', false, false)]
    local procedure HandleEmployeeBeforeInsert(var Rec: Record "Demo Employee")
    begin
        // Rec.Validate(Rec.Phone, Rec.Phone + 'before inserted');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Demo Employee", 'OnAfterInsertEvent', '', false, false)]
    local procedure HandleEmployeeAfterInsert(var Rec: Record "Demo Employee")
    begin
        // Rec.Validate(Rec.Phone, Rec.Phone + 'after inserted');
    end;


    // ------------------------------------------------------------
    // Modify Resource
    [EventSubscriber(ObjectType::Table, Database::"Demo Resource", 'OnBeforeModifyEvent', '', false, false)]
    local procedure HandleResourceBeforeModify(var Rec: Record "Demo Resource"; var xRec: Record "Demo Resource"; RunTrigger: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Demo Resource", 'OnAfterModifyEvent', '', false, false)]
    local procedure HandleResourceAfterModify(var Rec: Record "Demo Resource"; var xRec: Record "Demo Resource"; RunTrigger: Boolean)
    begin
    end;
}

