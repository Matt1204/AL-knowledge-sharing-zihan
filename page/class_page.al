page 50101 "Demo Class List"
{
    PageType = List;
    Caption = 'Demo Class List';
    ApplicationArea = All;
    SourceTable = "Class";
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Class No.';
                    ApplicationArea = All;
                }
                field("Class Name"; Rec."Class Name")
                {
                    Caption = 'Class Name';
                    ToolTip = 'Class Name';
                    ApplicationArea = All;
                }
                field("Grade"; Rec.Grade)
                {
                    Caption = 'Grade';
                    ToolTip = 'Class Grade';
                    ApplicationArea = All;
                }
            }
        }
    }
}