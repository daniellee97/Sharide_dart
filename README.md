# Sharide_dart

Sharide is an application that offers ride functinality for students at SJSU.
Functionality
The app offers people to sign up as either a passenger or driver
The matching algorithm, passenger only get matched if at least one of the driver is online
Once matched, passenger will go on to live tracking feature

To run the app on your computer, make sure to install the following technologies first:
1. NodeJS
2. Flutter
3. Android Studio and set up an Emulator
`

Then run the app based on instructions below:
1. To run backend, perform those steps in a terminal
    cd into the backend
    type 'node index.js'
2. To run frontend, perform those steps in a terminal
    cd into Sharide_dart
    type 'flutter run'

Backend
The backend consists of REST APIs and test case for those APIs
The REST APIs format is specify in index.js
The specific APIs are in RestAPI folder
The tests are those APIs are in test folder

To run backend test:
1. Open a terminal and cd into backend
2. Run command: npx jest /test/[car1].test.js
Change the file name to your perspective tests

Some links to read about testing:

https://www.mongodb.com/languages/express-mongodb-rest-api-tutorial

example of testing
https://www.npmjs.com/package/supertest


