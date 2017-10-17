{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

--implement boolean using integers 0 = false, 1 = true
--
module IntBoolean
(
Bool,
true,
false,
cond
) where

import Prelude hiding (Bool, True, False)

-- ADT
data Boolean = forall bool. MkBoolean { true_const, false_const :: bool, cond_fn :: (forall y. bool -> y -> y -> y) }

newtype Bool = Bool { value :: Int }

intCond :: forall y. Bool -> y -> y -> y
intCond (Bool b) true_value false_value = case b of 1 -> true_value ; 0 ->  false_value
intBoolean :: Boolean
intBoolean = MkBoolean (Bool 1) (Bool 0) intCond

cond = intCond
true = Bool 1
false = Bool 0
