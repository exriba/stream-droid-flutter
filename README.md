# stream-droid-flutter

A cross-platform UI for the Stream-Droid backend service. Provides streamers with views for managing Twitch channel rewards, redemptions, and real-time subscriber events.

<img width="998" height="588" alt="image" src="https://github.com/user-attachments/assets/0c172d0d-d577-4b84-8194-b42a79adf12d" />

## Features:
* View and manage channel rewards
* Monitor real-time redemptions
* Analyze redemption statistics
* Handle subscriber events

<img width="984" height="593" alt="image" src="https://github.com/user-attachments/assets/a3a51f79-3b98-4e78-ac2b-cd60f3c0005c" />

## Built with:
* Flutter 3.3+ (Dart)
* gRPC for backend communication
* Riverpod for state management
* Hive for local storage
* Flutter Secure Storage for JWT management

## Architecture

The project follows Clean Architecture with Riverpod for dependency injection.

### Folder Structure:
lib/src/
app/                    Root widget
configuration/          App configuration
constants/              Constants
interceptors/           gRPC middleware
layout/                 Layout components
models/                 Data models
providers/              Riverpod providers for DI
screens/                UI screens (dashboard, rewards, etc)
services/               Business logic and gRPC clients
utils/                  Utility functions
widgets/                Reusable UI components

### Data Flow:

UI Screen
↓
Riverpod Provider (State)
↓
Service (Business Logic)
↓
gRPC Client (with Interceptors)
↓
Backend Server

## Getting Started

Prerequisites:
* Flutter 3.3.0 or higher
* Dart 3.3.0 or higher
* Stream-Droid backend server running
* Twitch application credentials

Installation:
* Clone the repository
* Install dependencies
    `flutter pub get`
* Generate gRPC code: This generates Protobuf Dart classes, gRPC service clients, and message serialization code.
    protoc --dart_out=grpc:lib/src/generated \
    -Iprotos \
    -I"path/to/protoc" \
    ./protos/common/empty.proto \
    ./protos/common/event.proto \
    ./protos/common/redeem.proto \
    ./protos/common/reward.proto \
    ./protos/common/user.proto \
    ./protos/service/eventservice.proto \
    ./protos/service/redeemservice.proto \
    ./protos/service/rewardservice.proto \
    ./protos/service/userservice.proto 

Configure and run the application:
* Add .env/dev.json file with:
    app_name
    server_name
    server_port
* Desktop:
    `flutter run -d macos`
    `flutter run -d linux`
    `flutter run -d windows`

## Security
* User logs in via Twitch OAuth
* Backend returns JWT token
* Client stores token in secure storage
* AuthInterceptor injects token into every request
* Backend sends new token in response headers
* Client atomically updates token if changed
* Token updates are protected with Mutex to prevent race conditions.

## Testing

Run all tests:
`flutter test`