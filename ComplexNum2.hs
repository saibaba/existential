{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

module ComplexNum2
(Complex, create, add, im) where

-- ADT
data Complex = forall s. MkComplex (s -> Complex -> s) (s->Double) (s->Double) s

instance Show Complex where
  show (MkComplex a r i s) = show (r s) ++ " + i (" ++ show (i s) ++ ")"

-- Use pair (s in forall in ADT definition) as "representation" of ADT, Complex.

lambdaRe = \f -> f True
lambdaIm = \f -> f False
lambdaAdd f (MkComplex a r i s) = \b -> if b then ((f True) + r s); else  ((f False) + i s)

create r i = MkComplex lambdaAdd lambdaRe lambdaIm $ (\x -> \y -> \b -> if b then x ; else y) r i 

add (MkComplex a r i s) c = MkComplex a r i (a s c)
im :: Complex -> Double
im (MkComplex a r i s) = i s
