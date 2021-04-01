# Adidas coding challenge

## Screencast

[Screencast can be found here](https://drive.google.com/file/d/1GZxLTHXBUdZtGtWCD64I40hreaW2A3TQ/view?usp=sharing)


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
While MVVM would be an ideal candidate, based on past experiences with this architecture, navigation across screens was not best handled by this (especially if there are quite a few screens to be shown). MVVM-C allows us to offload the presentation logic to the Coordinator entirely, leaving the ViewModel to concentrate more on the logic.

When working in a team it's always good to have a standard structure in the features we build. This would help engineers to develop features quickly as well as reduce the learning curve in understanding the structure of the project (hence, easing the onbiarding of new devs). Therefore, a module based approach was taken to buld 3 main features that were required as per the spec:
- Product List
- Product Details
- Adding Reviews

Clean architecture is something I like to follow and hence, decided to implement it here as well.

High level directory Structure:

    .
    ├── Application     # High level application related files like BaseCoordinator and AppDelegates
    ├── Features        # The main feature modules
    ├── Core            # Core components that can be used across the application
    └── Utils		    # Helper or utility features to make dev life a bit more easy

Each feature module would have:

    .
    ├── Domain			    # Domain related logic consisting of UseCases that can be used by the presentation layer
    ├── Service			    # External API calls and related logic would reside here
    ├── Builder			    # Contains a builder that injects dependencies and instantiaties a module
    └── Presentation    	# Presentation logic goes here


## Improvements & Notes

#### Functionality

- Search: Although the requirement was to search for product price, description & title, I have also included the ability to search by Id since, all the price, description & title was the same for all products in the database
- 

#### App Resilience
In terms of handling the internet connection, the implementation contains a screen that is displayed when there is a network error (or any other error for the moment) where the user is informed and has the capability to reload the screen. This can be further improved to give more details of the error that took place, such as the lack of internt connectivity or error server error. 

#### App Stability & errors tracking
For the current implementation I have only logged the errors that take place. As a next step we can integrate a tool like `Firebase` or `Crashlitics` to view the crashes remotely and also identify stats like the frequency and the number of users affected. Due to time constraints I have not implemented this in the project for now.

#### Testing
The architecture keeps in mind the testability and takes an interface-over-implementatin approach where classes can easily be mocked to ease the writing of unit tests. I have included tests for one feature due to time constrainst, since increasing the coverage is a repetitive task. `RxTest` was used to test the reactive aspect of the application.


## CI/CD
Due to time constraints I have not included any CI/CD related work, however, if this were to be incorporated, most Source control platforms support the automation of building, testing and deploying the application via runners. I do not have extensive experience with this but I can definitely take some time to read some docs and set up this infrastructure. Fastlane can also be used to automate processes like uploading of DSYM files and app store submissions in case the source control runners' features are limited or unavailable.

## UI/UX
I can think of a few improvements to the overall user experience namely:

- Use stars for showing/capturing rating details of a product. At the moment I have hardcoded the rating value to 4 when adding a review, but if given a little bit more time, we could add interactive stars that the user can tap to reflect the rating.
- Colours and aesthetics: I have stuck to os specific fonts and colours, but it would be neat to have a design system with custom colours and controls like buttons, but again since would cost some additional time, I'vde decided to omit it from implementation.
- The look and feel of the `Add review` screen acn be greatly improved
