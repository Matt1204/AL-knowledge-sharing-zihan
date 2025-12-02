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
                        // Message('Validate');
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
                    // commit();

                    InsertEmployee(1, 'Alice', '1001', 'D-10');
                    InsertEmployee(2, 'Bob', '1002', 'D-20');
                    InsertEmployee(3, 'Carol', '1003', 'D-30');

                    InsertResource(1, 'Alice Res', '1001', 'D-10');
                    InsertResource(2, 'Bob Res', '1002', 'D-20');
                    InsertResource(3, 'Carol Res', '1003', 'D-30');
                end;
            }

            action(DemoInsertEmployee)
            {
                Caption = 'Demo Insert Employee';
                ToolTip = 'Demo Insert Employee';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Employee: Record "Demo Employee";
                    TransactionType: TransactionType;
                begin
                    TransactionType := CurrentTransactionType();
                    ModifyEmployee(1, '999');
                    sleep(5000);

                    Employee.Init();
                    Employee."No." := 4;
                    Employee.Name := 'Dave';
                    Employee.Phone := '999';
                    TransactionType := CurrentTransactionType();
                    Employee.Insert(true);
                    sleep(5000);
                    TransactionType := CurrentTransactionType();
                end;
            }
            action(DemoModifyEmployee)
            {
                Caption = 'Demo Modify Employee';
                ToolTip = 'Demo Modify Employee';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Employee: Record "Demo Employee";
                    TransactionType: TransactionType;
                    IsInWriteTransaction: Boolean;
                    ValDuringTransaction: Text;
                begin
                    Employee.Get(1);
                    Employee.Phone := '99';

                    Employee.Modify(true);

                    Employee.Init();
                    Employee.Get(1);
                    ValDuringTransaction := Employee.Phone;
                end;
            }
            action(DemoModifyEmployeeNested)
            {
                Caption = 'Demo Modify Employee Nested';
                ToolTip = 'Demo Modify Employee Nested';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Employee: Record "Demo Employee";
                    TransactionType: TransactionType;
                    IsInWriteTransaction: Boolean;
                    ValDuringTransaction: Text;
                begin
                    Employee.Get(1);
                    Employee.Phone := '99';

                    // Employee.Modify(true);

                    ModifyEmployee(2, 'xxxxxx');
                end;
            }

            action(DemoUpdateEmployeeSleep)
            {
                Caption = 'Demo Update Employee Sleep';
                ToolTip = 'Demo Update Employee Sleep';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Employee: Record "Demo Employee";
                begin
                    Employee.Get(1);
                    Employee.Validate(Employee.Phone, 'aaa');
                    Employee.Modify(true);

                    Employee.Get(2);
                    Employee.Validate(Employee.Phone, 'bbb');
                    Employee.Modify(true);

                    sleep(2000);
                end;
            }
            action(DemoUpdateEmployeeErr)
            {
                Caption = 'Demo Update Employee Error';
                ToolTip = 'Demo Update Employee Error';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Employee: Record "Demo Employee";
                begin
                    Employee.Get(1);
                    Employee.Phone := '99';

                    Employee.Modify(true);
                    error('dropping error before commit');
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
        Resource: Record "Demo Resource";
    begin
        Resource.Init();
        Resource."No." := No;
        Resource.Name := Name;
        Resource.Phone := Phone;
        // Res."Department Code" := Dept;
        Resource.Insert();
    end;

    local procedure ModifyEmployee(No: Integer; Phone: Text)
    var
        Employee: Record "Demo Employee";
    begin
        Employee.Get(No);
        Employee.Phone := Phone;
        Employee.Modify(false);
    end;

    local procedure ModifyResource(No: Integer; Phone: Text)
    var
        Resource: Record "Demo Resource";
    begin
        Resource.Get(No);
        Resource.Phone := Phone;
        Resource.Modify(false);
    end;
}

