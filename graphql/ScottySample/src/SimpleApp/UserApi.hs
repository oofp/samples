{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.UserApi where

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

data Query m = Query
  { user :: UserArgs -> m User
  }
  deriving (Generic, GQLType)

data Subscription m = Subscription 
  { newUser :: SubscriptionField (m User)
  } deriving (Generic, GQLType)

data Channel = UserChannel 
  deriving (Show, Eq, Ord)

data Content = NewUser User 
type AppEvent = Event Channel Content

-- Resolve SUBSCRIPTION
resolveNewUser :: SubscriptionField (ResolverS AppEvent IO User)
resolveNewUser = subscribe UserChannel $ do
  pure subResolver
  where
    subResolver (Event _ (NewUser usr)) = pure usr

--getDummyUser :: WithOperation o => User IO -> Content -> IO (Either String (User (Resolver o AppEvent IO)))
--getDummyUser usr _ = pure usr

rootResolver :: RootResolver IO AppEvent Query Undefined Subscription
rootResolver =
  RootResolver
    { queryResolver = Query {user = resolveUser},
      mutationResolver = Undefined,
      subscriptionResolver = Subscription {newUser = resolveNewUser}
    }

app :: App AppEvent IO
app = deriveApp rootResolver    
