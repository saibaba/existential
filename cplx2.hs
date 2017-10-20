{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

import ComplexNum2

test = do
  add (create 1 2) (create 3 4)

isReal :: Complex -> Bool
-- isReal ??what pattern - not allowed ! has to use available operations like re, im ??
isReal c = (im c == 0)

main = do
  putStrLn "Test complex numbers"
  print test
  print $ "Is (10 + i 0) real? :" ++ (show ( isReal (create 10 0)))
  print $ "Is (10 + i 0.5) real? :" ++ (show ( isReal (create 10 0.5)))


