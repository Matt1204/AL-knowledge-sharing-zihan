pageextension 50100 "ResourceCardPageExt" extends "Resource Card"
{
    layout
    {
        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            begin
                // do something
                Message('Before Validate');
            end;

            trigger OnAfterValidate()
            begin
                // do something
                Message('After Validate');
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
                var
                    Resource: Record "Resource";
                begin
                    Resource.Get('KATHERINE');
                    Resource.Validate("Direct Unit Cost", Resource."Direct Unit Cost" + 10);

                    // Rec.Validate("Direct Unit Cost", Rec."Direct Unit Cost" + 10);
                    // Rec."Direct Unit Cost" += 10;
                    // Rec.Modify(true);
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