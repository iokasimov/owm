module Data.Weather.By.City (API, endpoint) where

import Data.Proxy (Proxy (..))
import Data.Text (Text)
import Servant.API ((:>), Get, JSON, QueryParam)
import Servant.Client (ClientM, client)

import Data.Weather.Information (Information (..))

type API = "weather" :>
    QueryParam "q" Text :>
    QueryParam "appid" String :>
    Get '[JSON] Information

endpoint :: Maybe Text -> Maybe String -> ClientM Information
endpoint = client (Proxy :: Proxy API)
