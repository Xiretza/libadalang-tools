-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

with Tctouch;
package body Fdb0a00.Comparator is

   function "="
     (A, B : System.Storage_Pools.Root_Storage_Pool'Class) return Boolean
   is
      use type System.Address;
   begin
      return A'Address = B'Address;
   end "=";

end Fdb0a00.Comparator;
