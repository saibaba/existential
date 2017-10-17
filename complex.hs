{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

{-
 - Unfolding Abstract Datatypes (Jeremy Gibbons)
 -
 - A lot to learn from this little exercise.
 - In particular each s in  'exists s' for two instances of Complex cannot be coerced even though they both are pair.
 - Hence need to use re/im to retrieve in pairAdd function
 -
 - Complex could implement Functor typeclass to extract and repackage parts by treating 'Complex' as a container!
 -}

-- ADT
data Complex = forall s. MkComplex { addfn :: s -> Complex -> s , re :: s->Double, im :: s->Double, self::s }

instance Show Complex where
  show (MkComplex a r i s) = show (r s) ++ " + i (" ++ show (i s) ++ ")"

pairRe :: (Double, Double) -> Double
pairRe (r, i) = r

pairIm :: (Double, Double) -> Double
pairIm (r, i) = i

pairAdd :: (Double, Double) -> Complex -> (Double, Double)
pairAdd (r1, i1) (MkComplex a r i s) = (r1 + r s, i1 + i s)

create :: Double -> Double -> Complex
create r i = MkComplex pairAdd pairRe pairIm (r, i)

add (MkComplex a r i s) c = MkComplex a r i (a s c)

test = do
  add (create 1 2) (create 3 4)

main = do
  putStrLn "Test complex numbers"
  print test

