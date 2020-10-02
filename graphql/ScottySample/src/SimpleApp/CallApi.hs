{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.CallApi where

import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Morpheus.Kind (INTERFACE)
import Data.Morpheus.Types
  ( GQLType,
    Resolver,
    ResolverQ,
    ResolverM,
    ResolverS,
    RootResolver (..),
    Undefined (..),
    liftEither,
    publish,
    subscribe,
    Event (..),
    SubscriptionField,
    WithOperation
  )
import Data.Morpheus
  ( App,
    deriveApp,
  )

data CallState 
  = Offered
  | Ringing
  | Connecting
  | Connected
  | Initiated
  | Ringback
  | Disconnected
  deriving (Generic, GQLType)

newtype CallID = CallID {id::Int} deriving (Generic, GQLType)

data Call = Call
  { callID :: CallID
  , localAddress :: Text
  , remoteAddress :: Text
  , callState :: CallState
  } deriving (Generic, GQLType)   


resolveAllCalls :: ResolverQ e IO [Call]
resolveAllCalls =  
  return
    [Call
      { callID = CallID 1
      , localAddress = "100"
      , remoteAddress = "200"
      , callState = Connected
      }
    ]

