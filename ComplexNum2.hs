{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

module ComplexNum2 (Complex, create, add, im) where

-- ADT
data Complex = forall s. MkComplex { addfn :: s -> Complex -> s , re :: s->Double, imfn :: s->Double, self::s }

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

im (MkComplex a r i s) = i s

