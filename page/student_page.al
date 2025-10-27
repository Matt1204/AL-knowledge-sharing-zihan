page 50100 "Demo Student List"
{
    PageType = List;
    Caption = 'Demo Student List';
    ApplicationArea = All;
    SourceTable = "Student";
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
                    ToolTip = 'Student No.';
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    Caption = 'Student Name';
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                }
                field("Class No."; Rec."Class No.")
                {
                    Caption = 'Class No.';
                    ToolTip = 'Student Class No.';
                    ApplicationArea = All;
                }
                field("Grade"; Rec.Grade)
                {
                    Caption = 'Grade';
                    ToolTip = 'Student Grade';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(PopulateData)
            {
                Caption = 'Populate Data';
                ToolTip = 'Populate Data';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Student: Record "Student";
                    Class: Record "Class";
                begin
                    if Confirm('Are you sure you want to populate students and classes?', false) then begin
                        Class.DeleteAll();
                        commit();
                        // "No.", "Class Name", "Grade"
                        InsertClass(1, 'Class 1', 10);
                        InsertClass(2, 'Class 2', 11);

                        Student.DeleteAll();
                        commit();
                        // "No.", "Class No.", "Name", "Grade"
                        InsertStudent(1, 'John Doe', 1, 10);
                        InsertStudent(2, 'Jane Doe', 1, 10);
                        InsertStudent(3, 'Jim Doe', 1, 10);
                    end;
                end;
            }

            action(UpdateClassGrade)
            {
                Caption = 'Update Class Grade';
                ToolTip = 'Update Class Grade';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Class: Record "Class";
                begin
                    Class.FindFirst();
                    Class.Grade := Class.Grade + 100;
                    Class.Modify(true);
                    clear(Class);
                end;
            }
        }
    }

    procedure InsertClass(No: Integer; ClassName: Text; Grade: Integer)
    var
        Class: Record "Class";
    begin
        Class.Init();
        Class."No." := No;
        Class."Class Name" := ClassName;
        Class.Grade := Grade;
        Class.Insert();
    end;

    procedure InsertStudent(No: Integer; Name: Text; ClassNo: Integer; Grade: Integer)
    var
        Student: Record "Student";
    begin
        Student.Init();
        Student."No." := No;
        Student.Name := Name;
        Student."Class No." := ClassNo;
        Student.Grade := Grade;
        Student.Insert();
    end;
}