codeunit 50100 "TriggerEventSubCod"
{
    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnBeforeModifyEvent', '', false, false)]
    local procedure HandleResourceBeforeModify(var Rec: Record "Resource"; var xRec: Record "Resource"; RunTrigger: Boolean);
    var
        Utility: Codeunit "UtilityCod";
    begin
        Message('Resource Modify: %1', Rec."No.");
        Utility.InspectDirectUnitCost(Rec."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Resource", 'OnAfterModifyEvent', '', false, false)]
    local procedure HandleResourceAfterModify(var Rec: Record "Resource"; var xRec: Record "Resource"; RunTrigger: Boolean);
    var
        Utility: Codeunit "UtilityCod";
    begin
        Message('Resource After Modify: %1', Rec."No.");
        Utility.InspectDirectUnitCost(Rec."No.");
    end;
}