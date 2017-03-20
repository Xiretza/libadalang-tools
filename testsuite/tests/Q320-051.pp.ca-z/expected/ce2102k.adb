-- CE2102K.ADA

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
--     CHECK THAT USE_ERROR IS RAISED IF AN IMPLEMENTATION DOES NOT
--     SUPPORT RESET FOR DIRECT_IO.

-- APPLICABILITY CRITERIA:
--     THIS TEST IS APPLICABLE ONLY TO IMPLEMENTATIONS WHICH SUPPORT
--     DIRECT FILES.

-- HISTORY:
--     TBN 02/12/86  CREATED ORIGINAL TEST.
--     TBN 09/15/87  COMPLETELY REVISED TEST.

with Direct_Io;
with Report; use Report;
procedure Ce2102k is
   Incomplete : exception;
begin
   Test
     ("CE2102K",
      "CHECK THAT USE_ERROR IS RAISED IF AN " &
      "IMPLEMENTATION DOES NOT SUPPORT RESET FOR " &
      "DIRECT_IO");
   declare
      package Dir is new Direct_Io (Integer);
      use Dir;
      File1 : File_Type;
      Int1  : Integer := Ident_Int (1);
      Int2  : Integer := 2;
   begin
      begin
         Create (File1, Out_File, Legal_File_Name);
      exception
         when Use_Error =>
            Not_Applicable
              ("USE_ERROR RAISED ON CREATE OF " &
               "DIRECT FILE WITH OUT_FILE MODE");
            raise Incomplete;
         when Name_Error =>
            Not_Applicable
              ("NAME_ERROR RAISED ON CREATE OF " &
               "DIRECT FILE WITH OUT_FILE MODE");
            raise Incomplete;
      end;

      Write (File1, Int2);

      -- RESETTING FROM OUT_FILE TO IN_FILE.

      begin
         Reset (File1, In_File);
         Comment ("RESET FROM OUT_FILE TO IN_FILE IS ALLOWED");
         begin
            Read (File1, Int1);
            if Int1 /= Ident_Int (2) then
               Failed
                 ("RESETTING FROM OUT_FILE TO IN_FILE " & "AFFECTED DATA");
            end if;
         exception
            when others =>
               Failed
                 ("UNEXPECTED EXCEPTION RAISED WHILE " &
                  "READING FROM FILE - 1");
         end;
      exception
         when Use_Error =>
            Comment ("RESET FROM OUT_FILE TO IN_FILE IS NOT " & "ALLOWED");
         when others =>
            Failed
              ("UNEXPECTED EXCEPTION RAISED WHEN " &
               "RESETTING FROM OUT_FILE TO IN_FILE");
      end;

      Close (File1);

      -- RESETTING FROM OUT_FILE TO INOUT_FILE.

      Create (File1, Out_File, Legal_File_Name (2));

      Write (File1, Int2);
      begin
         Reset (File1, Inout_File);
         Comment ("RESET FROM OUT_FILE TO INOUT_FILE IS ALLOWED");
         begin
            Read (File1, Int1);
            if Int1 /= Ident_Int (2) then
               Failed
                 ("RESETTING FROM OUT_FILE TO " & "INOUT_FILE AFFECTED DATA");
            end if;
         exception
            when others =>
               Failed
                 ("UNEXPECTED EXCEPTION RAISED WHILE " &
                  "READING FROM FILE - 2");
         end;
      exception
         when Use_Error =>
            Comment ("RESET FROM OUT_FILE TO INOUT_FILE IS " & "NOT ALLOWED");
         when others =>
            Failed
              ("UNEXPECTED EXCEPTION RAISED WHEN " &
               "RESETTING FROM OUT_FILE TO INOUT_FILE");
      end;

      begin
         Delete (File1);
      exception
         when Use_Error =>
            null;
      end;

      -- RESETTING FROM IN_FILE TO OUT_FILE.

      begin
         Open (File1, In_File, Legal_File_Name);
      exception
         when Use_Error =>
            Not_Applicable
              ("USE_ERROR RAISED ON OPENING OF " &
               "DIRECT FILE WITH IN_FILE MODE");
            raise Incomplete;
      end;

      begin
         Reset (File1, Out_File);
         Comment ("RESET FROM IN_FILE TO OUT_FILE IS ALLOWED");
      exception
         when Use_Error =>
            Comment ("RESET FROM IN_FILE TO OUT_FILE IS NOT " & "ALLOWED");
         when others =>
            Failed
              ("UNEXPECTED EXCEPTION RAISED WHEN " &
               "RESETTING FROM IN_FILE TO OUT_FILE");
      end;

      Close (File1);

      -- RESETTING FROM IN_FILE TO INOUT_FILE.

      Open (File1, In_File, Legal_File_Name);

      begin
         Reset (File1, Inout_File);
         Comment ("RESET FROM IN_FILE TO INOUT_FILE IS ALLOWED");
         begin
            Read (File1, Int1);
            if Int1 /= Ident_Int (2) then
               Failed
                 ("RESETTING FROM IN_FILE TO " & "INOUT_FILE AFFECTED DATA");
            end if;
         exception
            when others =>
               Failed
                 ("UNEXPECTED EXCEPTION RAISED WHILE " &
                  "READING FROM FILE - 3");
         end;
      exception
         when Use_Error =>
            Comment ("RESET FROM IN_FILE TO INOUT_FILE IS " & "NOT ALLOWED");
         when others =>
            Failed
              ("UNEXPECTED EXCEPTION RAISED WHEN " &
               "RESETTING FROM IN_FILE TO INOUT_FILE");
      end;

      Close (File1);

      -- RESETTING FROM INOUT_FILE TO IN_FILE.

      begin
         Open (File1, Inout_File, Legal_File_Name);
      exception
         when Use_Error =>
            Not_Applicable
              ("USE_ERROR RAISED ON OPENING OF " &
               "DIRECT FILE WITH INOUT_FILE MODE");
            raise Incomplete;
      end;

      begin
         Reset (File1, In_File);
         Comment ("RESET FROM INOUT_FILE TO IN_FILE IS ALLOWED");
         begin
            Read (File1, Int1);
            if Int1 /= Ident_Int (2) then
               Failed
                 ("RESETTING FROM INOUT_FILE TO " & "IN_FILE AFFECTED DATA");
            end if;
         exception
            when others =>
               Failed
                 ("UNEXPECTED EXCEPTION RAISED WHILE " &
                  "READING FROM FILE - 2");
         end;
      exception
         when Use_Error =>
            Comment ("RESET FROM INOUT_FILE TO IN_FILE IS " & "NOT ALLOWED");
         when others =>
            Failed
              ("UNEXPECTED EXCEPTION RAISED WHEN " &
               "RESETTING FROM INOUT_FILE TO IN_FILE");
      end;

      Close (File1);

      -- RESETTING FROM INOUT_FILE TO OUT_FILE.

      Open (File1, Inout_File, Legal_File_Name);

      begin
         Reset (File1, Out_File);
         Comment ("RESET FROM INOUT_FILE TO OUT_FILE IS ALLOWED");
      exception
         when Use_Error =>
            Comment ("RESET FROM INOUT_FILE TO OUT_FILE IS " & "NOT ALLOWED");
         when others =>
            Failed
              ("UNEXPECTED EXCEPTION RAISED WHEN " &
               "RESETTING FROM INOUT_FILE TO OUT_FILE");
      end;

      begin
         Delete (File1);
      exception
         when Use_Error =>
            null;
      end;

   exception
      when Incomplete =>
         null;
   end;

   Result;
end Ce2102k;
