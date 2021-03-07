# Project

Real time chat API built with Ruby on Rails.

## Installation

* Ruby version: 2.7.0

* Rails version: 6.1.3

* To load the databse schema on your local machine and seed the database, run the following commands
  * ```bundle install```
 
  * ```rails db:create```
 
  * ```rails db:migrate```

  * ```rails db:seed```

* To start the server, Run ```rails s -p (PORT NUMBER HERE)```

## Features Implemented

### Back-End Features Implemented (within 5 hours)

#### Asked Features

* As a consumer of the API, I can persist my chat messages.

* As a consumer of the API, I can persist messages in specific channels I join.

* As a consumer of the API, I can see the list of all the available channels.

#### Extra Features I did

* JWT authentication & authorization.

### Endpoints Exposed & How To Test

* NOTE: Port number used in all the following commands is 3000. Change it to the port number you use for running the Rails server if needed.

* POST /api/v1/signup 

  * Use the following curl command to sign up a user account in your terminal, and expect to receive an auth token. Keep that token for later requests.

  * curl -H "Content-Type: application/json" -X POST -d '{"username":"CodeNinja","email":"mcobab@gmail.com","password":"123123", "password_confirmation":"123123"}' http://localhost:3000/api/v1/signup

* POST /api/v1/login

  * Use the following curl command to login, expect to receive an auth token for later requests. If you just signed up, you don't need to login.

  * curl -H "Content-Type: application/json" -X POST -d '{"email":"mcobab@gmail.com","password":"123123"}' http://localhost:3000/api/v1/auth/login

* GET /api/v1/channels

  * Use the following command to get all the available channels to the logged-in user. Channels could be public/private. A user could be joined the channel already or not joined yet. Available channels mean all the channels the user has joined, plus all of the public channels the user hasn't joined yet. Take the token you got from previous authentication/authorization step and insert at the indicated place below.

  * curl -H "Content-Type: application/json" -H "Authorization:(YOUR TOKEN HERE)" -X GET  http://localhost:3000/api/v1/channels

* GET /api/v1/channels/:id

  * Use the following command to get all the messages in a specific channel (used first channel below as an example with id 1). Take the token you got from previous authentication/authorization step and insert at the indicated place below.

  * curl -H "Content-Type: application/json" -H "Authorization:(YOUR TOKEN HERE)" -X GET  http://localhost:3000/api/v1/channels/1

* POST /api/v1/user_channels

  * Use the following command to have the user to join a channel. Take the token you got from previous authentication/authorization step and insert at the indicated place below. Also, insert the user_id and channel_id below.
  
  * curl -H "Content-Type: application/json" -H "Authorization:(YOUR TOKEN HERE)" -X POST -d '{"user_id":(USER ID HERE),"channel_id":(CHANNEL ID HERE)}' http://localhost:3000/api/v1/user_channels

## Why Selected These Features

* Feature selected are the essentials for building a MVP for chatting purpose. The rest of the back-end features will be the next step to implement.

## How to run the test suite

* Run ```rspec spec``` on the terminal to run all the test suites.

* Test Coverage: All the models, routes, data endpoints, requests, and services implemented are tested.

## Possible Next Steps If I Had More Time. What assumptions did I make?

* Pagination of the data endpoints.

* I'd like to work on the feature - As a consumer of the API, I can look up other users and channels.

  * This is the next feature that looks most needed to a chat app. I assume a user would like to search for other users to have a chat with. Also, a user would search a channel to join and chat.

* Add in ActionCable to enable the message streaming so users can write messages and get broadcasted. (Originally I'd like to also work it out. But time was out.)
