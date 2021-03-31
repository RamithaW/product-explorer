# Adidas coding challenge
## Pre requisites
- Xcode 11.6 or above
- iOS simulator or device with iOS 13.6 or above

## Setting things up
- Clone or download the project from the github repository
- Move to the project directory and install the dependencies
    ```sh
    cd Adidas\ Challenge/
    pod install
    ```
- Once the pods have been installed open the `Adidas Challenge.xcworkspace` in Xcode
- Open the `ApplicationConstants.swift` file and set the `baseUrl` to point to the backend server address (use localhost if you are running the docker locally)
- Run the application

## Application architecture
##### Architecture used: MVVM-C
##### Justification:
MVC, MVVM, MVVM-C & VIPER arhitectures were considered. While MVC has the least separation of concerns between layers and would cause the ViewController to grow uncontrollably as the application grew, VIPER seemed to be an overkill.
While MVVM would be an ideal candidate, based on past experiences with this architecture, navigation across screens was not best handled by this (especially if there are quite a few screens to be shown). MVVM-C allows us to offload the presentation logic to the Coordinator entorely, leaving the ViewModel to concentrate more on the logic.

When working in a team it's always good to have a standard structure in the features we build. This would help engineers to develop features quickly as well as reduce the learning curve in understanding the structure of the project (hence, easing the onbiarding of new devs). Therefore, a module based approach was taken to buld 3 main features that were required as per the spec:
- Product List
- Product Details
- Adding Reviews

Clean architecture is something I like to follow and hence, decided to implement it here as well.

High level directory Structure:

    .
    ├── Application   # High level application related files like BaseCoordinator and AppDelegates
    ├── Features      # The main feature modules
    ├── Core          # Core components that can be used across the application
    └── Utils		  # Helper or utility features to make dev life a bit more easy

Each feature module would have:

    .
    ├── Domain			# Domain related logic consisting of UseCases that can be used by the presentation layer
    ├── Service			# External API calls and related logic would reside here
    ├── Builder			# Contains a builder that injects dependencies and instantiaties a module
    └── Presentation	# Presentation logic goes here

The responsibility of a few components:


## Improvements & Notes

## CI/CD

## UI/UX

