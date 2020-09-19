{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.ScottyApp where

import Control.Concurrent.Async(async)

import Data.Morpheus.Types
  (Event,  GQLType,
    ResolverQ,
    RootResolver (..),
    Undefined (..),
    Event (..),
  )

import Data.Morpheus.Server
  ( compileTimeSchemaValidation,
    webSocketsApp,
  )

import Web.Scotty
  ( ScottyM,
  )

import SimpleApp.UserApi
  ( User (..),
    Channel (..),  
    app,
    AppEvent (..),
    UserType (..),
    Content (..),
  )

import SimpleApp.Utils
  ( httpEndpoint,
    startServer,
  )
import Control.Monad 
  ( forever
  , forM_
  )

import Data.Text (pack)

import Control.Concurrent (threadDelay)

scottyServer :: IO ()
scottyServer = do
  (wsApp, publish) <- webSocketsApp app
  _ <- async $ userLoop publish 
  startServer 3000 wsApp (httpApp publish)
  where
    httpApp :: (AppEvent -> IO ()) -> ScottyM ()
    httpApp publish = do
      httpEndpoint "/" [publish] app

userLoop :: (AppEvent -> IO ()) -> IO ()
userLoop publish = 
  forM_  [1..] (\counter-> do
    threadDelay 1000000
    let userID = pack $ show counter  
    let someUser = User 
                    { firstName = userID <> "first"
                    , lastName = userID <> "last"
                    , middleName = Nothing
                    , userType = UserDev
                    }
    publish (Event [UserChannel] (NewUser someUser)))
    
    