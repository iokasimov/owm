import Control.Applicative ((<|>))
import Data.Proxy (Proxy (..))
import Data.Semigroup (Semigroup (..))
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Options.Applicative (Parser (..), auto, execParser, info, long, option, str)
import Servant.API ((:<|>) (..))
import Servant.Client (BaseUrl (..), ClientEnv (..), ClientM, Scheme (..), client, runClientM)
import System.Environment (lookupEnv)

import qualified Data.Weather.By.City as City (API, endpoint)
import qualified Data.Weather.By.Coordinates as Coordinates (API, endpoint)
import Data.Weather.Information (Information)

data Argument = City String | Coordinates Int Int deriving Show

city, coordinates, arg :: Parser Argument
city = City <$> option str (long "city")
coordinates = Coordinates <$> option auto (long "lon") <*> option auto (long "lat")
arg = city <|> coordinates

environment :: IO ClientEnv
environment = ClientEnv <$> newManager tlsManagerSettings <*>
    (pure $ BaseUrl Https "api.openweathermap.org" 443 "/data/2.5")

request :: Argument -> Maybe String -> ClientM Information
request (City city) appid           = City.endpoint (pure city) appid
request (Coordinates lon lat) appid = Coordinates.endpoint (pure lon) (pure lat) appid

main = do
    endpoint <- request <$> execParser (info arg mempty) <*> lookupEnv "OWM_APPID"
    environment >>= runClientM endpoint >>= either print print
