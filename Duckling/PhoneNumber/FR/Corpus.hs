
{-# LANGUAGE OverloadedStrings #-}

module Duckling.PhoneNumber.FR.Corpus
  ( corpus
  ) where

import Prelude
import Data.String

import Duckling.Locale
import Duckling.PhoneNumber.Types
import Duckling.Resolve
import Duckling.Testing.Types

corpus :: Corpus
corpus = (testContext {locale = makeLocale FR Nothing}, testOptions, allExamples)

allExamples :: [Example]
allExamples = concat
  [ examples (PhoneNumberValue  "0612345678")
             ["06.12.34.56.78"
             , "06-12-34-56-78"
             ]
    , examples (PhoneNumberValue "0712345678")
             ["07.12.34.56.78"
             , "07-12-34-56-78"
             ]
    , examples (PhoneNumberValue "0123456789")
             [ "01 23 45 67 89"
             , "01.23.45.67.89"
             , "01-23-45-67-89"
             ]
  ]
  
{-   ,examples (PhoneNumberValue "+337 123 456 78")
  [ "+33 712 345 678"
  , "+33712345678"
  , "+330712345678"]
,
 -}