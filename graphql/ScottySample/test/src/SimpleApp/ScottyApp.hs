{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module SimpleApp.ScottyApp where

import Data.Morpheus.Types
  ( GQLType,
    ResolverQ,
    RootResolver (..),
    Undefined (..),
    Event,
  )

import Data.Morpheus.Server
  ( compileTimeSchemaValidation,
    webSocketsApp,
  )

import Web.Scotty
  ( ScottyM,
  )

import SimpleApp.UserApi
  ( app,
    AppEvent,
  )

import SimpleApp.Utils
  ( httpEndpoint,
    startServer,
  )

scottyServer :: IO ()
scottyServer = do
  (wsApp, publish) <- webSocketsApp app
  startServer 3000 wsApp (httpApp publish)
  where
    httpApp :: (AppEvent -> IO ()) -> ScottyM ()
    httpApp publish = do
      httpEndpoint "/" [publish] app
