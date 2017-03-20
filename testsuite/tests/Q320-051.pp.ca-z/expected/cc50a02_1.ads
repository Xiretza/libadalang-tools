     --==================================================================--

-- The formal package Stacker below is needed to gain access to the
-- appropriate version of the "generic" type Stack. It is provided with an
-- explicit actual part in order to restrict the packages that can be passed
-- as actuals to those which have been instantiated with the same actuals
-- which this generic procedure has been instantiated with.

with Cc50a02_0;  -- Generic stack abstraction.
generic
   type Item_Type (<>) is private;       -- Formal private type.
   with package Stacker is new Cc50a02_0 (Item_Type);
procedure Cc50a02_1 (S : in out Stacker.Stack; I : in Item_Type);
