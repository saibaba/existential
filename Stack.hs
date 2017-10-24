{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}
module Stack (Stack, empty, isEmpty, push, top, pop) where

-- ADT operations
empty :: forall a. Stack a
isEmpty :: forall a. Stack a -> Bool
push :: forall a. a -> Stack a -> Stack a
pop :: forall a. Stack a -> (a, Stack a)
top :: forall a. Stack a -> a

-- list based implementation

newtype Stack a = StackImpl [a]

empty = StackImpl []
isEmpty (StackImpl s) = null s
push x (StackImpl s) = StackImpl (x:s)
top (StackImpl s) = head s
pop (StackImpl (s:ss)) = (s, StackImpl ss)

