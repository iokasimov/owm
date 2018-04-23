module Data.Weather.Information.Coordinates (Coordinates (..)) where

import Data.Aeson (FromJSON (..), Value (..), (.:))
import Data.Semigroup (Semigroup (..))

data Coordinates = Coordinates Double Double

instance FromJSON Coordinates where
    parseJSON (Object o) = Coordinates <$> o .: "lon" <*> o .: "lat"

instance Show Coordinates where
    show (Coordinates lon lat) = "* Coordinates: " <> "\n"
        <> "  + Longitude: " <> show lon <> "\n"
        <> "  + Latitude: " <> show lat
