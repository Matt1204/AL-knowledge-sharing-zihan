page 50111 "Demo Resource List"
{
    PageType = List;
    Caption = 'Demo Resource List';
    ApplicationArea = All;
    SourceTable = "Demo Resource";
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
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                // field("Department Code"; Rec."Department Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Phone (Flow)"; Rec."Phone (Flow)")
                {
                    ApplicationArea = All;
                    ToolTip = 'FlowField sourced from Demo Employee';
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         group(SyncMode)
    //         {
    //             Caption = 'Set Sync Mode';
    //             action(SetNone)
    //             {
    //                 Caption = 'None';
    //                 ApplicationArea = All;
    //                 trigger OnAction()
    //                 var
    //                     Setup: Codeunit "Demo EmpRes Setup";
    //                     Mode: Enum "Demo EmpRes Sync Mode";
    //                 begin
    //                     Mode := Mode::None;
    //                     Setup.SetSyncMode(Mode);
    //                     Message('Sync mode set to None');
    //                 end;
    //             }
    //             action(SetTableTrue)
    //             {
    //                 Caption = 'Table Trigger (Modify true)';
    //                 ApplicationArea = All;
    //                 trigger OnAction()
    //                 var
    //                     Setup: Codeunit "Demo EmpRes Setup";
    //                     Mode: Enum "Demo EmpRes Sync Mode";
    //                 begin
    //                     Mode := Mode::UseTableTriggerTrue;
    //                     Setup.SetSyncMode(Mode);
    //                     Message('Sync mode set to Table Trigger (Modify true)');
    //                 end;
    //             }
    //             action(SetTableFalse)
    //             {
    //                 Caption = 'Table Trigger (Modify false)';
    //                 ApplicationArea = All;
    //                 trigger OnAction()
    //                 var
    //                     Setup: Codeunit "Demo EmpRes Setup";
    //                     Mode: Enum "Demo EmpRes Sync Mode";
    //                 begin
    //                     Mode := Mode::UseTableTriggerFalse;
    //                     Setup.SetSyncMode(Mode);
    //                     Message('Sync mode set to Table Trigger (Modify false)');
    //                 end;
    //             }
    //             action(SetEvent)
    //             {
    //                 Caption = 'Trigger Event';
    //                 ApplicationArea = All;
    //                 trigger OnAction()
    //                 var
    //                     Setup: Codeunit "Demo EmpRes Setup";
    //                     Mode: Enum "Demo EmpRes Sync Mode";
    //                 begin
    //                     Mode := Mode::UseTriggerEvent;
    //                     Setup.SetSyncMode(Mode);
    //                     Message('Sync mode set to Trigger Event');
    //                 end;
    //             }
    //         }

    //         // action(UpdateSelectedDirect)
    //         // {
    //         //     Caption = 'Update Selected (Direct)';
    //         //     ApplicationArea = All;
    //         //     trigger OnAction()
    //         //     begin
    //         //         Rec.TestField("No.");
    //         //         Rec.Phone := CopyStr(Rec.Phone + 'D', 1, MaxStrLen(Rec.Phone));
    //         //         Rec.Modify(true);
    //         //     end;
    //         // }

    //         // action(UpdateSelectedViaService)
    //         // {
    //         //     Caption = 'Update Selected (Service)';
    //         //     ApplicationArea = All;
    //         //     trigger OnAction()
    //         //     var
    //         //         Svc: Codeunit "Demo EmpRes Service";
    //         //         NewPhone: Text[50];
    //         //     begin
    //         //         Rec.TestField("No.");
    //         //         NewPhone := CopyStr(Rec.Phone + 'S', 1, MaxStrLen(Rec.Phone));
    //         //         Svc.SetResourceDetails(Rec."No.", NewPhone, Rec."Department Code");
    //         //         CurrPage.Update(false);
    //         //     end;
    //         // }
    //     }
    // }
}