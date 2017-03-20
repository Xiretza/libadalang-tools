-- C393007.A
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
-- TEST OBJECTIVE:
--      Check that an extended type can be derived from an abstract type,
--      where the abstract type is defined in a package, and the type derived
--      from it is defined in a distinct library package.
--
-- TEST DESCRIPTION:
--      Declare an private (abstract) type; declare two primitive operations 
--      of the type that are explicitly abstract.
--      Derive an extended type from the (private) abstract type, overriding 
--      both of the primitive operations.
--      This test also checks to see that name overloading between abstract
--      and non-abstract functions is resolved correctly.
--
--
-- CHANGE HISTORY:
--      06 Dec 94   SAIC    ACVC 2.0
--
--!

   package C393007_0 is
        -- Alert_System
 
     type DT_Type is new Integer;
 
     type Alert_Type is abstract tagged record
        Time_Of_Arrival : DT_Type;
     end record;
 
     type Log_File_Type is range 0 .. 100;
 
     Procedure Handle (A : in out Alert_type) is abstract;
       
     procedure Log    (A : Alert_Type;                   
                       L : in out Log_File_Type) is abstract;  
   
     procedure Set_Time (A : in out Alert_Type);
 
     function Correct_Time_Stamp (A : Alert_Type) return Boolean;
       
     Day_Time : DT_Type := 100;
 
   end C393007_0;
