-- CA2004A0M.ADA

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
-- CHECK THAT A SUBUNIT HAS VISIBILITY OF IDENTIFIERS DECLARED
--   IN ANCESTORS OTHER THAN THE PARENT.

-- SEPARATE FILES ARE:
--   CA2004A0M THE MAIN PROCEDURE.
--   CA2004A1  A SUBUNIT PACKAGE BODY.
--   CA2004A2  A SUBUNIT PROCEDURE BODY.
--   CA2004A3  A SUBUNIT PROCEDURE BODY.
--   CA2004A4  A SUBUNIT PROCEDURE BODY.

-- WKB 6/26/81
-- JRK 6/26/81
-- BHS 7/31/84

with Report; use Report;
procedure Ca2004a0m is

   I : Integer := 1;

   package Ca2004a1 is
      J : Integer := 2;
      procedure Ca2004a2;
   end Ca2004a1;

   use Ca2004a1;
   package body Ca2004a1 is separate;
   procedure Ca2004a3 is separate;

begin
   Test
     ("CA2004A",
      "CHECK THAT A SUBUNIT HAS VISIBILITY OF " &
      "IDENTIFIERS DECLARED IN ANCESTORS");

   Ca2004a1.Ca2004a2;

   Ca2004a3;

   Result;
end Ca2004a0m;
