-- FDD2A00.A
--
--                             Grant of Unlimited Rights
--
--     The Ada Conformity Assessment Authority (ACAA) holds unlimited
--     rights in the software and documentation contained herein. Unlimited
--     rights are the same as those granted by the U.S. Government for older
--     parts of the Ada Conformity Assessment Test Suite, and are defined
--     in DFAR 252.227-7013(a)(19). By making this public release, the ACAA
--     intends to confer upon all recipients unlimited rights equal to those
--     held by the ACAA. These rights include rights to use, duplicate,
--     release or disclose the released technical data and computer software
--     in whole or in part, in any manner and for any purpose whatsoever, and
--     to have or permit others to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS.  THE GOVERNMENT MAKES NO EXPRESS OR IMPLIED
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--
--
-- FOUNDATION DESCRIPTION:
--      This foundation provides the basis for testing user-defined stream
--      attributes. It provides operations which count calls to stream
--      attributes.
--
-- CHANGE HISTORY:
--    30 JUL 2001   PHL   Initial version.
--     5 DEC 2001   RLB   Reformatted for ACATS.
--

with Ada.Streams;
use Ada.Streams;
package FDD2A00 is

    type Kinds is (Read, Write, Input, Output);
    type Counts is array (Kinds) of Natural;


    type My_Stream (Size : Stream_Element_Count) is new Root_Stream_Type with
        record
            First : Stream_Element_Offset := 1;
            Last : Stream_Element_Offset := 0;
            Contents : Stream_Element_Array (1 .. Size);
        end record;

    procedure Clear (Stream : in out My_Stream);

    procedure Read (Stream : in out My_Stream;
                    Item : out Stream_Element_Array;
                    Last : out Stream_Element_Offset);

    procedure Write (Stream : in out My_Stream; Item : in Stream_Element_Array);


    generic
        type T (<>) is limited private;
        with procedure Actual_Write
                          (Stream : access Root_Stream_Type'Class; Item : T);
        with function Actual_Input
                         (Stream : access Root_Stream_Type'Class) return T;
        with procedure Actual_Read (Stream : access Root_Stream_Type'Class;
                                    Item : out T);
        with procedure Actual_Output
                          (Stream : access Root_Stream_Type'Class; Item : T);
    package Counting_Stream_Ops is

        procedure Write (Stream : access Root_Stream_Type'Class; Item : T);
        function Input (Stream : access Root_Stream_Type'Class) return T;
        procedure Read (Stream : access Root_Stream_Type'Class; Item : out T);
        procedure Output (Stream : access Root_Stream_Type'Class; Item : T);

        function Get_Counts return Counts;

    end Counting_Stream_Ops;

end FDD2A00;
