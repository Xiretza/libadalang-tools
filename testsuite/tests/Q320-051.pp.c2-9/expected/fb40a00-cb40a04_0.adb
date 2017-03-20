-- CB40A04.A
--
--                             Grant of Unlimited Rights
--
--     Under contracts F33600-87-D-0337, F33600-84-D-0280, MDA903-79-C-0687,
--     F08630-91-C-0015, and DCA100-97-D-0025, the U.S. Government obtained
--     unlimited rights in the software and documentation contained herein.
--     Unlimited rights are defined in DFAR 252.227-7013(a)(19).  By making
--     this public release, the Government intends to confer upon all
--     recipients unlimited rights  equal to those held by the Government.
--     These rights include rights to use, duplicate, release or disclose the
--     released technical data and computer software in whole or in part, in
--     any manner and for any purpose whatsoever, and to have or permit others
--     to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS.  THE GOVERNMENT MAKES NO EXPRESS OR IMPLIED
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--*
--
-- OBJECTIVE:
--      Check that a predefined exception is correctly propagated out of a
--      public child function to a client.
--
-- TEST DESCRIPTION:
--      Declare a public child subprogram.  Define the processing loop
--      inside the subprogram to expect a string with index starting at 1.
--      From the test procedure, call the child subprogram with a slice
--      from the middle of a string variable.  This will cause an exception
--      to be raised in the child and propagated to the caller.
--
--      Exception Type Raised:
--          User Defined
--        * Predefined
--
--      Hierarchical Structure Employed For This Test:
--        * Parent Package
--          Public Child Package
--          Private Child Package
--        * Public Child Subprogram
--          Private Child Subprogram
--
-- TEST FILES:
--      This test depends on the following foundation code:
--         FB40A00.A
--
--
-- CHANGE HISTORY:
--      06 Dec 94   SAIC    ACVC 2.0
--
--!

-- Child subprogram Text_Parser.Count_AlphaNumerics

function Fb40a00.Cb40a04_0 (Text : String) return Natural is
begin

   for I in 1 .. Text'Last loop          -- Raise immediate Constraint_Error
      if (Text (I) in 'a' .. 'z') or       -- with String slice passed from
        (Text (I) in 'A' .. 'Z') or       -- caller. (Slice'first /= 1)
        (Text (I) in '0' .. '9')
      then
         Increment_Alphanumeric_Count;
      else
         Increment_Non_Alphanumeric_Count;
      end if;
   end loop;

   return (Alphanumeric_Count);          -- Global in parent package.

   -- No exception handler here, exception propagates.

end Fb40a00.Cb40a04_0;
