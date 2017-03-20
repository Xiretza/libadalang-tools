-- C9A009G.ADA

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
-- CHECK THAT A MASTER ABORTED WITH SUBTASKS IN AN ENTRY CALL BECOMES
-- COMPLETED, BUT NOT TERMINATED, BEFORE THE END OF THE RENDEZVOUS.

-- JEAN-PIERRE ROSEN 16-MAR-1984
-- JBG 6/1/84
-- PWN 11/30/94 REMOVED PRAGMA PRIORITY INSTANCES FOR ADA 9X.

with Report, System;
use Report, System;
procedure C9a009g is

   task Blocking is
      entry Start;
      entry Stop;
      entry Restart;
      entry No_Call;
   end Blocking;

   task body Blocking is
   begin
      select
         accept Stop do
            accept Start;
            accept Restart;
         end Stop;
      or
         terminate;
      end select;
   end Blocking;

begin

   Test ("C9A009G", "MASTER COMPLETED BUT NOT TERMINATED");

   declare         -- T1 ABORTED WHILE DEPENDENT TASK IN RENDEVOUS 9C?

      task T1 is
         entry Lock;
      end T1;

      task body T1 is
         task T2;

         task body T2 is
         begin
            Blocking.Stop;
            Failed ("T2 NOT ABORTED");
         end T2;
      begin
         Blocking.No_Call;          -- WILL DEADLOCK UNTIL ABORT
      end T1;

   begin
      Blocking.Start;
      abort T1;

      if T1'Callable then
         Failed ("T1 STILL CALLABLE - 2");
      end if;

      if T1'Terminated then    -- T1'S DEPENDENT TASK, T2, STILL IN
         -- RENDEVOUS
         Failed ("T1 PREMATURELY TERMINATED - 2");
      end if;

      Blocking.Restart;
   end;

   Result;

end C9a009g;
