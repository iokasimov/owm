import Data.Proxy (Proxy (..))
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Servant.Client (BaseUrl (..), ClientEnv (..), Scheme (..), client, runClientM)
import System.Environment (lookupEnv)

import Data.Weather.By.City (API, endpoint)

api = Proxy :: Proxy API
client api = Data.Weather.By.City.endpoint

main = do
    maybe_appid <- lookupEnv "OWM_APPID"
    env <- ClientEnv <$> newManager tlsManagerSettings <*>
        (pure $ BaseUrl Https "api.openweathermap.org" 443 "/data/2.5")
    runClientM (endpoint (pure "London") maybe_appid) env >>= print
