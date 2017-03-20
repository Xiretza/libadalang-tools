-- CXF2A02.A
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
--      Check that the multiplying operators for a decimal fixed point type
--      return values that are integral multiples of the small of the type.
--      Check the case where the operand and result types are the same.
--
--      Check that if the mathematical result is between multiples of the
--      small of the result type, the result is truncated toward zero.
--    
-- TEST DESCRIPTION:
--      The test verifies that decimal multiplication and division behave as
--      expected for types with various digits, delta, and Machine_Radix
--      values.
--
--      The iteration, operation, and operand counts in the foundation, and
--      the operations and operand tables in the test, are given values such
--      that, when the operations loop is complete, truncation of inexact
--      results should cause the result returned by the operations loop to be
--      the same as that used to initialize the loop's cumulator variable (in
--      this test, one).
--
-- TEST FILES:
--      This test consists of the following files:
--
--         FXF2A00.A
--      -> CXF2A02.A
--
-- APPLICABILITY CRITERIA:
--      This test is only applicable for a compiler attempting validation
--      for the Information Systems Annex.
--
--
-- CHANGE HISTORY:
--      13 Mar 96   SAIC    Prerelease version for ACVC 2.1.
--      04 Aug 96   SAIC    Updated prologue.
--
--!

package CXF2A02_0 is

               ---=---=---=---=---=---=---=---=---=---=---

   type Micro is delta 10.0**(-5) digits 6; -- range -9.99999 ..
   for Micro'Machine_Radix use 2;      --            +9.99999

   function Multiply (Left, Right : Micro) return Micro;
   function Divide   (Left, Right : Micro) return Micro;


   type Micro_Optr_Ptr is access function (Left, Right : Micro) return Micro;

   Micro_Mult : Micro_Optr_Ptr := Multiply'Access;
   Micro_Div  : Micro_Optr_Ptr := Divide'Access;

               ---=---=---=---=---=---=---=---=---=---=---

   type Basic is delta 0.01 digits 11; -- range -999,999,999.99 ..
   for Basic'Machine_Radix use 10;     --       +999,999,999.99

   function Multiply (Left, Right : Basic) return Basic;
   function Divide   (Left, Right : Basic) return Basic;


   type Basic_Optr_Ptr is access function (Left, Right : Basic) return Basic;

   Basic_Mult : Basic_Optr_Ptr := Multiply'Access;
   Basic_Div  : Basic_Optr_Ptr := Divide'Access;

               ---=---=---=---=---=---=---=---=---=---=---

   type Broad is delta 10.0**(-3) digits 10; -- range -9,999,999.999 ..
   for Broad'Machine_Radix use 2;            --       +9,999,999.999

   function Multiply (Left, Right : Broad) return Broad;
   function Divide   (Left, Right : Broad) return Broad;


   type Broad_Optr_Ptr is access function (Left, Right : Broad) return Broad;

   Broad_Mult : Broad_Optr_Ptr := Multiply'Access;
   Broad_Div  : Broad_Optr_Ptr := Divide'Access;

               ---=---=---=---=---=---=---=---=---=---=---

end CXF2A02_0;
