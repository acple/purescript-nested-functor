module Test.Main where

import Prelude

import Data.Either (Either(..))
import Data.Foldable (sum)
import Data.Functor.Nested (nmap, (<$$>))
import Data.Identity (Identity(..))
import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import Effect.Class.Console (log)
import Unsafe.Coerce (unsafeCoerce)

main :: Effect Unit
main = do
  log "If can be compiled, it's ok"

----------------------------------------------------------------

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

test1 :: forall f. Functor f => f Int -> f Int
test1 = nmap (_ + 10)

test2 :: forall f g. Functor f => Functor g => f (g Int) -> f (g Int)
test2 = nmap (_ + 10)

test3 :: forall f g h. Functor f => Functor g => Functor h => f (g (h Int)) -> f (g (h Int))
test3 = nmap (_ + 10)

test4 :: forall f g h i. Functor f => Functor g => Functor h => Functor i => f (g (h (i Int))) -> f (g (h (i Int)))
test4 = nmap (_ + 10)

test5 :: forall f g h i j. Functor f => Functor g => Functor h => Functor i => Functor j => f (g (h (i (j Int)))) -> f (g (h (i (j Int))))
test5 = nmap (_ + 10)

test6 :: forall f g h i a. Functor f => Functor g => Functor h => Functor i => Show a => f (g (h (i a))) -> f (g (h (i String)))
test6 = nmap show

test7 :: forall f g h i. Functor f => Functor g => Functor h => Functor i => f (g (h (i Int))) -> f (g (h (i Int)))
test7 = nmap (identity :: i Int -> i Int)

test8 :: forall f g h i. Functor f => Functor g => Functor h => Functor i => f (g (h (i Int))) -> f (g (h (i Int)))
test8 = nmap (identity :: h (i Int) -> h (i Int))

test9 :: forall f g h i. Functor f => Functor g => Functor h => Functor i => f (g (h (i Int))) -> f (g (h (i Int)))
test9 = nmap (identity :: g (h (i Int)) -> g (h (i Int)))

test10 :: forall f g h i a. Functor f => Functor g => Functor h => Functor i => f (g (h (i a))) -> f (g (h (i String)))
test10 = nmap (unsafeCoerce :: _ -> _) -- :: a -> String
