with F393a00_0;
package body C393a05_0 is
   procedure Set_Grind (It : in out Grinder; The_Grind : Coarseness) is
   begin
      F393a00_0.Tc_Touch ('A');
      It.Grind := The_Grind;
   end Set_Grind;

   function Grind (It : Grinder) return Coarseness is
   begin
      F393a00_0.Tc_Touch ('B');
      return It.Grind;
   end Grind;

   procedure Swap (A, B : in out Grinder) is
      T : constant Grinder := A;
   begin
      F393a00_0.Tc_Touch ('C');
      A := B;
      B := T;
   end Swap;

   function Create return Grinder is
      One : Grinder;
   begin
      F393a00_0.Tc_Touch ('D');
      F393a00_4.Initialize (F393a00_4.Mill (One));
      One.Grind := Fine;
      return One;
   end Create;
end C393a05_0;
