{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

--implement boolean using integers 0 = false, 1 = true
--
module SymBoolean
(
Bool,
true,
false,
cond
) where

import Prelude hiding (Bool, True, False)

-- ADT
--

data Boolean = forall bool. MkBoolean { true_const, false_const :: bool, cond_fn :: (forall y. bool -> y -> y -> y) }

data BoolLiteral = TRUE | FALSE
newtype Bool = Bool { value :: BoolLiteral }

symCond :: forall y. Bool->y->y->y
symCond (Bool b) tv fv = case b of TRUE -> tv ; FALSE ->  fv
symBoolean :: Boolean
symBoolean = MkBoolean (Bool TRUE) (Bool FALSE) symCond

cond = symCond
true = Bool TRUE
false = Bool FALSE
