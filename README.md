# purescript-nested-functor
Generalized `map` for nested functors.

```purescript
-- (a -> b) <$$> f (g (h (i a))) :: f (g (h (i b)))
example1 :: Identity (Either Void (Maybe (Array Int)))
example1 = do
  let x = Identity (Right (Just [ 1, 2, 3 ])) -- :: Identity (Either Void (Maybe (Array Int)))
  (_ * 10) <$$> x -- Identity (Right (Just [ 10, 20, 30 ]))

-- (h (i a) -> x) <$$> f (g (h (i a))) :: f (g x)
example2 :: Identity (Either Void Int)
example2 = do
  let x = Identity (Right (Just [ 1, 2, 3 ])) -- :: Identity (Either Void (Maybe (Array Int)))
  maybe 0 sum <$$> x -- Identity (Right 6)

-- (a -> b) <$$> (r -> f a) :: r -> f b
example3 :: forall m. Monad m => m String
example3 = do
  let f = show <$$> pure -- :: forall a. Show a => a -> m String
  f 123
```
