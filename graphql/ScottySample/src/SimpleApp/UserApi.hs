{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.UserApi where

import SimpleApp.CallApi
import SimpleApp.WebRTC
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
import Control.Monad 
  ( forever,
    forM_,
  )

import Control.Monad.IO.Class 
  ( liftIO
  )  

import Control.Concurrent (threadDelay)
import Control.Concurrent.Async(async)

data UserType 
  = UserManager
  | UserTechLead
  | UserDev
  | UserQA
  deriving (Generic, GQLType)

data User = User
  { firstName :: Text
  , lastName :: Text
  , middleName :: Maybe Text
  , userType :: UserType
  } deriving (Generic, GQLType)   

data UserArgs = UserArgs
  { userID :: Text, -- Required Argument
    midName :: Maybe Text -- Optional Argument
  }
  deriving (Generic, GQLType)


resolveUser :: UserArgs -> ResolverQ e IO User
resolveUser UserArgs {userID, midName} =  
  return
    User
      { firstName = userID <> "first"
      , lastName = userID <> "last"
      , middleName = midName
      , userType = UserDev
      }

resolveUserM :: UserArgs -> ResolverM e IO User
resolveUserM UserArgs {userID, midName} =  
  return
    User
      { firstName = userID <> "first"
      , lastName = userID <> "last"
      , middleName = midName
      , userType = UserDev
      }

resolveStartChannel :: (AppEvent -> IO ()) -> ChannelID -> ResolverM e IO ChannelID
resolveStartChannel evPublish chID = do 
  liftIO $ async $ forM_  [1..] (\counter-> do
    threadDelay 1000000
    let userID = "user_" <> (channelID chID)  
    let someUser = User 
                    { firstName = userID <> "first"
                    , lastName = userID <> "last"
                    , middleName = Nothing
                    , userType = UserManager
                    }
    evPublish (Event [UserChannel chID] (NewUser someUser)))
  return chID  

resolvewebRTCReq :: (AppEvent -> IO ()) -> WebRTCReq -> ResolverM e IO WebRTCCallID
resolvewebRTCReq evPublish (WebRTCReq chID (MakeCall makeCallParams)) = do
  let webCallID = WebRTCCCallID 1
  let params = NewIncominCallParams makeCallParams webCallID
  let ev = WebRTCEv (NewIncomingCall params)
  liftIO $ evPublish (Event [UserChannel chID] ev)
  return webCallID
resolvewebRTCReq evPublish (WebRTCReq chID  (AnswerCall answerCallParams)) = do
  let ev = WebRTCEv (CallAnswered answerCallParams)
  liftIO $ evPublish (Event [UserChannel chID] ev)
  return (answerCallID answerCallParams)
resolvewebRTCReq evPublish (WebRTCReq chID (IceCandidateReq iceCandidateParams)) = do
  let ev = WebRTCEv (IceCandidateRcvd iceCandidateParams)
  liftIO $ evPublish (Event [UserChannel chID] ev)
  return (iceCallID iceCandidateParams)
resolvewebRTCReq evPublish (WebRTCReq chID  (DropCall dropCallParams)) = do
  let ev = WebRTCEv (CallDropped dropCallParams)
  liftIO $ evPublish (Event [UserChannel chID] ev)
  return (dropCallID dropCallParams)

data Query m = Query
  { user :: UserArgs -> m User
  , allCalls :: m [Call]
  }
  deriving (Generic, GQLType)

data WebRTCReq = WebRTCReq 
  { reqChannelID:: ChannelID
  , clnReq :: ClientReq
  } deriving (Generic, GQLType)

data Mutation m = Mutation
  { updateUser :: UserArgs -> m User
  , createUser :: User -> m User
  , startChannel :: ChannelID -> m ChannelID
  , webRTCReq :: WebRTCReq -> m WebRTCCallID
  }
  deriving (Generic, GQLType)

data Subscription m = Subscription 
  { newUser :: ChannelID -> SubscriptionField (m User)
  , webRTCMsg :: ChannelID -> SubscriptionField (m ServerMsg)
  } deriving (Generic, GQLType)

newtype ChannelID = ChannelID {channelID::Text} 
  deriving (Generic, GQLType, Show, Eq, Ord)

data Channel = UserChannel ChannelID
  deriving (Show, Eq, Ord)

data Content 
  = NewUser User
  | WebRTCEv ServerMsg

type AppEvent = Event Channel Content

-- Resolve SUBSCRIPTION
resolveNewUser :: ChannelID -> SubscriptionField (ResolverS AppEvent IO User)
resolveNewUser chID = subscribe (UserChannel chID) $ do
  pure subResolver
  where
    subResolver (Event _ (NewUser usr)) = pure usr

resolveServerMsg :: ChannelID -> SubscriptionField (ResolverS AppEvent IO ServerMsg)
resolveServerMsg chID = subscribe (UserChannel chID) $ do
  pure subResolver
  where
    subResolver (Event _ (WebRTCEv srvMsg)) = pure srvMsg

--getDummyUser :: WithOperation o => User IO -> Content -> IO (Either String (User (Resolver o AppEvent IO)))
--getDummyUser usr _ = pure usr

rootResolver :: (AppEvent -> IO ()) -> RootResolver IO AppEvent Query Mutation Subscription
rootResolver evPublish =
  RootResolver
    { queryResolver = Query 
                        { user = resolveUser
                        , allCalls = resolveAllCalls
                        },
      mutationResolver = Mutation
                        { updateUser = resolveUserM
                        , createUser = return 
                        , startChannel = resolveStartChannel evPublish
                        , webRTCReq = resolvewebRTCReq evPublish
                        },
      subscriptionResolver = Subscription 
        { newUser = resolveNewUser
        , webRTCMsg = resolveServerMsg
        }
    }

mkApp :: (AppEvent -> IO ()) -> App AppEvent IO
mkApp evPublish = deriveApp (rootResolver evPublish)    