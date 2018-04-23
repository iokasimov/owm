module Data.Weather.By.Coordinates (API, endpoint) where

import Data.Proxy (Proxy (..))
import Data.Text (Text)
import Servant.API ((:>), Get, JSON, QueryParam)
import Servant.Client (ClientM, client)

import Data.Weather.Information (Information (..))

type API = "weather" :>
    QueryParam "lat" Int :>
    QueryParam "lon" Int :>
    QueryParam "appid" String :>
    Get '[JSON] Information

endpoint :: Maybe Int -> Maybe Int -> Maybe String -> ClientM Information
endpoint = client (Proxy :: Proxy API)
