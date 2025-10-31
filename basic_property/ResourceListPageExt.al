pageextension 50101 "ResourceListPageExt" extends "Resource List"
{
    // layout
    // {
    //     modify("Direct Unit Cost")
    //     {
    //         trigger OnBeforeValidate()
    //         begin
    //             // do something
    //         end;
    //     }
    // }

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

                    Resource."Direct Unit Cost" += 10;
                    Resource.Modify(true);

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