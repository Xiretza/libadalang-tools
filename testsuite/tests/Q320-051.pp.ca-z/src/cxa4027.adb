

with CXA4027_0, CXA4027_1;
with Ada.Strings.Bounded;
with Ada.Strings.Maps;
with Ada.Characters.Handling;
with Report;

procedure CXA4027 is
begin

   Report.Test ("CXA4027", "Check that Ada.Strings.Bounded subprograms "  &
                           "Translate, Index, and Count, which use the "  &
                           "Character_Mapping_Function input parameter, " &
                           "produce correct results");

   Test_Block:
   declare

      use Ada.Strings;

      -- Functions used to supply mapping capability.

      function Map_To_Lower_Case (From : Character) return Character 
        renames CXA4027_0; 

      function Map_To_Upper_Case (From : Character) return Character
        renames CXA4027_1; 

      Map_To_Lower_Case_Ptr : Maps.Character_Mapping_Function :=
                                Map_To_Lower_Case'Access;

      Map_To_Upper_Case_Ptr : Maps.Character_Mapping_Function :=
                                Map_To_Upper_Case'Access;


      -- Instantiations of Bounded String generic package.

      package BS1  is new Ada.Strings.Bounded.Generic_Bounded_Length(1);
      package BS20 is new Ada.Strings.Bounded.Generic_Bounded_Length(20);
      package BS40 is new Ada.Strings.Bounded.Generic_Bounded_Length(40);
      package BS80 is new Ada.Strings.Bounded.Generic_Bounded_Length(80);

      use type BS1.Bounded_String,  BS20.Bounded_String, 
               BS40.Bounded_String, BS80.Bounded_String;

      String_1   : String(1..1)  := "A";
      String_20  : String(1..20) := "ABCDEFGHIJKLMNOPQRST";
      String_40  : String(1..40) := "abcdefghijklmnopqrst" & String_20;
      String_80  : String(1..80) := String_40 & String_40;

      BString_1  : BS1.Bounded_String  := BS1.Null_Bounded_String;
      BString_20 : BS20.Bounded_String := BS20.Null_Bounded_String;
      BString_40 : BS40.Bounded_String := BS40.Null_Bounded_String;
      BString_80 : BS80.Bounded_String := BS80.Null_Bounded_String;


   begin

      -- Function Index.

      if BS40.Index(BS40.To_Bounded_String("Package Strings.Bounded"),
                    Pattern => "s.b",
                    Going   => Ada.Strings.Forward,
                    Mapping => Map_To_Lower_Case_Ptr)     /= 15  or
         BS80.Index(BS80.To_Bounded_String("STRING TRANSLATIONS SUBPROGRAMS"),
                    "tr",
                    Mapping => Map_To_Lower_Case_Ptr)     /= 2   or
         BS20.Index(BS20.To_Bounded_String("maximum number"),
                    "um",
                    Ada.Strings.Backward,
                    Map_To_Lower_Case_Ptr)                /= 10  or
         BS80.Index(BS80.To_Bounded_String("CoMpLeTeLy MiXeD CaSe StRiNg"),
                    "MIXED CASE STRING",
                    Ada.Strings.Forward,
                    Map_To_Upper_Case_Ptr)                /= 12  or
         BS40.Index(BS40.To_Bounded_String("STRING WITH NO MATCHING PATTERN"),
                    "WITH",
                    Ada.Strings.Backward,
                    Map_To_Lower_Case_Ptr)                /= 0   or
         BS80.Index(BS80.To_Bounded_String("THIS STRING IS IN UPPER CASE"),
                    "I",
                    Ada.Strings.Backward,
                    Map_To_Upper_Case_Ptr)                /= 16  or
         BS1.Index(BS1.Null_Bounded_String,
                   "i",
                   Mapping => Map_To_Lower_Case_Ptr)      /= 0   or
         BS40.Index(BS40.To_Bounded_String("AAABBBaaabbb"),
                    "aabb",
                    Mapping => Map_To_Lower_Case_Ptr)     /= 2   or
         BS80.Index(BS80.To_Bounded_String("WOULD MATCH BUT FOR THE CASE"),
                    "WOULD MATCH BUT FOR THE CASE",
                    Ada.Strings.Backward,
                    Map_To_Lower_Case_Ptr)                /= 0
      then
         Report.Failed("Incorrect results from Function Index, using a " &
                       "Character Mapping Function parameter");
      end if;


      -- Function Index, Pattern_Error if Pattern = Null_String

      declare
         use BS20;
         TC_Natural : Natural := 1000;
      begin
         TC_Natural := Index(To_Bounded_String("A Valid String"), 
                             "",
                             Ada.Strings.Forward,
                             Map_To_Lower_Case_Ptr);
         Report.Failed("Pattern_Error not raised by Function Index when " &
                       "given a null pattern string");
      exception
         when Pattern_Error => null;   -- OK, expected exception.
         when others        =>
            Report.Failed("Incorrect exception raised by Function Index " &
                          "using a Character_Mapping_Function parameter " &
                          "when given a null pattern string");
      end;


      -- Function Count.

      if BS20.Count(BS20.To_Bounded_String("ABABABA"), 
                    Pattern => "aba",
                    Mapping => Map_To_Lower_Case_Ptr)        /=  2   or
         BS20.Count(BS20.To_Bounded_String("ABABABA"),
                    "ABA", 
                    Map_To_Lower_Case_Ptr)                   /=  0   or
         BS40.Count(BS40.To_Bounded_String("This IS a MISmatched issue"),
                    "is",
                    Map_To_Lower_Case_Ptr)                   /=  4   or
         BS80.Count(BS80.To_Bounded_String("ABABABA"), 
                    "ABA", 
                    Map_To_Upper_Case_Ptr)                   /=  2   or
         BS40.Count(BS40.To_Bounded_String("This IS a MISmatched issue"),
                    "is",
                    Map_To_Upper_Case_Ptr)                   /=  0   or
         BS80.Count(BS80.To_Bounded_String
                           ("Peter Piper and his Pickled Peppers"),
                    "p",
                    Map_To_Lower_Case_Ptr)                   /=  7   or
         BS20.Count(BS20.To_Bounded_String("She sells sea shells"),
                    "s",
                    Map_To_Upper_Case_Ptr)                   /=  0   or
         BS80.Count(BS80.To_Bounded_String("No matches what-so-ever"),
                    "matches",
                    Map_To_Upper_Case_Ptr)                   /=  0
      then
         Report.Failed("Incorrect results from Function Count, using " &
                       "a Character_Mapping_Function parameter");
      end if;


      -- Function Count, Pattern_Error if Pattern = Null_String

      declare
         use BS80;
         TC_Natural : Natural := 1000;
      begin
         TC_Natural := Count(To_Bounded_String("A Valid String"), 
                             "",
                             Map_To_Lower_Case_Ptr);
         Report.Failed("Pattern_Error not raised by Function Count using " &
                       "a Character_Mapping_Function parameter when "      &
                       "given a null pattern string");
      exception
         when Pattern_Error => null;   -- OK, expected exception.
         when others        =>
            Report.Failed("Incorrect exception raised by Function Count " &
                          "using a Character_Mapping_Function parameter " &
                          "when given a null pattern string");
      end;


      -- Function Translate.

      if BS40.Translate(BS40.To_Bounded_String("A Mixed Case String"),
                        Mapping => Map_To_Lower_Case_Ptr) /= 
         BS40.To_Bounded_String("a mixed case string")      or

         BS20."/="(BS20.Translate(BS20.To_Bounded_String("ALL LOWER CASE"),
                                  Map_To_Lower_Case_Ptr),
                   "all lower case")                        or

         BS20."/="("end with lower case",
                   BS20.Translate(
                     BS20.To_Bounded_String("end with lower case"),
                     Map_To_Lower_Case_Ptr))                or

         BS1.Translate(BS1.Null_Bounded_String, 
                       Map_To_Lower_Case_Ptr)             /=
         BS1.Null_Bounded_String                            or

         BS80."/="(BS80.Translate(BS80.To_Bounded_String
                          ("start with lower case, end with upper case"),
                        Map_To_Upper_Case_Ptr),
                   "START WITH LOWER CASE, END WITH UPPER CASE") or

         BS40.Translate(BS40.To_Bounded_String("ALL UPPER CASE STRING"),
                        Map_To_Upper_Case_Ptr)            /=
         BS40.To_Bounded_String("ALL UPPER CASE STRING")    or

         BS80."/="(BS80.Translate(BS80.To_Bounded_String
                          ("LoTs Of MiXeD CaSe ChArAcTeRs In ThE StRiNg"),
                          Map_To_Upper_Case_Ptr),
                   "LOTS OF MIXED CASE CHARACTERS IN THE STRING")

      then
         Report.Failed("Incorrect results from Function Translate, using " &
                       "a Character_Mapping_Function parameter");
      end if;


      -- Procedure Translate.

      BString_1 := BS1.To_Bounded_String("A");

      BS1.Translate(Source => BString_1, Mapping => Map_To_Lower_Case_Ptr);

      if not BS1."="(BString_1, "a") then    -- "=" for Bounded_String, String
         Report.Failed("Incorrect result from Procedure Translate - 1");
      end if;

      BString_20 := BS20.To_Bounded_String(String_20);
      BS20.Translate(BString_20, Mapping => Map_To_Lower_Case_Ptr);

      if BString_20 /= BS20.To_Bounded_String("abcdefghijklmnopqrst") then
         Report.Failed("Incorrect result from Procedure Translate - 2");
      end if;

      BString_40 := BS40.To_Bounded_String("String needing highlighting");
      BS40.Translate(BString_40, Map_To_Upper_Case_Ptr);

      if not (BString_40 = "STRING NEEDING HIGHLIGHTING") then
         Report.Failed("Incorrect result from Procedure Translate - 3");
      end if;

      BString_80 := BS80.Null_Bounded_String;
      BS80.Translate(BString_80, Map_To_Upper_Case_Ptr);

      if not (BString_80 = BS80.Null_Bounded_String) then
         Report.Failed("Incorrect result from Procedure Translate - 4");
      end if;


   exception
      when others => Report.Failed ("Exception raised in Test_Block");
   end Test_Block;

   Report.Result;

end CXA4027;
