with Tctouch;
package body C3a0007_1 is

   procedure Set_Priority (B : in out Priority_Button) is
   begin
      Tctouch.Touch ('s'); --------------------------------------------- s
      B.Priority := 1;
   end Set_Priority;

   procedure Response (B : in out Priority_Button) is
   begin
      Tctouch.Touch ('d'); --------------------------------------------- d
   end Response;

end C3a0007_1;
