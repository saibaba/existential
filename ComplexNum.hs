{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

module ComplexNum
(Complex, create, add, im) where

{-
 - Unfolding Abstract Datatypes (Jeremy Gibbons)
 -
 - A lot to learn from this little exercise.
 - In particular each s in  'exists s' for two instances of Complex cannot be coerced even though they both are pair.
 - Hence need to use re/im to retrieve in pairAdd function
 -
 - data D = exists s. MkD (s, s->Integer)
 -    introduces a constructor :
 -        MkD :: (exists s. (s, s->Integer)) -> D
 -    By DeMorgan's laws, above is isomorphic to (assuming D is independent of s)
 -        MkD :: forall s. ( (s, s->Integer) -> D )
 -    So, we could use
 - data D = forall s . MkD (s, s->Integer)
 - 
 - Complex could implement Functor typeclass to extract and repackage parts by treating 'Complex' as a container!
 -}

-- ADT
data Complex = forall s. MkComplex (s -> Complex -> s) (s->Double) (s->Double) s

instance Show Complex where
  show (MkComplex a r i s) = show (r s) ++ " + i (" ++ show (i s) ++ ")"

-- Use pair (s in forall in ADT definition) as "representation" of ADT, Complex.

pairRe :: (Double, Double) -> Double
pairRe (r, i) = r

pairIm :: (Double, Double) -> Double
pairIm (r, i) = i

pairAdd :: (Double, Double) -> Complex -> (Double, Double)
pairAdd (r1, i1) (MkComplex a r i s) = (r1 + r s, i1 + i s)

create :: Double -> Double -> Complex
create r i = MkComplex pairAdd pairRe pairIm (r, i)

add (MkComplex a r i s) c = MkComplex a r i (a s c)

im :: Complex -> Double
im (MkComplex a r i s) = i s
