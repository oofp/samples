{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.WebRTC where

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

data RTCIceCandidate = RTCIceCandidate
  { candidate :: Text
  , sdpMid :: Text
  , sdpMlineIndex :: Int
  } deriving (Generic, GQLType, Show)
  
data RTCSessionDescription = RTCSessionDescription
  { sdpText :: Text
  , sdpType :: Text
  } deriving (Generic, GQLType, Show)


data MakeCallParams = MakeCallParams
  { origID :: Text
  , destID :: Text
  , sdpOffer :: RTCSessionDescription
  } deriving (Generic, GQLType, Show)

data NewIncomingCallParams = NewIncominCallParams
  { callParams :: MakeCallParams
  , newCallID :: WebRTCCallID
  } deriving (Generic, GQLType, Show)

newtype WebRTCCallID = WebRTCCCallID {callId::Int} deriving (Generic, GQLType, Show)

data AnswerCallParams = AnswerCallParams
  { answerCallID :: WebRTCCallID
  , sdpAnswer :: RTCSessionDescription
  } deriving (Generic, GQLType, Show)

data IceCandidateParams = IceCandidateParams  
  { iceCallID :: WebRTCCallID
  , candidates :: [RTCIceCandidate]
  } deriving (Generic, GQLType, Show)

data DropCallParams = DropCallParams
  { dropCallID :: WebRTCCallID
  , dropCallReason :: Text
  } deriving (Generic, GQLType, Show)

data ClientReq 
  = MakeCall MakeCallParams
  | AnswerCall AnswerCallParams
  | IceCandidateReq IceCandidateParams
  | DropCall DropCallParams 
  deriving (Generic, GQLType, Show)

data ServerMsg 
  = NewIncomingCall NewIncomingCallParams
  | CallAnswered AnswerCallParams
  | CallDropped DropCallParams
  | IceCandidateRcvd IceCandidateParams
  deriving (Generic, GQLType, Show)