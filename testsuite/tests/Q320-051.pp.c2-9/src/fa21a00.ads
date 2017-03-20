-- FA21A00.A
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
-- FOUNDATION DESCRIPTION:
--      This foundation declares various supporting types, objects, and
--      subprograms for use in tests checking preelaborability.
--
--      Types that do not have Preelaborable_Initialization are marked
--      "Not P_I".
--
-- CHANGE HISTORY:
--      20 Mar 95   SAIC    Initial prerelease version.
--      22 Mar 07   RLB     Ensured that the controlled type is not
--                          preelaborable. Marked types that do not have
--                          Preelaborable_Initialization.
--
--!

with Ada.Finalization; -- Preelaborated library unit.
package FA21A00 is

   pragma Preelaborate (FA21A00);


   type My_Int is new Integer range 0 .. 100;
   function Func return My_Int;                 -- Non-static function.

   subtype Idx is Natural range 1 .. 5;

   Zero  : constant My_Int :=  0;
   Three : constant My_Int :=  3;
   Ten   :          My_Int := 10;               -- Non-static.

   type RecWithDisc (D: My_Int) is record       -- Not P_I.
      Twice: My_Int := D*2;
   end record;

   type RecCallDefault is record                -- Not P_I.
      C : My_Int := Func;
      D : My_Int := 0;
   end record;

   type RecPrimDefault is record                -- Not P_I.
      C : My_Int := Ten;
   end record;

   type Tag is tagged record
      C : My_Int;
   end record;

   type AccTag is access all Tag;

   Tag1: aliased Tag;                           -- OK.

   type My_Controlled is new Ada.Finalization.Controlled with record
      -- Not P_I because of user-defined Initialize.
      C : My_Int;
   end record;

   procedure Initialize (Object : in out My_Controlled);

   type ContComp is tagged record               -- Not P_I.
      C: My_Controlled;
   end record;

   task type Tsk (D: My_Int);                   -- Not P_I.

   protected type Prot is                       -- Not P_I.
      entry E;
   end Prot;

   type Priv is tagged private;                 -- Not P_I (no pragma).

   type PrivComp is array (1 .. 5) of Priv;     -- Not P_I.

   type Pri_Ext is new Tag with private;        -- Not P_I (no pragma).

   type PriExtComp is array (1 .. 5) of Pri_Ext;-- Not P_I.

private

   type Priv is tagged record
      B: Boolean;
   end record;

   type Pri_Ext is new Tag with record
      N: String (1 .. 5);
   end record;

end FA21A00;
