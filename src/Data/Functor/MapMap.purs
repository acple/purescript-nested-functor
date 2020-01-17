module Data.Functor.MapMap where

import Prelude

mapmap :: forall f g a b. Functor f => Functor g => (a -> b) -> f (g a) -> f (g b)
mapmap = map <<< map

infixl 4 mapmap as <$$>

mapmapmap :: forall f g h a b. Functor f => Functor g => Functor h => (a -> b) -> f (g (h a)) -> f (g (h b))
mapmapmap = map <<< map <<< map

infixl 4 mapmapmap as <$$$>

mapmapmapmap :: forall f g h i a b. Functor f => Functor g => Functor h => Functor i => (a -> b) -> f (g (h (i a))) -> f (g (h (i b)))
mapmapmapmap = map <<< map <<< map <<< map

infixl 4 mapmapmapmap as <$$$$>

mapmapFlipped :: forall f g a b. Functor f => Functor g => f (g a) -> (a -> b) -> f (g b)
mapmapFlipped = flip mapmap

infixl 1 mapmapFlipped as <##>

mapmapmapFlipped :: forall f g h a b. Functor f => Functor g => Functor h => f (g (h a)) -> (a -> b) -> f (g (h b))
mapmapmapFlipped = flip mapmapmap

infixl 1 mapmapmapFlipped as <###>

mapmapmapmapFlipped :: forall f g h i a b. Functor f => Functor g => Functor h => Functor i => f (g (h (i a))) -> (a -> b) -> f (g (h (i b)))
mapmapmapmapFlipped = flip mapmapmapmap

infixl 1 mapmapmapmapFlipped as <####>
