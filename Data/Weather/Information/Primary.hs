module Data.Weather.Information.Primary (Primary (..)) where

import Data.Aeson (FromJSON (..), Value (..), (.:))
import Data.Semigroup (Semigroup (..))

data Primary = Primary Double Double Double Double Double

instance FromJSON Primary where
    parseJSON (Object o) = Primary <$> o .: "temp"
        <*> o .: "pressure" <*> o .: "humidity"
        <*> o .: "temp_min" <*> o .: "temp_max"

instance Show Primary where
    show (Primary temp pressure humidity temp_min temp_max) =
        "* Primary indicators: " <> "\n"
            <> "  + Temperature: " <> show temp <> "\n"
            <> "  + Pressure: " <> show pressure <> "\n"
            <> "  + Humidity: " <> show humidity <> "\n"
            <> "  + Temperature range: " <> show temp_min <> " - " <> show temp_max
