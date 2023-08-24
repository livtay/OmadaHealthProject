# Omada Health Movie Search App

https://github.com/livtay/OmadaHealthProject/assets/20843932/74983590-82ce-4cc4-ae4d-04127803eedf

## Intro

Welcome to my Omada Health Project! I implemented this app using SwiftUI and MVVM architecture without any 3rd party libraries. The project will build normally using the `.xcworkspace` file.

## Architecture

I implemented this app using the MVVM design pattern, as I feel that it pairs well with SwiftUI, and makes for clean, functional, and testable code. The view model handles the business logic by calling the Movie Service (networking), decoding the data to models, and communicating to the views via state changes for UI updates. I also use dependency injection to help keep the code modular and testable.

I used Combine for its debounce capability, to help limit the number of API calls being made while searching and decrease the potential for lag. For network calls, I chose to adopt Swift Concurrency for its simplicity and because it works so seamlessly with SwiftUI.
 
I've included unit tests using XCTest.

## Notes

Some of the decisions I made in this app were due to the simplicity of the functionality as well as the time constraints. Given more time, I might have included some other features, such as resizable views in the movie list (currently the height is fixed and allows for 3 rows of title text before truncating). I also would have liked to prettify the UI for empty and error states. While I included unit tests for the models, views, and networking, I also would include snapshot testing with mock data to ensure the UI is set up correctly given possible edge cases.
