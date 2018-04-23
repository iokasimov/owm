module Data.Weather.Information where

import Data.Aeson (FromJSON (..), Value (..), (.:))
import Data.Semigroup (Semigroup (..))

import Data.Weather.Information.Clouds (Clouds (..))
import Data.Weather.Information.Coordinates (Coordinates (..))
import Data.Weather.Information.Locality (Locality (..))
import Data.Weather.Information.Primary (Primary (..))
import Data.Weather.Information.Wind (Wind (..))

data Information = Information Coordinates Primary Wind Clouds Locality

instance FromJSON Information where
    parseJSON (Object o) = Information <$> o .: "coord"
        <*> o .: "main" <*> o .: "wind" <*> o .: "clouds" <*> o .: "name"

instance Show Information where
    show (Information coordinates primary wind clouds locality) =
        "\n-----------------------------------------------------\n"
        <> "Current weather data for " <> show locality <> ": \n"
        <> "-----------------------------------------------------\n"
        <> show coordinates <> "\n" <> show primary <> "\n"
        <> show wind <> "\n" <> show clouds
