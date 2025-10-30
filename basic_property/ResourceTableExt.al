tableextension 50100 "ResourceTableExt" extends "Resource"
{
    fields
    {
        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            begin
                // do something
            end;

            trigger OnAfterValidate()
            begin
                // do something
            end;
        }
    }
    trigger OnBeforeModify()
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;

    trigger OnAfterModify()
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
    end;
}