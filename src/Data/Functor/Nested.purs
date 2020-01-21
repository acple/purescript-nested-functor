module Data.Functor.Nested
  ( class NestedFunctor
  , nmap, (<$$>)
  , nmapFlipped, (<##>)
  ) where

import Prelude

class NestedFunctor fa fb a b | fb a b -> fa, fa fb b -> a where
  nmap :: (a -> b) -> fa -> fb

infixl 4 nmap as <$$>

instance applyNestedFunctor :: NestedFunctor a b a b where
  nmap = identity
else
instance nestedNestedFunctor :: (Functor f, NestedFunctor ga gb a b) => NestedFunctor (f ga) (f gb) a b where
  nmap = map <<< nmap

nmapFlipped :: forall fa fb a b. NestedFunctor fa fb a b => fa -> (a -> b) -> fb
nmapFlipped = flip nmap

infixl 1 nmapFlipped as <##>
