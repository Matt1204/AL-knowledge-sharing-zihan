page 50110 "Demo Employee List"
{
    PageType = List;
    Caption = 'Demo Employee List';
    ApplicationArea = All;
    SourceTable = "Demo Employee";
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        // do something
                        Message('Validate');
                    end;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                // field("Department Code"; Rec."Department Code")
                // {
                //     ApplicationArea = All;
                // }
            }
        }

        // area(Factboxes)
        // {
        //     part(SetupOverview; "Setup Overview Factbox")
        //     {

        //     }
        // }
    }

    actions
    {
        area(Processing)
        {
            action(PopulateData)
            {
                Caption = 'Populate Demo Data';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Emp: Record "Demo Employee";
                    Res: Record "Demo Resource";
                begin
                    Emp.DeleteAll();
                    Res.DeleteAll();
                    commit();

                    InsertEmployee(1, 'Alice', '1001', 'D-10');
                    InsertEmployee(2, 'Bob', '1002', 'D-20');
                    InsertEmployee(3, 'Carol', '1003', 'D-30');

                    InsertResource(1, 'Alice Res', '1001', 'D-10');
                    InsertResource(2, 'Bob Res', '1002', 'D-20');
                    InsertResource(3, 'Carol Res', '1003', 'D-30');
                end;
            }

            action(DemoUpdateEmployee)
            {
                Caption = 'Demo Update Employee';
                ToolTip = 'Demo Update Employee';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Employee: Record "Demo Employee";
                begin
                    Employee.Get(1);
                    Employee.Validate(Employee.Phone, '00000000');
                    Employee.Modify();
                    // Employee.Modify(true);
                end;
            }
        }


    }

    trigger OnModifyRecord(): Boolean
    begin
        exit(true);
    end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CurrPage.SetupOverview.Page.UpdateOverview();
    // end;

    local procedure InsertEmployee(No: Integer; Name: Text; Phone: Text; Dept: Code[20])
    var
        Emp: Record "Demo Employee";
    begin
        Emp.Init();
        Emp."No." := No;
        Emp.Name := Name;
        Emp.Phone := Phone;
        // Emp."Department Code" := Dept;
        Emp.Insert();
    end;

    local procedure InsertResource(No: Integer; Name: Text; Phone: Text; Dept: Code[20])
    var
        Res: Record "Demo Resource";
    begin
        Res.Init();
        Res."No." := No;
        Res.Name := Name;
        Res.Phone := Phone;
        // Res."Department Code" := Dept;
        Res.Insert();
    end;
}

