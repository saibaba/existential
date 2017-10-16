{-# LANGUAGE ExistentialQuantification #-}

{- refs:
 https://en.wikibooks.org/wiki/Haskell/Existentially_quantified_types#Example:_heterogeneous_lists
 -}

data T = forall a . Show a => MkT a

instance Show T where
  show (MkT v) = show v  

v:: [T]
v  = [MkT "sai", MkT 1, MkT 3.0]


f :: [T] -> IO ()
f xs = mapM_ print xs

main = f v

