
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module Duckling.PhoneNumber.FR.Rules
  ( rules ) where

import Data.String
import Prelude
import qualified Data.Text as Text

import Duckling.Dimensions.Types
import Duckling.Numeral.Helpers (parseInt)
import Duckling.PhoneNumber.Types (PhoneNumberData(..))
import Duckling.Regex.Types
import Duckling.Types
import qualified Duckling.PhoneNumber.Types as TPhoneNumber

rulePhoneNumber :: Rule
rulePhoneNumber = Rule
  { name = "phone number"
  , pattern =
    -- We somewhat arbitrarly use 20 here to limit the length of matches,
    -- otherwise due to backtracking the regexp will take very long time
    -- or run out of stack for some inputs.
    [ regex $
        "(?:(?:\\+|00)33|0|)" ++ -- area code
        "\\s*[1-9]"      ++ -- first number
        "(?:[\\s.-]{0,1}\\d{2,3}){3,4}" --nums
    ]
  , prod = \xs -> case xs of
      (Token RegexMatch (GroupMatch (code:nums:ext:_)):_) ->
        let parseNum x = toInteger <$> parseInt x
            mcode = parseNum code
            mext = parseNum ext
            cleanup = Text.filter (not . isWhitespace)
            isWhitespace x = elem x ['.', ' ', '-', '\t', '(', ')']
        in Just . Token PhoneNumber $ PhoneNumberData
          { TPhoneNumber.prefix = mcode
          , TPhoneNumber.number = cleanup nums
          , TPhoneNumber.extension = mext
          }
      _ -> Nothing
  }

rules :: [Rule]
rules =
  [ rulePhoneNumber
  ]
