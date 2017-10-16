{-# LANGUAGE ExistentialQuantification #-}

-- ADT
data Counter = forall a. MkCounter
                           a           -- new
                           (a -> a)    -- inc
                           (a -> Int)  -- get

-- Why get is encapsulated in here ? otherwise when you pattern match to retrieve 'a', since you do not know the type of 'a' you cannot do anything with 'a'.
-- By having this function whatever real type 'a' is, the function can be applied to do interesting things with it!
--
-- int based implementation, i.e., there exists a type where Counter is defined and that type is int
-- here int is the implementation type hidden: it is hidden representation type or witness type. ie., we have
-- witness that Counter is possible
-- forall in this case is used as "exists" through curry howard isomorphism!
--
intCounter :: Counter
intCounter = MkCounter 0 (+1) id

-- list based implementation
listCounter :: Counter
listCounter = MkCounter [] ( () : ) length

-- a test program that depends only on ADT and limited exposed operations that works with any implementation
-- It creates new counter, increments twice and gets the result
test :: Counter -> Int
test (MkCounter new inc get) = get $ inc $ inc $ new

main = do
  putStr "Testing using intCounter implementation... "  
  print $ test intCounter
  putStr "Testing using listCounter implementation... "  
  print $ test listCounter
