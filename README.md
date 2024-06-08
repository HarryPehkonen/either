<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Either

A simple implementation of the Either monad for Dart, designed to handle computations that may result in either a success (Right) or a failure (Left).

## Features

- **Functional Programming:** Use functional programming paradigms to handle errors and transformations elegantly.
- **Error Handling:** Simplifies error handling by clearly distinguishing between success and failure cases.
- **Transformations:** Provides methods for transforming values contained within Either.
- **Asynchronous Support:** Includes methods for working with asynchronous computations.

## Getting Started

### Installation

Add `either` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  either:
    git:
      url: https://github.com/yourusername/either.git
      ref: main
```

Then, run dart pub get to install the package.

## Usage

### Basic Usage

Create and use `Either` instances for handling computations that can succeed or fail.

[code goes here]

### Transformations

Transform the values inside an Either using `map`, `mapLeft`, and `biMap`.

```dart
import 'package:either/either.dart';

final either = Right<String, int>(42);

// Using map to transform the Right value
final transformed = either.map((r) => r * 2);

// Using biMap to transform both Left and Right values
final biTransformed = either.biMap(
  (left) => 'New $left',
  (right) => right * 2,
);
```

### Error Handling

Handle errors by providing default values or alternative `Either` instances.

```dart
import 'package:either/either.dart';

final either = Left<String, int>('Error occurred');

// Providing a default value
final value = either.getOrElse(0);

// Providing an alternative Either
final alternative = either.orElse(Right<String, int>(100));
```

### Asynchronous Operations

Work with asynchronous computations using `asyncMap` and `asyncFold`.

```dart
import 'package:either/either.dart';

Future<void> asyncExample() async {
  final either = Right<String, int>(42);

  // Using asyncMap to transform the Right value asynchronously
  final result = await either.asyncMap((r) async {
    await Future.delayed(Duration(seconds: 1));
    return r * 2;
  });

  // Using asyncFold to handle Left and Right cases asynchronously
  final foldedResult = await either.asyncFold(
    (left) async => 'Failed with: $left',
    (right) async => 'Success with: $right',
  );
}
```

## Additional Information

For working versions of these examples, please refer to the `./example/either_example.dart` file.

### Contribution

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

### License

This work is dedicated to the public domain under the [CC0 1.0 Universal (CC0 1.0) Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/).

---

By using the `Either` monad, you can handle errors and transformations in a functional and elegant way, simplifying the complexity of error-prone computations. For more detailed examples, explore the `either_example.dart` file in the `example` directory.
