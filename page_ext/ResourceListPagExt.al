pageextension 50100 "ResourceListPageExt" extends "Resource List"
{
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
                    Utility: Codeunit "UtilityCod";
                begin
                    Resource.Get('KATHERINE');
                    Resource."Direct Unit Cost" += 5;
                    Utility.InspectDirectUnitCost('KATHERINE');
                    Resource.Modify(true);
                    Utility.InspectDirectUnitCost('KATHERINE');

                end;
            }
        }
    }
}