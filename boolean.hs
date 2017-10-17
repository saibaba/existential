{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

import Prelude hiding (True, False, Bool)

{-
 "Type Systems" by Luca Cardelli, page 26
 https://stackoverflow.com/questions/10192663/why-cant-i-use-record-selectors-with-an-existentially-quantified-type
 https://stackoverflow.com/questions/12719435/what-are-skolems
-}

--import IntBoolean
import SymBoolean
import NameLib

test = do
  print $ getName true ("sai" ,"telukunta")
  print $ getName false ("sai", "telukunta")

main = do
  putStrLn "Testing using intBoolean implementation... "  
  test
