-- CXD4005.A
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
--      Check that when Priority Queuing is in effect and the base priority
--      of a task is set (changed), the priorities of any queued calls from
--      that task to entries in a Protected Object are updated and that the
--      ordering is modified accordingly.
--
-- TEST DESCRIPTION:
--      Generate three tasks at the default priority.  These tasks each call
--      the distributor.  There is a guard in effect so the calls are all
--      queued.  Once all tasks are queued the base priority of the third
--      task is raised.  The guard is then released and the order of the
--      items being taken from the queue is checked.  The call from the third
--      task should be the one first handled.
--
-- SPECIAL REQUIREMENTS
--      The implementation must process a configuration pragma which is not
--      part of any Compilation Unit; the method employed is implementation
--      defined.
--
--
-- CHANGE HISTORY:
--      06 Dec 94   SAIC    ACVC 2.0
--      09 Nov 95   SAIC    Provided time for priority change to take
--                          place.  ACVC 2.0.1
--
--!

-----------------------  Configuration Pragmas --------------------

pragma Queuing_Policy (Priority_Queuing);

-------------------  End of Configuration Pragmas --------------------

with System;
with Report;
with Impdef;
with Ada.Task_Identification;
with Ada.Dynamic_Priorities;

procedure Cxd4005 is

   package Ati renames Ada.Task_Identification;
   package Adp renames Ada.Dynamic_Priorities;

   Tc_Failed : Boolean := False;

begin

   Report.Test
     ("CXD4005",
      "Reordering entry queues of Protected" & " Objects on Priority change");

   declare  -- encapsulate the test

      -- This is a priority that is higher than the default priority
      Priority_3q : constant System.Priority := (System.Default_Priority + 5);

      Current : Integer;   -- Input queue length
      pragma Volatile (Current);

      -- Message Numbers for the test messages
      Message_1_Numb : Integer := 100;
      Message_2_Numb : Integer := 101;
      Message_3_Numb : Integer := 102;

      -- Repository for the Task Identifications returned by the tasks
      -- at the Start entries
      Message_1_Id : Ati.Task_Id;
      Message_2_Id : Ati.Task_Id;
      Message_3_Id : Ati.Task_Id;

      task type Message_Task is
         entry Start (Numb : in Integer; Task_Id : out Ati.Task_Id);
      end Message_Task;
      type Acc_Message_Task is access Message_Task;

      protected Distributor is
         procedure Release;
         function Nb_Waiting return Integer;
         entry Input (Numb : Integer);

      private

         -- Guard for the Distributor Input queue
         Release_Messages : Boolean := False;
         First_Message    : Boolean := True;

      end Distributor;

      protected body Distributor is

         procedure Release is
         begin
            Release_Messages := True;
         end Release;

         function Nb_Waiting return Integer is
         begin
            return Input'Count;
         end Nb_Waiting;

         entry Input (Numb : Integer) when Release_Messages is
         -- In an application this message would be requeued to
         -- other tasks downstream; for this test we just check
         -- the arrival order and discard
         begin
            if First_Message then
               if Numb /= 102 then
                  -- We cannot call Report from within a P.O. so we
                  -- have to set a flag
                  Tc_Failed := True;
               end if;
               First_Message := False;
            end if;
         end Input;

      end Distributor;

      task body Message_Task is
         This_Message_Number : Integer;
      begin
         accept Start (Numb : in Integer; Task_Id : out Ati.Task_Id) do

            -- Hold the "message" in this task.  For the test we are just
            -- noting the Message_Number
            This_Message_Number := Numb;

            -- Get the system assigned Task_Id for this task and "return"
            -- it to the caller
            Task_Id := Ati.Current_Task;

         end Start;
         Distributor.Input (This_Message_Number);
      exception
         when others =>
            Report.Failed ("Unexpected Exception in Message_Task");
      end Message_Task;

      -- Create three tasks, all at the default priority.
      Message_1 : Acc_Message_Task := new Message_Task;
      Message_2 : Acc_Message_Task := new Message_Task;
      Message_3 : Acc_Message_Task := new Message_Task;

   begin -- declare

      -- Start up the first Message carrier task.  For the test, just
      -- present it with a message Number rather than a whole message.
      -- Save the Task Identification, which is returned at the end of the
      -- rendezvous, for later priority modification
      Message_1.Start (Message_1_Numb, Message_1_Id);

      -- Start the second
      Message_2.Start (Message_2_Numb, Message_2_Id);

      -- Wait for the two messages to arrive on the  Distributor's queue
      loop
         Current := Distributor.Nb_Waiting;
         exit when Current = 2;
         delay Impdef.Minimum_Task_Switch;
      end loop;

      -- Start the third
      Message_3.Start (Message_3_Numb, Message_3_Id);

      -- Wait for the third message to arrive
      loop
         Current := Distributor.Nb_Waiting;
         exit when Current = 3;
         delay Impdef.Minimum_Task_Switch;
      end loop;

      -- All messages are now waiting on the Distributor's queue.
      -- Increase the priority of the third message.
      Adp.Set_Priority (Priority_3q, Message_3_Id);

      -- allow time for Set_Priority to take effect
      delay Impdef.Minimum_Task_Switch;

      -- The third message should now have been moved to the front of
      -- the queue.  Release the messages - the distributor will now
      -- check the ordering.
      Distributor.Release;
   end; -- declare

   if Tc_Failed then
      Report.Failed ("Messages out of sequence");
   end if;

   Report.Result;

end Cxd4005;
