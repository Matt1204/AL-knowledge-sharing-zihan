table 50100 "Student"
{

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Class No."; Integer)
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Class"."No.";
        }
        field(4; Grade; Integer)
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
        Class: Record "Class";
        ClassRecId: RecordId;
        Student: Record "Student";
    // ClassRecId2: RecordId;
    // ClassRecRef: RecordRef;
    begin
        Student.Get(Rec."No.");

        Class.Get(Rec."Class No.");
        Class.Grade := Rec.Grade;
        ClassRecId := Class.RecordId();
        Class.Modify();

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}


// If requesting support, please provide the following details to help troubleshooting:

// Error message: 
// The changes to the Class record cannot be saved because some information on the page is not up-to-date. Close the page, reopen it, and try again.

// Identification fields and values:

// No.='1'

// Internal session ID: 
// dd87e860-59e6-4f9c-bfa9-d76b4b2527eb

// Application Insights session ID: 
// 6de2a9a3-a286-453a-a3ef-69bdf796415b

// Client activity id: 
// 24e0c8c0-6dbf-3f6c-45a7-97fd05aeb1e6

// Time stamp on error: 
// 2025-10-27T18:37:08.0683813Z

// User telemetry id: 
// e9347cca-a8b3-4693-a742-32f39724c26c

// AL call stack: 
// "Demo Student List"(Page 50100)."UpdateClassGrade - OnAction"(Trigger) line 6 - 001_knowledge_sharing by Default Publisher version 1.0.0.0

