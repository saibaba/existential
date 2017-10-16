
A note about forall (https://stackoverflow.com/questions/10753073/whats-the-theoretical-basis-for-existential-types/10753957#10753957):


> data T = forall a. MkT a

Here you have a type T with a type constructor MkT :: forall a. a -> T, right? 
MkT is (roughly) a function, so for every possible type a, the function MkT have type a -> T. 
So, we agree that by using that constructor we may build values like [MkT 1, MkT 'c', MkT "hello"], all of them of type  T.

foo (MkT x) = ... -- what is the type of x?
But what does happen when you try to extract (e.g. via pattern matching) the value wrapped within a T? 
Its type annotation only says T, without any reference to the type of the value actually contained in it. 
We can only agree on the fact that, whatever it is, it will have one (and only one) type; how can we state this in Haskell?

x :: exists a. a


Another way to look at this (https://stackoverflow.com/questions/28545545/why-there-is-no-an-exist-keyword-in-haskell-for-existential-quantification):

This simply says that there exists a type a to which x belongs. 

At this point it should be clear that, by removing the forall a from MkT's definition and by explicitly specifying the type of the wrapped value (that is exists a. a), we are able to achieve the same result.

data T = MkT (exists a. a)

The bottom line is the same also if you add conditions on implemented typeclasses as in your examples.


The first thing to notice is that the forall quantifier appears on the right-hand side of the equal sign, so it is associated with a data constructor (not type): MkFoo. Thus, the type Foo says nothing about a.

We encounter a again when we try to pattern match on values of type Foo. 
At that point you'll know pretty much nothing about the components of MkFoo, except that they exist (there must exist a type used to call MkFoo) and that the first component can be used as an argument to the second component, which is a function (hence the need for the function too):

f :: Foo -> Bool
f (MkFoo val fn) = fn val


-----------
"... encapsulation is a friendly name given to existentially quantified types, which are the underlying theory used to understand Modules.  ..." from http://etymon.blogspot.com.au/2006/04/what-is-object-oriented-programming.html


Refs
====
* https://gist.github.com/CMCDragonkai/b203769c588caddf8cb051529339635c
* http://iveselov.info/posts/2012-08-30-existential-types.html
* https://stackoverflow.com/questions/28545545/why-there-is-no-an-exist-keyword-in-haskell-for-existential-quantification
* https://stackoverflow.com/questions/292274/what-is-an-existential-type
* http://iveselov.info/posts/2012-08-30-existential-types.html

Misc
====

Great answer on what/why of higher order or rankN (not related above existential stuff), if you could understand:

https://stackoverflow.com/a/12033549
