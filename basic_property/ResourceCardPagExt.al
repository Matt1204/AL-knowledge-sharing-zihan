pageextension 50100 "ResourceCardPageExt" extends "Resource Card"
{
    layout
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
    actions
    {
        addlast(Processing)
        {
            action(DemoUpdateResource)
            {
                Caption = 'Demo Update Resource';
                ToolTip = 'Demo Update Resource';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Direct Unit Cost" += 10;
                    Rec.Modify(false);

                    // Resource.Validate("Direct Unit Cost", Resource."Direct Unit Cost" + 10);
                    // Resource.Modify(true);
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    var
        Utility: Codeunit "UtilityCod";
        ValFromDB: Decimal;
    begin
        ValFromDB := Utility.InspectDirectUnitCost(Rec."No.");
        exit(true);
    end;
}