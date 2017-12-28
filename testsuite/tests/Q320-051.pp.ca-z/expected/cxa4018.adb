-- CXA4018.A
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
--      Check that the subprograms defined in package
--      Ada.Strings.Wide_Bounded are available, and that they produce
--      correct results. Specifically, check the subprograms Append,
--      Count, Element, Find_Token, Head, Index_Non_Blank, Replace_Element,
--      Replicate, Tail, To_Bounded_Wide_String, "&", ">", "<", ">=", "<=",
--      and "*".
--
-- TEST DESCRIPTION:
--      This test, when taken in conjunction with test CXA40[17,19,20], will
--      constitute a test of all the functionality contained in package
--      Ada.Strings.Wide_Bounded.  This test uses a variety of the
--      subprograms defined in the wide bounded string package in ways typical
--      of common usage.  Different combinations of available subprograms
--      are used to accomplish similar wide bounded string processing goals.
--
--
-- CHANGE HISTORY:
--      06 Dec 94   SAIC    ACVC 2.0
--      22 Dec 94   SAIC    Changed obsolete constant to Strings.Wide_Space.
--      06 Nov 95   SAIC    Corrected evaluation string used in Head/Tail
--                          subtests for ACVC 2.0.1.
--
--!

with Ada.Strings;
with Ada.Strings.Wide_Bounded;
with Ada.Characters.Handling;
with Ada.Strings.Wide_Maps;
with Report;

procedure Cxa4018 is

   -- The following two functions are used to translate character and string
   -- values to "Wide" values. They will be applied to all the Wide_Bounded
   -- subprogram parameters to simulate the use of Wide_Characters and
   -- Wide_Strings in actual practice. Blanks are translated to Wide_Character
   -- blanks and all other characters are translated into Wide_Characters
   -- with position values 256 greater than their (narrow) character position
   -- values.

   function Translate (Ch : Character) return Wide_Character is
      C : Character := Ch;
   begin
      if Ch = ' ' then
         return Ada.Characters.Handling.To_Wide_Character (C);
      else
         return Wide_Character'Val
             (Character'Pos (Ch) + Character'Pos (Character'Last) + 1);
      end if;
   end Translate;

   function Translate (Str : String) return Wide_String is
      Ws : Wide_String (Str'First .. Str'Last);
   begin
      for I in Str'First .. Str'Last loop
         Ws (I) := Translate (Str (I));
      end loop;
      return Ws;
   end Translate;

begin

   Report.Test
     ("CXA4018",
      "Check that the subprograms defined in package " &
      "Ada.Strings.Wide_Bounded are available, and " &
      "that they produce correct results");

   Test_Block :
   declare

      package Bs80 is new Ada.Strings.Wide_Bounded.Generic_Bounded_Length (80);
      use type Bs80.Bounded_Wide_String;

      Part1 : constant Wide_String     := Translate ("Rum");
      Part2 : Wide_Character           := Translate ('p');
      Part3 : Bs80.Bounded_Wide_String :=
        Bs80.To_Bounded_Wide_String (Translate ("el"));
      Part4 : Wide_Character           := Translate ('s');
      Part5 : Bs80.Bounded_Wide_String :=
        Bs80.To_Bounded_Wide_String (Translate ("tilt"));
      Part6 : Wide_String (1 .. 3) := Translate ("ski");

      Full_Catenate_String,
      Full_Append_String,
      Constructed_String,
      Drop_String,
      Replicated_String,
      Token_String : Bs80.Bounded_Wide_String;

      Chara : Wide_Character := Translate ('A');
      Charb : Wide_Character := Translate ('B');
      Charc : Wide_Character := Translate ('C');
      Chard : Wide_Character := Translate ('D');
      Chare : Wide_Character := Translate ('E');
      Charf : Wide_Character := Translate ('F');

      Abstr : Wide_String (1 .. 15) := Translate ("AAAAABBBBBBBBBB");
      Strb  : Wide_String (1 .. 2)  := Translate ("BB");
      Stre  : Wide_String (1 .. 2)  := Translate ("EE");

   begin

      -- Evaluation of the overloaded forms of the "&" operator.

      Full_Catenate_String :=
        Bs80."&"
          (Part2,                            -- WChar & Bnd WStr
           Bs80."&"
             (Part3,                   -- Bnd WStr & Bnd WStr
              Bs80."&"
                (Part4,          -- WChar & Bnd WStr
                 Bs80."&" (Part5, -- Bnd WStr & Bnd WStr
                 Bs80.To_Bounded_Wide_String (Part6)))));

      Full_Catenate_String :=
        Bs80."&" (Part1, Full_Catenate_String);     -- WStr & Bnd WStr
      Full_Catenate_String :=
        Bs80."&"
          (Left  => Full_Catenate_String,
           Right => Translate ('n'));         -- Bnd WStr & WChar

      -- Evaluation of the overloaded forms of function Append.

      Full_Append_String :=
        Bs80.Append
          (Part2,                               -- WChar,Bnd WStr
           Bs80.Append
             (Part3,                             -- Bnd WStr, Bnd WStr
              Bs80.Append
                (Part4,                           -- WChar,Bnd WStr
                 Bs80.Append
                   (Bs80.To_Wide_String (Part5),    -- WStr,Bnd WStr
                    Bs80.To_Bounded_Wide_String (Part6)))));

      Full_Append_String :=
        Bs80.Append
          (Bs80.To_Bounded_Wide_String (Part1),  -- Bnd WStr, WStr
           Bs80.To_Wide_String (Full_Append_String));

      Full_Append_String :=
        Bs80.Append
          (Left  => Full_Append_String,
           Right => Translate ('n'));             -- Bnd WStr, WChar

      -- Validate the resulting bounded wide strings.

      if Bs80."<" (Full_Catenate_String, Full_Append_String) or
        Bs80.">" (Full_Catenate_String, Full_Append_String) or
        not
        (Full_Catenate_String = Full_Append_String and
         Bs80."<=" (Full_Catenate_String, Full_Append_String) and
         Bs80.">=" (Full_Catenate_String, Full_Append_String))
      then
         Report.Failed
           ("Incorrect results from bounded wide string catenation" &
            " and comparison");
      end if;

      -- Evaluate the overloaded forms of the Constructor function "*" and the
      -- Replicate function.

      Constructed_String :=
        Bs80."*" (2, Chara) &                     -- "AA"
        Bs80."*" (2, Strb) &                      -- "AABBBB"
        Bs80."*" (3, Bs80."*" (2, Charc)) &       -- "AABBBBCCCCCC"
        Bs80.Replicate
          (3,
           Bs80.Replicate (2, Chard)) &  -- "AABBBBCCCCCCDDDDDD"
        Bs80.Replicate (2, Stre) &               -- "AABBBBCCCCCCDDDDDDEEEE"
        Bs80.Replicate (2, Charf);               -- "AABBBBCCCCCCDDDDDDEEEEFF"

      -- Use of Function Replicate that involves dropping wide characters.
      -- The attempt to replicate the 15 character wide string six times will
      -- exceed the 80 wide character bound of the wide string. Therefore,
      -- the result should be the catenation of 5 copies of the 15 character
      -- wide string, followed by 5 'A' wide characters (the first five wide
      -- characters of the 6th replication) with the remaining wide characters
      -- of the 6th replication dropped.

      Drop_String :=
        Bs80.Replicate
          (Count => 6,
           Item  => Abstr,
                        -- "AAAAABBBBBBBBBB"
        Drop => Ada.Strings.Right);

      if Bs80.Element (Drop_String, 1) /= Translate ('A') or
        Bs80.Element (Drop_String, 6) /= Translate ('B') or
        Bs80.Element (Drop_String, 76) /= Translate ('A') or
        Bs80.Element (Drop_String, 80) /= Translate ('A')
      then
         Report.Failed ("Incorrect result from Replicate with Drop");
      end if;

      -- Use function Index_Non_Blank in the evaluation of the
      -- Constructed_String.

      if Bs80.Index_Non_Blank (Constructed_String, Ada.Strings.Forward) /=
        Bs80.To_Wide_String (Constructed_String)'First or
        Bs80.Index_Non_Blank (Constructed_String, Ada.Strings.Backward) /=
          Bs80.Length (Constructed_String)
      then
         Report.Failed ("Incorrect results from constructor functions");
      end if;

      declare

         -- Define wide character set objects for use with the Count function.
         -- Constructed_String = "AABBBBCCCCCCDDDDDDEEEEFF" from above.

         A_Set : Ada.Strings.Wide_Maps.Wide_Character_Set :=
           Ada.Strings.Wide_Maps.To_Set (Bs80.Element (Constructed_String, 1));
         B_Set : Ada.Strings.Wide_Maps.Wide_Character_Set :=
           Ada.Strings.Wide_Maps.To_Set (Bs80.Element (Constructed_String, 3));
         C_Set : Ada.Strings.Wide_Maps.Wide_Character_Set :=
           Ada.Strings.Wide_Maps.To_Set (Bs80.Element (Constructed_String, 7));
         D_Set : Ada.Strings.Wide_Maps.Wide_Character_Set :=
           Ada.Strings.Wide_Maps.To_Set
             (Bs80.Element (Constructed_String, 13));
         E_Set : Ada.Strings.Wide_Maps.Wide_Character_Set :=
           Ada.Strings.Wide_Maps.To_Set
             (Bs80.Element (Constructed_String, 19));
         F_Set : Ada.Strings.Wide_Maps.Wide_Character_Set :=
           Ada.Strings.Wide_Maps.To_Set
             (Bs80.Element (Constructed_String, 23));
         Start : Positive;
         Stop  : Natural := 0;

      begin

         -- Evaluate the results from function Count by comparing the number
         -- of A's to the number of F's, B's to E's, and C's to D's in the
         -- Constructed_String. There should be an equal number of each of the
         -- wide characters that are being compared (i.e., 2 A's and F's, 4 B's
         -- and E's, etc)

         if Bs80.Count (Constructed_String, A_Set) /=
           Bs80.Count (Constructed_String, F_Set) or
           Bs80.Count (Constructed_String, B_Set) /=
             Bs80.Count (Constructed_String, E_Set) or
           not
           (Bs80.Count (Constructed_String, C_Set) =
            Bs80.Count (Constructed_String, D_Set))
         then
            Report.Failed ("Incorrect result from function Count");
         end if;

         -- Evaluate the functions Head, Tail, and Find_Token. Create the
         -- Token_String from the Constructed_String above.

         Token_String :=
           Bs80.Tail (Bs80.Head (Constructed_String, 3), 2) &     -- "AB" &
           Bs80.Head (Bs80.Tail (Constructed_String, 13), 2) &     -- "CD" &
           Bs80.Head (Bs80.Tail (Constructed_String, 3), 2);      -- "EF"

         if Token_String /=
           Bs80.To_Bounded_Wide_String (Translate ("ABCDEF"))
         then
            Report.Failed ("Incorrect result from Catenation of Token_String");
         end if;

         -- Find the starting/ending position of the first A in the
         -- Token_String (both should be 1, only one A appears in string). The
         -- Function Head uses the default pad character to return a bounded
         -- wide string longer than its input parameter bounded wide string.

         Bs80.Find_Token
           (Bs80.Head (Token_String, 10),  -- Default pad.
            A_Set,
            Ada.Strings.Inside,
            Start,
            Stop);

         if Start /= 1 and Stop /= 1 then
            Report.Failed ("Incorrect result from Find_Token - 1");
         end if;

         -- Find the starting/ending position of the first non-AB slice in the
         -- "head" five wide characters of Token_String (slice CDE at positions
         -- 3-5)

         Bs80.Find_Token
           (Bs80.Head (Token_String, 5),               -- "ABCDE"
            Ada.Strings.Wide_Maps."OR" (A_Set, B_Set), -- Set (AB)
            Ada.Strings.Outside,
            Start,
            Stop);

         if Start /= 3 and Stop /= 5 then
            Report.Failed ("Incorrect result from Find_Token - 2");
         end if;

         -- Find the starting/ending position of the first CD slice in the
         -- "tail" eight wide characters (including two pad wide characters)
         -- of Token_String (slice CD at positions 5-6 of the tail portion
         -- specified)

         Bs80.Find_Token
           (Bs80.Tail (Token_String, 8, Ada.Strings.Wide_Space),
            Ada.Strings.Wide_Maps."OR" (C_Set, D_Set),
            Ada.Strings.Inside,
            Start,
            Stop);

         if Start /= 5 and Stop /= 6 then
            Report.Failed ("Incorrect result from Find_Token - 3");
         end if;

         -- Evaluate the Replace_Element function.

         -- Token_String = "ABCDEF"

         Bs80.Replace_Element
           (Token_String,
            3,
            Bs80.Element (Token_String, 4));

         -- Token_String = "ABDDEF"

         Bs80.Replace_Element
           (Source => Token_String,
            Index  => 2,
            By     => Bs80.Element (Token_String, 5));

         -- Token_String = "AEDDEF"

         Bs80.Replace_Element
           (Token_String,
            1,
            Bs80.Element (Bs80.Tail (Token_String, 2), 2));

         -- Token_String = "FEDDEF"
         -- Evaluate this result.

         if Bs80.Element
             (Token_String,
              Bs80.To_Wide_String (Token_String)'First) /=
           Bs80.Element
             (Token_String,
              Bs80.To_Wide_String (Token_String)'Last) or
           Bs80.Count (Token_String, D_Set) /=
             Bs80.Count (Token_String, E_Set) or
           Bs80.Index_Non_Blank (Bs80.Head (Token_String, 6)) /=
             Bs80.Index_Non_Blank (Bs80.Tail (Token_String, 6)) or
           Bs80.Head (Token_String, 1) /= Bs80.Tail (Token_String, 1)
         then
            Report.Failed ("Incorrect result from operations in combination");
         end if;

      end;

   exception
      when others =>
         Report.Failed ("Exception raised in Test_Block");
   end Test_Block;

   Report.Result;

end Cxa4018;
