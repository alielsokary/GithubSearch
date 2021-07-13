# GithubSearch

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/2e97cf5caaff4898924a600830f3d802)](https://app.codacy.com/gh/alielsokary/GithubSearch?utm_source=github.com&utm_medium=referral&utm_content=alielsokary/GithubSearch&utm_campaign=Badge_Grade_Settings)


## Project Structure

```
.
├── GithubSearch
│   │   ├── App             # cotnains `AppDelegate` and `AppCoordinator`
│   │   ├── Library         # contains Helper/Extensions files
│   │   │   └── Extension 
│   │   ├── Models         
│   │   ├── Storyboards     
│   │   ├── Scenes          # contains all app Scenes
│   │   │   └── ${Module}   # contains concrete module, its structure is described in Layered architecture 
└── Pods
```

## Architecture description

### Modular development

Application is separated into small units with similar functionality that can be developed independently.

### Layered architecture

Each module is divided by layers:

```
├── Coordinator
├── ViewModel
├── View
│   ├── Cell
│   └── Layout
```

## Dependencies

### netfox
For in Xcode console network monitoring.

### Rx
Used for search feature and for the return type of the github search service.


### SwiftLint
To Maintain a proper code styling (rules configured in .swiftlint.yml).

### R.swift
For easier app resource management and to avoid runtime errors for mismatched resource names.