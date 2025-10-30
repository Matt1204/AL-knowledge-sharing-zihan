codeunit 50101 "UtilityCod"
{
    procedure InspectDirectUnitCost(ResourceNo: Code[20]): Decimal
    var
        Resource: Record "Resource";
        DirectUnitCost: Decimal;
    begin
        if Resource.Get(ResourceNo) then begin
            DirectUnitCost := Resource."Direct Unit Cost";
            exit(DirectUnitCost);
        end;
    end;
}