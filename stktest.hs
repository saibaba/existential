{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

import Stack

--data Stack e = forall l. Stack { empty :: () -> l, push :: e -> l -> l, pop :: l -> (Maybe e, l) }
--data Stack e = forall r. Stack { empty:: () -> r }

lpop (xs:x) = (Just x, xs)
lpop [] = (Nothing, [])
--data listStack e = Stack e []  (\i -> \l -> l ++ [i])  (\l ->  lpop l )
--data ListStack e = ListStack (Stack ( () -> [e]))

--create:: forall e . () -> Stack
--create = Stack e

test = do
  print (top $ push 10 empty)


main = do
  putStrLn "Test stack"
  test
