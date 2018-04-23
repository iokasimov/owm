module Data.Weather.Information.Clouds (Clouds (..)) where

import Data.Aeson (FromJSON (..), Value (..), (.:))
import Data.Semigroup (Semigroup (..))

data Clouds = Clouds Double

instance FromJSON Clouds where
    parseJSON (Object o) = Clouds <$> o .: "all"

instance Show Clouds where
    show (Clouds clouds) = "* Clouds (all): " <> show clouds
