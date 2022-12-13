# PhotoLIst
## Prerequisite
1) Swift 5
2) XCode 13.4.1
3) Storyboard with Constraint Layout
4) MVVM Archtecture

## Setup
1) Open LightSpeedSample.xcodeproj in Xcode 13.4.1 and run on any device.

Project is compatible with iPhone and iPad and in all orientation. 

## Features Implemented
1) Data is fetched from the Server initially at the viewLoad.
2) Display error message in case of:
   ###  no network.
   ###  API Failure
3) Initially, user will se an empty screen with "Fetch & Show" button.
4) Whenever "Fetch and Show" button is clicked, a single random data is displayed on the screen from the data fetched at step number 1 and also, saved to Core data.
5) Image and Author name will be displayed on the screen after successfully saving data locally.


## Test Cases Covered
1) Fetching API from the server.
2) Saving and fetching in core data.
3) Check delegates and cell identifier of table view.

## To-do
[] Check for duplicate item in the list
[] Refresh control
