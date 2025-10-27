table 50101 "Class"
{

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Class Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Grade; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        Student: Record "Student";
        ClassRecId: RecordId;
    begin
        ClassRecId := Rec.RecordId();
        Student.SetRange("Class No.", Rec."No.");
        if Student.FindSet() then begin
            repeat
                Student.Grade := Rec.Grade;
                Student.Modify();
            until Student.Next() = 0;
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    // procedure InsertClass(No: Integer; ClassName: Text; Grade: Integer)
    // begin
    //     Rec.Init();
    //     Rec."No." := No;
    //     Rec."Class Name" := ClassName;
    //     Rec.Grade := Grade;
    //     Rec.Insert();
    // end;

}

// The changes to the Class record cannot be saved because some information on the page is not up-to-date. Close the page, reopen it, and try again. Identification fields and values: No.='1'