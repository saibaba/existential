{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}

import Control.Monad.State
import Stack2

assertTrue :: Bool -> a -> a
assertTrue False x = error "assertion failed!"
assertTrue _     x = x

assertFalse :: Bool -> a -> a
assertFalse False x = x
assertFalse _ x = error "assertion failed!"

testEmpty = assertTrue (isEmpty empty) "isEmpty works!"
testNotEmpty = assertFalse (isEmpty (push 10 empty)) "isEmpty works!"

setup = push 9 ( push 6 ( push 7 ( push 5 empty ) ) )

testPush4Top = assertTrue (9 == (top setup)) "Pushing 4 and checking top - works"
testPush4Pop = assertTrue (9 == (fst (pop setup))) "Pushing 4 and pop - works"
testInterlace = assertTrue (3 == (top (snd (pop (push 7 (push 3 (snd (pop (push 5 setup))))))))) "Pushing 4 and pop - works"

pushN :: Int -> (Stack Int) -> ((), (Stack Int))
pushN a s = ((), push a s)

popN :: Stack Int ->  (Int, Stack Int)
popN s = pop s

stackManipNaive :: Stack Int -> (Int, Stack Int)  
stackManipNaive stack = let  
    ((),newStack1) = pushN 5 stack  
    ((),newStack2) = pushN 7 newStack1
    ((),newStack3) = pushN 6 newStack2
    ((),newStack4) = pushN 9 newStack3
    (a ,newStack5) = popN newStack4
    in popN newStack5
testPush4PopPop = assertTrue (6 == (fst (stackManipNaive empty))) "Pushing 4 and pop 2 times - works"

test = assertTrue (10 == top ( push 10 empty )) "basic test  - works"

main = do
  putStrLn "Testing stack ..."
  putStrLn test
  putStrLn testEmpty
  putStrLn testNotEmpty
  putStrLn testPush4Top
  putStrLn testPush4Pop
  putStrLn testInterlace
  putStrLn testPush4PopPop
