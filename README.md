# MVVM + Clean Architecture — iOS

A production-ready iOS app demonstrating **MVVM pattern** with **Clean Architecture** — the architecture used in professional iOS teams worldwide.

Built with **Swift + SwiftUI + async/await**, consuming the [JSONPlaceholder API](https://jsonplaceholder.typicode.com).

---

## Architecture Overview

```
┌─────────────────────────────────────────┐
│           PRESENTATION LAYER            │
│         Views  +  ViewModels            │
│    SwiftUI • @Observable • @State       │
├─────────────────────────────────────────┤
│             DOMAIN LAYER                │
│   Entities • UseCases • Protocols       │
│     Pure Swift — zero dependencies      │
├─────────────────────────────────────────┤
│              DATA LAYER                 │
│   APIClient • DTOs • Repository Impl    │
│         async/await • URLSession        │
└─────────────────────────────────────────┘
```

---

## Key Concepts Demonstrated

### 1. Separation of Concerns
Each layer has one job and one job only:
- **Domain** — business rules, knows nothing about UI or networking
- **Data** — fetches and transforms data, knows nothing about UI
- **Presentation** — displays data, knows nothing about networking

### 2. Repository Pattern
```swift
// Domain defines the contract
protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [User]
    func fetchPosts(for userId: Int) async throws -> [Post]
}

// Data layer implements it
final class UserRepository: UserRepositoryProtocol { ... }
```
Swap the implementation anytime without touching the rest of the app.

### 3. Use Cases — One Responsibility
```swift
final class FetchUsersUseCase {
    func execute() async throws -> [User] {
        let users = try await repository.fetchUsers()
        return users.sorted { $0.name < $1.name } // business rule here
    }
}
```

### 4. DTO → Entity Mapping
```swift
// API response shape (DTO)
struct UserDTO: Codable { ... }

// App domain model (Entity)  
struct User { ... }

// Clean conversion
func toDomain() -> User { ... }
```
API changes don't break your app's business logic.

### 5. Dependency Injection
```swift
// App entry point wires everything together
let apiClient  = APIClient()
let repository = UserRepository(apiClient: apiClient)
let useCase    = FetchUsersUseCase(repository: repository)
let viewModel  = UsersViewModel(fetchUsersUseCase: useCase)
```
Every layer depends on abstractions, not concretions.

---

## Project Structure

```
MVVMCleanArchitecture/
├── App/
│   └── MVVMCleanApp.swift          ← Entry point + DI wiring
├── Domain/                         ← Pure Swift, NO imports
│   ├── Entities/
│   │   ├── User.swift
│   │   └── Post.swift
│   ├── Repositories/
│   │   └── UserRepositoryProtocol.swift
│   └── UseCases/
│       ├── FetchUsersUseCase.swift
│       └── FetchPostsUseCase.swift
├── Data/                           ← Networking + mapping
│   ├── Network/
│   │   ├── APIClient.swift
│   │   └── Endpoints.swift
│   ├── DTOs/
│   │   ├── UserDTO.swift
│   │   └── PostDTO.swift
│   └── Repositories/
│       └── UserRepository.swift
└── Presentation/                   ← SwiftUI Views + ViewModels
    ├── Users/
    │   ├── UsersView.swift
    │   └── UsersViewModel.swift
    └── Posts/
        ├── PostsView.swift
        └── PostsViewModel.swift
```

---

## Data Flow

```
View.task{ } 
    → ViewModel.loadUsers()
        → FetchUsersUseCase.execute()
            → UserRepositoryProtocol.fetchUsers()
                → UserRepository (impl)
                    → APIClient.fetch()
                        → URLSession (network)
                    ← [UserDTO]
                ← [User] (mapped via toDomain())
            ← [User] (sorted)
        ← updates @Observable state
    ← SwiftUI re-renders automatically
```

---

## Tech Stack

| Technology | Usage |
|-----------|-------|
| Swift 5.9+ | Language |
| SwiftUI | UI Framework |
| async/await | Concurrency |
| @Observable | State Management |
| URLSession | Networking |
| JSONPlaceholder | Free REST API |

---

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

---

## Why Clean Architecture?

| Without Clean Arch | With Clean Arch |
|-------------------|-----------------|
| ViewModel has 500+ lines | Each class < 100 lines |
| Can't unit test easily | Every layer is testable |
| API change = rewrite | API change = update DTO only |
| Hard to onboard new devs | Self-documenting structure |

---

## Author

**Bilal Zafar** — iOS Developer  
[GitHub](https://github.com/hmbz) • [LinkedIn](https://www.linkedin.com/in/hafiz-muhammad-bilal-b8543b1b5/)
