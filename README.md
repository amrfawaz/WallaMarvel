# WallaMarvel

# README #
Table of contents:
- [Getting Started](#getting-started)
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Folders structure](#folders-structure)


## Getting Started
This app contains list of Marvel characters returned from Marvel API. You can also see more information for each charchter by clicking on any of them in the list.

## Requirements ##

- Xcode 16.3
- iOS SDK 16+
- Swift 6+

## Features

**Home Screen (Heroes List)**
- Displays a scrollable list of Heroes retuned by consuming "/public/characters"
- Each Hero item shows:
  - Image
  - Name
  - Short description if any
- Search for hero in the list. The search is performed locally in loaded list.
- Pagination is implemented while scrolling, and page limit is set to 10 items per page. 

**Hero Details Screen**
- Accessed by tapping Hero Card in Heroes List
- Shows the hero information:
  - Image
  - Description
  - Comics
  - Series
  - Stories


## Architecture ##

The app is built using Clean architecture with MVVM-C (Model-View-ViewModel) architecture pattern for presentation layer, following Domain-Driven Design principles. The codebase is organized into domain, data, and presentation layers.
- SwiftUI is used for creating views
- It uses Combine for view model bindings and logic.
- URLSession is used for API connections.
- SPM is used as a dependencies manager
- App is modularized - has one package with most of the sources and is divided into libraries inside this package, see [Modularization part 1](https://www.pointfree.co/episodes/ep171-modularization-part-1) for more info


- **Domain Layer**:
  - Contains domain models representing Heroes entities.
  - Includes use cases for fetching Heroes data.

- **Data Layer**:
  - Manages network requests and data retrieval from the [Marvel API](https://gateway.marvel.com:443).

- **UI Layer**:
  - Uses SwiftUI for creating views.
  - Uses Combine for view model bindings and logic.


### Folders structure ##

- {FeatureName}
    - Sources
      - DI
          - DependencyContainer.swift - file with dependency injection registration
      - Data
        - DataSources
        - RepositoriesImp
        - Request
        - Response
        - Coordination
          - Coordinator that handle navigation logic between screens
      - Domain
        - Repositories
        - UseCases
      - UI
          - {ScreenName1}
              - {ScreenName1}View.swift
              - {ScreenName1}ViewModel.swift
              - {ScreenName1}ViewIntent.swift
              - ...
          - {ScreenName2}
              - {ScreenName2}View.swift
              - {ScreenName2}ViewModel.swift
              - {ScreenName2}ViewIntent.swift
              - ...
