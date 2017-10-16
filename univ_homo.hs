{-# LANGUAGE GADTs #-}

{-# LANGUAGE ExistentialQuantification #-}

{- refs:
 https://en.wikibooks.org/wiki/Haskell/Existentially_quantified_types#Example:_heterogeneous_lists
 -}

data T a where
  MkT :: Show a => a -> T a

instance Show (T a) where
  show (MkT v) = show v  

v :: [T String]

v = [MkT "sai", MkT "1", MkT "3.0"]

f :: [T String] -> IO ()
f xs = mapM_ print xs

main = f v
