# Project

Real time chat API built with Ruby on Rails.

## Installation

* Ruby version: 2.7.0

* Rails version: 6.1.3

* To start the server, run ```bundle install```, and then ```rails s```

## Features Implemented

### Back-End Features Implemented (within 5 hours)

#### Asked Features

* As a consumer of the API, I can persist my chat messages.

* As a consumer of the API, I can persist messages in specific channels I join.

* As a consumer of the API, I can see the list of all the available channels.

#### Extra Features I did

* As a consumer of the API, I can join an available channel.

* JWT authentication & authorization.

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