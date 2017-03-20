-- CA1020E0.ADA

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
--     CHECK THAT A SUBPROGRAM LIBRARY UNIT CAN BE REPLACED BY A GENERIC
--     INSTANTIATION HAVING THE SAME IDENTIFIER.  THIS FILE CONTAINS
--     GENERIC UNITS TO BE INSTANTIATED AS LIBRARY UNITS.

-- HISTORY:
--     JBG 05/28/85  CREATED ORIGINAL TEST.
--     JET 07/29/88  ADDED CASES IN WHICH SUBPROGRAM PROFILES ARE NOT
--                   THE SAME AND ALSO WHEN SUBPROGRAM IS FIRST
--                   DECLARED WITHOUT A BODY.

generic
   C : Integer;
procedure Genproc_Ca1020e (X : out Integer);
