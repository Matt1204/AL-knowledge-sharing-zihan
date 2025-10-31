codeunit 50100 "ResourceTriggerEventSubCod"
{
    // field-level for "Resource" table
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnBeforeValidateEvent', 'Direct Unit Cost', false, true)]
    local procedure HandleResourceBeforeValidate(var Rec: Record "Resource"; var xRec: Record "Resource");
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;

    // field-level for "Resource" table
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnAfterValidateEvent', 'Direct Unit Cost', false, true)]
    local procedure HandleResourceAfterValidate(var Rec: Record "Resource"; var xRec: Record "Resource");
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;

    // field-level for "Resource" page
    [EventSubscriber(ObjectType::Page, Page::"Resource Card", 'OnBeforeValidateEvent', 'Direct Unit Cost', false, true)]
    local procedure HandleResourceCardBeforeValidate(var Rec: Record "Resource"; var xRec: Record "Resource");
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;

    // field-level for "Resource" page
    [EventSubscriber(ObjectType::Page, Page::"Resource Card", 'OnAfterValidateEvent', 'Direct Unit Cost', false, true)]
    local procedure HandleResourceCardAfterValidate(var Rec: Record "Resource"; var xRec: Record "Resource");
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;

    // table-level for "Resource" table
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnBeforeModifyEvent', '', false, false)]
    local procedure HandleResourceBeforeModify(var Rec: Record "Resource"; var xRec: Record "Resource"; RunTrigger: Boolean);
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;

    // table-level for "Resource" table
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnAfterModifyEvent', '', false, false)]
    local procedure HandleResourceAfterModify(var Rec: Record "Resource"; var xRec: Record "Resource"; RunTrigger: Boolean);
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;
}