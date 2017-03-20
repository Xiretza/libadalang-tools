-- C34014T.ADA

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
-- OBJECTIVE:
--     CHECK THAT A DERIVED OPERATOR IS VISIBLE AND FURTHER DERIVABLE
--     UNDER APPROPRIATE CIRCUMSTANCES.

--     CHECK WHEN THE DERIVED OPERATOR IS IMPLICITLY DECLARED IN THE
--     VISIBLE PART OF A PACKAGE AND NO HOMOGRAPHIC OPERATOR IS LATER
--     DECLARED EXPLICITLY.

-- HISTORY:
--     JRK 09/22/87  CREATED ORIGINAL TEST.

with Report; use Report;

procedure C34014t is

   package P is
      type T is range -100 .. 100;
      function "+" (X : T) return T;
   end P;
   use P;

   package body P is
      function "+" (X : T) return T is
      begin
         return X + T (Ident_Int (1));
      end "+";
   end P;

begin
   Test
     ("C34014T",
      "CHECK THAT A DERIVED OPERATOR IS VISIBLE " &
      "AND FURTHER DERIVABLE UNDER APPROPRIATE " &
      "CIRCUMSTANCES.  CHECK WHEN THE DERIVED " &
      "OPERATOR IS IMPLICITLY DECLARED IN THE " &
      "VISIBLE PART OF A PACKAGE AND NO HOMOGRAPHIC " &
      "OPERATOR IS LATER DECLARED EXPLICITLY");

   -----------------------------------------------------------------

   Comment ("NO NEW OPERATOR DECLARED EXPLICITLY");

   declare

      package Q is
         type Qt is new T;
         X : Qt := +0;
      private
         type Qs is new Qt;
         Z : Qs := +0;
      end Q;
      use Q;

      package body Q is
      begin
         if X /= 1 then
            Failed ("OLD OPERATOR NOT VISIBLE - 1");
         end if;

         if Z /= 1 then
            Failed ("OLD OPERATOR NOT DERIVED - 1");
         end if;
      end Q;

      package R is
         Y : Qt := +0;
         type Rt is new Qt;
         Z : Rt := +0;
      end R;
      use R;

   begin
      if Y /= 1 then
         Failed ("OLD OPERATOR NOT VISIBLE - 2");
      end if;

      if Z /= 1 then
         Failed ("OLD OPERATOR NOT DERIVED - 2");
      end if;
   end;

   -----------------------------------------------------------------

   Result;
end C34014t;
