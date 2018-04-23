module Data.Weather.Information.Locality (Locality (..)) where

import Data.Aeson (FromJSON (..), withText, (.:))
import Data.Semigroup (Semigroup (..))
import Data.Text (Text)

data Locality = Locality Text

instance FromJSON Locality where
    parseJSON = withText "name" $ \t -> pure $ Locality t

instance Show Locality where
    show (Locality loc) = show loc
