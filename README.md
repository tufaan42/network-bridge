# NetworkBridge

### NetworkBridge is a powerful and easy-to-use iOS package designed to handle all your network call needs. Built with Swift, it provides a robust and efficient way to manage HTTP requests, parse responses, and handle errors seamlessly

```swift
let commonHeaders = [
    "Content-Type": "application/json",
    "Authorization": "Bearer your_token_here"
]

let networkBridge = NetworkBridge(commonHeaders: commonHeaders)

// Get request example
networkBridge.getRequest().execute(
    url: "https://api.example.com/users",
    completion: { (result: Result<[UserResponse], ApiError>) in
        switch result {
        case .success(let users):
            print("Fetched users:", users)
        case .failure(let error):
            print("GET request failed with error:", error)
        }
    }
)

```
