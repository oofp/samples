{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.ScottyApp where

import Control.Concurrent.Async(async)
import Control.Concurrent.STM
  ( atomically,
  )
import Control.Concurrent.STM.TChan
  ( newTChanIO, 
    writeTChan, 
    readTChan,
  )

import Data.Morpheus.Types
  ( Event,  
    App,
    GQLType,
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
    mkApp,
    AppEvent (..),
    UserType (..),
    Content (..),
    ChannelID (..),
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
  evChan <- newTChanIO
  let evPublish = atomically . writeTChan evChan 
  let app = mkApp evPublish
  (wsApp, publish) <- webSocketsApp app 
  _ <- async $ userLoop evPublish
  _ <- async $ forever $ (atomically $ readTChan evChan)  >>= publish
  startServer 3000 wsApp (httpApp app publish)
  where
    httpApp :: App AppEvent IO -> (AppEvent -> IO ()) -> ScottyM ()
    httpApp app publish = do
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
    publish (Event [UserChannel (ChannelID "0")] (NewUser someUser)))
    
    