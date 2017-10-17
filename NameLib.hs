{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

module NameLib 
(getName)
where

import Prelude hiding (True, False, Bool)

import SymBoolean

getName :: Bool -> (String, String) -> String
getName isFirstName (fn, ln) = cond isFirstName fn ln
