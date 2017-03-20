

     --==================================================================--


-- The implementation of CC51D01_1 is purely artificial; the validity
-- of its implementation in the context of the abstraction is irrelevant
-- to the feature being tested.
--
-- The expected behavior here is as follows: for each actual type corresponding
-- to Elem_Type, the call to Update_ID should invoke the actual type's
-- implementation, which updates the object's SSN field. Write_Element then
-- adds the object to the list.

procedure CC51D01_1 (L : in out List_Mgr.List_Type; E : in Elem_Type) is
   Element : Elem_Type := E;   -- Can't update IN parameter.
begin
   Update_ID (Element);                    -- Executes actual type's version.
   List_Mgr.Write_Element (1, L, Element); -- Executes actual type's version.
end CC51D01_1;
