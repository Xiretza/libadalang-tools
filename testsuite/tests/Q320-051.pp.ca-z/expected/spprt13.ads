-- SPPRT13SP.TST
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
-- SPECIFICATION FOR PACKAGE SPPRT13

-- PURPOSE:
--     THIS PACKAGE CONTAINS CONSTANTS OF TYPE SYSTEM.ADDRESS.
--     THESE CONSTANTS ARE USED BY SELECTED CHAPTER 13 TESTS,
--     BY PARTS OF THE AVAT SYSTEM, AND BY ISOLATED TESTS FOR
--     OTHER CHAPTERS.

-- MACRO SUBSTITUTIONS:
--     $VARIABLE_ADDRESS, $VARIABLE_ADDRESS1, AND $VARIABLE_ADDRESS2 ARE
--     EXPRESSIONS YIELDING LEGAL ADDRESSES FOR VARIABLES FOR THIS
--     IMPLEMENTATION.

--     $ENTRY_ADDRESS, $ENTRY_ADDRESS1, AND $ENTRY_ADDRESS2 ARE
--     EXPRESSIONS YIELDING LEGAL ADDRESSES FOR TASK ENTRIES
--     (I.E., FOR INTERRUPTS) FOR THIS IMPLEMENTATION.

--     IF NO EXPRESSIONS CAN BE GIVEN THAT ARE SATISFACTORY FOR THE
--     VALUES OF THESE CONSTANTS, THEN DECLARE SUITABLE FUNCTIONS
--     IN THE SPECIFICATION OF PACKAGE FCNDECL, CREATE A PACKAGE BODY
--     CONTAINING BODIES FOR THE FUNCTIONS, AND REPLACE THE MACROS WITH
--     APPROPRIATE FUNCTION CALLS.

with Fcndecl; use Fcndecl;
with System;
package Spprt13 is

   Variable_Address  : constant System.Address := Var_Addr;
   Variable_Address1 : constant System.Address := Var_Addr1;
   Variable_Address2 : constant System.Address := Var_Addr2;

   Entry_Address  : constant System.Address := Entry_Addr;
   Entry_Address1 : constant System.Address := Entry_Addr1;
   Entry_Address2 : constant System.Address := Entry_Addr2;

end Spprt13;
