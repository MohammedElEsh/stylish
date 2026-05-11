# Architectural Specification & Engineering Standard (SOP)
## Project: Stylish — The Superior Hybrid Core

This document serves as the authoritative technical specification and Standard Operating Procedure (SOP) for the **Stylish** Flutter application. It codifies the "Superior Hybrid Core" architecture—a highly optimized, domain-less MVVM implementation designed for production-grade scalability, maintenance, and performance.

---

## 1. Architectural Vision
The architecture is a **Hybrid Synthesis** of advanced production patterns, emphasizing a "Lean Engineering" philosophy. We eliminate the redundant abstractions of traditional Clean Architecture (Domain/Use-Cases) in favor of a high-performance **Three-Layer Reactive Flow**.

### Core Pillars:
- **Zero Code Generation:** Absolute reliance on manual, explicit, and readable Dart code.
- **Atomic Reliability:** Predictable state transitions via Cubit and functional error handling.
- **Design Token Consistency:** A centralized, mathematical approach to UI/UX via tokens.
- **Layered Decoupling:** Strict isolation between networking, data orchestration, and presentation.

---

## 2. Layered Responsibility Matrix

| Layer | Component | Technical Mandate |
| :--- | :--- | :--- |
| **Presentation** | `View` | Stateless/Stateful Widgets. Subscribes to Cubit states. Zero logic. |
| **Orchestration** | `ViewModel` | `Cubit` only. Manages UI state lifecycle. Delegates to Repository. |
| **Data Logic** | `Repository` | The **Data Orchestrator**. Uses `safeCall()`. Maps DTOs to Models. |
| **Infrastructure**| `DataSource` | **Remote**: Dio execution. **Local**: Hive/SecureStorage execution. |
| **Structures** | `Model` | Plain Dart classes. Manual `fromJson/toJson`. Extends `Equatable`. |

---

## 3. The Superior Hybrid Core (`lib/core/`)

The core is the "Engine Room" of the application. It is organized by **Functional Responsibility** rather than generic utility.

### 3.1. Infrastructure & Networking
- **`network/`**: Implements a singleton `DioClient` with modular interceptors.
    - `AuthInterceptor`: Silent token injection and 401 handling.
    - `PrettyDioLogger`: High-fidelity terminal logging for debug environments.
- **`services/`**: Abstracted system capabilities.
    - `StorageService`: Optimized Hive implementation for high-speed caching.
    - `SecureStorageService`: Encrypted storage for sensitive credentials.
    - `ConnectivityService`: Reactive stream for internet availability.

### 3.2. Error Handling Pattern
We utilize a functional approach to errors using `fpdart` and the `safeCall` wrapper.
- **Failures**: Discrete classes (`ServerFailure`, `NetworkFailure`, etc.) that carry semantic error data.
- **safeCall**: Ensures all exceptions (Dio, Socket, Hive) are caught and converted into `Left(Failure)` before reaching the ViewModel.

### 3.3. Design System (Atomic UI)
- **`theme/tokens/`**: The "Source of Truth" for measurements. Includes `AppSpacing`, `AppRadius`, and `AppShadows`.
- **`theme/themes/`**: Centralized `ThemeData` factory providing exhaustive Light/Dark configurations.
- **`widgets/`**: A library of **Atomic Components**. If a widget is structural or reused, it belongs here.

---

## 4. Engineering Directives (The "Laws")

### 4.1. The "No Generation" Directive
To ensure long-term maintainability and rapid debugging, the following are strictly prohibited:
- ❌ No `build_runner`.
- ❌ No `json_serializable` (Use manual JSON mapping).
- ❌ No `freezed` (Use manual sealed classes/subtypes).
- ❌ No `injectable` (Use manual registration in `injection.dart`).

### 4.2. Functional Data Flow SOP
Every repository method must strictly adhere to this signature:
`Future<Either<Failure, T>> methodName(Params params);`

### 4.3. Dependency Injection (DI)
Dependency registration is centralized in `lib/core/di/injection.dart`.
- **Singletons**: Used for Clients, Services, and Repositories.
- **Factories**: Used for ViewModels (Cubits) to ensure fresh state per screen.

---

## 5. Feature Implementation Protocol

Follow these steps in exact sequence for every new feature:

1.  **Structural Initialization**: Create `lib/features/{feature_name}/` with `data/` and `presentation/` sub-architectures.
2.  **Model Definition**: Author the `Model` class with explicit `fromJson` and `props` overrides for `Equatable`.
3.  **Data Execution**: Implement `RemoteDataSource` using the core `Dio` instance.
4.  **Data Orchestration**: Implement the `Repository` using `safeCall()` to wrap all DataSource calls.
5.  **State Modeling**: Define a sealed `State` class (e.g., `Initial`, `Loading`, `Success`, `Error`).
6.  **ViewModel Development**: Build the `Cubit` to handle intent and emit mapped states.
7.  **DI Registration**: Manually register all new classes in `lib/core/di/injection.dart`.
8.  **Routing**: Define the route in `RouteNames` and add to `appRouter`.
9.  **UI Construction**: Implement the `Page` and `Widgets` using `ScreenUtil` and `AppTokens`.

---

## 6. Code Style & Quality Assurance

- **Naming**: 
    - Routes: `/kebab-case`.
    - Assets: `snake_case`.
    - Classes: `PascalCase`.
- **Efficiency**: Use `const` constructors aggressively.
- **Localization**: No hardcoded strings in the UI. All text must pass through `easy_localization`.
- **Responsive Layouts**: All dimensions must use ScreenUtil (`.h`, `.w`, `.sp`, `.r`).

---

## 7. Definition of Done (DoD)
- [ ] Feature complies with the **Three-Layer Reactive Flow**.
- [ ] All async operations are wrapped in `safeCall()`.
- [ ] States cover `Loading`, `Success`, and semantic `Error`.
- [ ] UI is responsive and localized (EN/AR).
- [ ] Manual DI registration is complete.
- [ ] Code is formatted and lint-free.
