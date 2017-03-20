-- CE3402E.ADA

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
--     CHECK THAT NEW_LINE RAISES CONSTRAINT_ERROR IF SPACING IS
--     ZERO, OR NEGATIVE.

-- HISTORY:
--     ABW 08/26/82
--     SPS 09/16/82
--     JBG 08/30/83
--     DWC 08/19/87  ADDED COUNT'LAST CASE.
--     PWN 10/27/95  REMOVED OUT OF RANGE STATIC VALUE CHECKS.

with Report;  use Report;
with Text_Io; use Text_Io;

procedure Ce3402e is

   File : File_Type;

begin

   Test
     ("CE3402E",
      "CHECK THAT NEW_LINE RAISES CONSTRAINT_ERROR " &
      "IF SPACING IS ZERO, OR NEGATIVE");

   begin
      New_Line (File, Positive_Count (Ident_Int (0)));
      Failed ("CONSTRAINT_ERROR NOT RAISED FOR ZERO");
   exception
      when Constraint_Error =>
         null;
      when others =>
         Failed ("OTHER EXCEPTION RAISED FOR ZERO");
   end;

   begin
      New_Line (File, Positive_Count (Ident_Int (-2)));
      Failed ("CONSTRAINT_ERROR NOT RAISED FOR NEGATIVE NUMBER");
   exception
      when Constraint_Error =>
         null;
      when others =>
         Failed ("OTHER EXCEPTION RAISED FOR NEGATIVE NUMBER");
   end;

   begin
      Create (File);
   exception
      when Use_Error =>
         null;
   end;

   begin
      New_Line (File, Positive_Count (Ident_Int (0)));
      Failed ("CONSTRAINT_ERROR NOT RAISED FOR ZERO");
   exception
      when Constraint_Error =>
         null;
      when others =>
         Failed ("OTHER EXCEPTION RAISED FOR ZERO");
   end;

   begin
      New_Line (File, Positive_Count (Ident_Int (-2)));
      Failed ("CONSTRAINT_ERROR NOT RAISED FOR NEGATIVE NUMBER");
   exception
      when Constraint_Error =>
         null;
      when others =>
         Failed ("OTHER EXCEPTION RAISED FOR NEGATIVE NUMBER");
   end;

   begin
      Delete (File);
   exception
      when others =>
         null;
   end;

   Result;

end Ce3402e;
