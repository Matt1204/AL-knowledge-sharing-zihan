tableextension 50100 "ResourceTabExt" extends "Resource"
{
    trigger OnBeforeModify()
    var
        Utility: Codeunit "UtilityCod";
    begin
        // Message('OnBeforeModify');
        Utility.InspectDirectUnitCost(Rec."No.");
    end;

    trigger OnAfterModify()
    var
        Utility: Codeunit "UtilityCod";
    begin
        // Message('OnAfterModify');
        Utility.InspectDirectUnitCost(Rec."No.");
    end;
}