{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

import Stack2

test = do
  print (top $ push 10 empty)

main = do
  putStrLn "Test stack"
  test
