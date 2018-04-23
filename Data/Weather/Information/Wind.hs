module Data.Weather.Information.Wind (Wind (..)) where

import Data.Aeson (FromJSON (..), Value (..), (.:))
import Data.Semigroup (Semigroup (..))

data Wind = Wind Double Double

instance FromJSON Wind where
    parseJSON (Object o) = Wind <$> o .: "speed" <*> o .: "deg"

instance Show Wind where
    show (Wind speed degrees) = "* Wind indicators: " <> "\n"
        <> "  + Speed: " <> show speed <> "\n"
        <> "  + Degrees: " <> show degrees
