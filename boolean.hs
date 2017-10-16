{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

import Prelude hiding (True, False)

{-
 "Type Systems" by Luca Cardelli, page 26
 https://stackoverflow.com/questions/10192663/why-cant-i-use-record-selectors-with-an-existentially-quantified-type
 https://stackoverflow.com/questions/12719435/what-are-skolems
-}

{-
Boolean :
  exists a. {true, false :: a, cond :: (forall y. a -> y -> y -> y) }

Boolean as a function is not possible as there is no 'exists' keyword in Haskell:
boolean = exists a . {true, false :: a, cond :: (forall y. a -> y -> y -> y) }

Wrap it in a constructor:

data Boolean = MkBoolean (exists a. a a (forall y. a -> y -> y -> y))

data Boolean = forall a . MkBoolean a a (forall y. a -> y -> y -> y)

From logic:
(exists x . P(x) ) => Q  'equivalent to' forall x . ( P(x) => Q)

-}

{-
data Boolean = forall a. MkBoolean
                           a    -- true
                           a    -- false
                           (forall y. a -> y -> y -> y) -- cond

Or use record syntax for easier access to fields
data Boolean = forall a. MkBoolean { true, false :: a, cond :: (forall y. a -> y -> y -> y) }
-}


-- ADT
data Boolean = forall a. MkBoolean { true, false :: a, cond :: (forall y. a -> y -> y -> y) }


--implement using 0 = false, 1 = true
intCond :: forall y. Int -> y -> y -> y
intCond a t f = case a of 1 -> t ; 0 ->  f
intBoolean :: Boolean
intBoolean = MkBoolean 1 0 intCond

--implement using symbol True = true, False = false
data BoolLiteral = TRUE | FALSE
symCond :: forall y. BoolLiteral->y->y->y
symCond a t f = case a of TRUE -> t ; FALSE ->  f
symBoolean :: Boolean
symBoolean = MkBoolean TRUE FALSE symCond

--Either : left = false, right true
--using pair : first = true, second false

-- implement bool using pair true=fst, false=snd; (true_value, false_value)

{-
type PairFnType = forall y . (y, y) -> y
pairBoolean :: Boolean
pairBoolean = MkBoolean fstfn sndfn pairCond
  where
    fstfn :: PairFnType
    fstfn = \(a, b) -> a
    sndfn :: PairFnType
    sndfn = \(a, b) -> b
    pairCond :: forall y. PairFnType -> y -> y -> y
    pairCond = \fn -> \t -> \f -> fn (t, f)
-}

getFirstName fn ln MkBoolean{true  = t, cond = c} = c t fn ln
getLastName  fn ln MkBoolean{false = f, cond = c} = c f fn ln

test1 b = do
  print $ getFirstName "sai" "telukunta" $ b
  print $ getLastName "sai" "telukunta" $ b

{-
getName :: Boolean -> cond -> (String, String) -> String
getName MkBoolean{cond = c} w (fn, ln) = c w fn ln

test2 = do
  print $ getName (true intBoolean)  "sai" "telukunta"
  print $ getName (false intBoolean) "sai" "telukunta"
-}

main = do
  putStrLn "Testing using intBoolean implementation... "  
  test1 intBoolean
  putStrLn "Testing using symBoolean implementation... "  
  test1 symBoolean
