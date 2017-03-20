-----------------------------------------------------------------------------

with Tctouch;
package body C3a0009_0 is

   procedure Push (B : in out Button) is
   begin
      Tctouch.Touch ('P'); --------------------------------------------- P
      -- Invoking subprogram designated by access value
      B.Response (B);
   end Push;

   procedure Set_Response (B : in out Button; R : in Button_Response_Ptr) is
   begin
      Tctouch.Touch ('S'); --------------------------------------------- S
      -- Set procedure value in record
      B.Response := R;
   end Set_Response;

   procedure Default_Response (B : in out Button) is
   begin
      Tctouch.Touch ('D'); --------------------------------------------- D
   end Default_Response;

   procedure Default_Action is
   begin
      Tctouch.Touch ('d'); --------------------------------------------- d
   end Default_Action;

   procedure Replacement_Action is
   begin
      Tctouch.Touch ('r'); --------------------------------------------- r
   end Replacement_Action;

   procedure Replace_Action (B : in out Alert_Button) is
   begin
      Tctouch.Touch ('R'); --------------------------------------------- R
      B.Action := Replacement_Action'Access;
   end Replace_Action;

   function Alert (B : in Alert_Button) return Button_Action_Ptr is
   begin
      Tctouch.Touch ('A'); --------------------------------------------- A
      return (B.Action);
   end Alert;

end C3a0009_0;
