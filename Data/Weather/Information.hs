module Data.Weather.Information where

import Data.Aeson (FromJSON (..), Value (..), withText, (.:))
import Data.Text (Text)

data Coordinates = Coordinates Double Double deriving Show

instance FromJSON Coordinates where
	parseJSON (Object o) = Coordinates <$> o .: "lon" <*> o .: "lat"

data Main = Main Double Int Int Double Double deriving Show

instance FromJSON Main where
    parseJSON (Object o) = Main <$> o .: "temp"
        <*> o .: "pressure" <*> o .: "humidity"
        <*> o .: "temp_min" <*> o .: "temp_max"

data Wind = Wind Double Int deriving Show

instance FromJSON Wind where
    parseJSON (Object o) = Wind <$> o .: "speed" <*> o .: "deg"

data Clouds = Clouds Int deriving Show

instance FromJSON Clouds where
    parseJSON (Object o) = Clouds <$> o .: "all"

data Locality = Locality Text deriving Show

instance FromJSON Locality where
    parseJSON = withText "name" $ \t -> pure $ Locality t

data Information = Information Coordinates Main Wind Clouds Locality deriving Show

instance FromJSON Information where
    parseJSON (Object o) = Information <$> o .: "coord"
        <*> o .: "main" <*> o .: "wind" <*> o .: "clouds" <*> o .: "name"
