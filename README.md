# Sharide_dart

Sharide is an application that offers ride functinality for students at SJSU.
Functionality
The app offers people to sign up as either a passenger or driver
The matching algorithm, passenger only get matched if at least one of the driver is online
Once matched, passenger will go on to live tracking feature

## Run the app on your computer
Make sure to install the following technologies first:
1. NodeJS
2. Flutter
3. Android Studio and set up an Emulator
`

Then run the app based on instructions below:
1. To run backend, perform those steps in a terminal
    cd into the backend
    type 'node index.js'
2. To run frontend, perform those steps in a terminal
    - go to the Providers.dart in the frontend (sharideapp/Providers.dart)
    - change the authority ip address part to your local ip address, which is the local host
    - make sure the specified port is not used (3000)
    - cd into Sharide_dart in a terminal
    - type 'flutter run'

## Architecture
The file architecture is as below
SHARIDE_DART

    - backend
    
        RestAPI   (the REST APIs)
        
        test      (test cases for those APIs)
        
        index     (main entry point of the backend)
      
    - sharideapp
    
        lib
          
          Controllers   (Payment Controllers)
        
        screens           (where all the frontend screens locate)
        
        main              (main entry point of the app)
        
        Providers         (store the state of the app)
                    
### Backend
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

### Frontend
For frontend we use Flutter
The architecture is specify as above
screens folder contains all the screens for our app
Providers is the file where we store all the state of the app
For this project we used Riverpod as our state management



