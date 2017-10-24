{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE Rank2Types #-}
module Stack2 (Stack, empty, isEmpty, push, top, pop) where

data Stack a = forall r . MkStack { _empty::() -> r,
                                  _isEmpty:: r -> Bool,
                                  _push:: a -> r -> r,
                                  _pop:: r -> (a, r),
                                  _top::  r -> a, repr::r }

-- list based implementation

emptyList :: forall a. () -> [a]
emptyList () = []

isEmptyList :: forall a. [a] -> Bool
isEmptyList [] = True
isEmptyList s = False

pushList :: forall a. a -> [a] -> [a]
pushList x l = x:l

topList :: forall a. [a] -> a
topList l = head l

popList :: forall a. [a] -> (a, [a])
popList (s:ss) = (s, ss)

empty :: forall a. Stack a

empty = MkStack { _empty = emptyList, 
                  _isEmpty = isEmptyList,
                  _push = pushList,
                  _pop = popList, 
                  _top = topList,
                  repr = [] }

isEmpty MkStack{_isEmpty=i, repr=r}  = i r

push x MkStack{_empty=f1, _isEmpty=f2, _push=p, _pop=f4, _top=f5, repr=r} = MkStack f1 f2 p f4 f5 (p x r)
top MkStack{_top=t, repr=r} = t r
pop MkStack{_empty=f1, _isEmpty=f2, _push=f3, _pop=p, _top=f5, repr=r} = (s, ss) where a = p r; s = fst a; ss = MkStack f1 f2 f3 p f5 (snd a)
