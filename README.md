# ios_template

## Folder Structure

Here is the core folder structure for the application:

```text
App/
|- Config
|- Resources
|- Entities
|- Core
|   - Network
|- Extensions
```

### App Folder

- **Config**:  Contains all configuration settings for the application.
- **Resources**: Contains resources such as image assets and configuration files.
- **Entities**: Contains the models which represent the data and business logic.
- **Core**: Contains the core concept like network, localstorage

### Core

#### Network

The Network folder is organized to separate concerns in network communication:

```text
Network/
|- Requests
|- ApiClient
|- ApiResponse
|- Endpoint
|- ApiClient+Logger
```

- **Requests**: Contains the definitions of all network requests for the application
- **ApiClient**: Manages the execution of network requests and interactions with the network
- **ApiResponse**: Processes the data returned from the network and handles errors
- **Endpoint**: Defines the various API routes used in the application
- **ApiClient+Logger**: Contains logging functionality for API interactions

##### Example API Usage

```swift
let client: ApiClient = ApiClientImplementation()
let endpoint = CreatePostRequest(requestBody: CreatePostParams(title: "", body: "dasdsad", userId: 2312))
Task {
    let res = try await client.execute(endpoint: endpoint, type: VoidResponse.self)
    switch res {
    case .success(let obj):
        print(obj.entity)
        case .failure(let err):
            print(err)
        }
    }
```
