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
      url: https://github.com/harrypehkonen/either.git
      ref: main
```

Then, run dart pub get to install the package.

## Usage

### Basic Usage

Create and use `Either` instances for handling computations that can succeed or fail.

```dart
import 'package:either/either.dart';

void main() {
  basicUsage();
}

void basicUsage() {
  final either = Right<String, int>(42);
  final eitherError = Left<String, int>('Error occurred');

  either.fold(
    (left) => print('Left: $left'),
    (right) => print('Right: $right'),
  );

  eitherError.fold(
    (left) => print('Left: $left'),
    (right) => print('Right: $right'),
  );
}
```

### Transformations

Transform the values inside an Either using `map`, `mapLeft`, and `biMap`.

```dart
void main() {
  transformationExample();
}

void transformationExample() {
  final either = Right<String, int>(42);
  final result = either.map((r) => r * 2);

  result.fold(
    (left) => print('Left: $left'),
    (right) => print('Right after transformation: $right'),
  );

  final eitherError = Left<String, int>('Error occurred');
  final errorResult = eitherError.map((r) => r * 2);

  errorResult.fold(
    (left) => print('Left after transformation: $left'),
    (right) => print('Right: $right'),
  );
}
```

### Error Handling

Handle errors by providing default values or alternative `Either` instances.

```dart
void main() {
  errorHandlingExample();
}

void errorHandlingExample() {
  final either = Left<String, int>('Error occurred');
  final value = either.getOrElse(0);
  print('Error handling, default value: $value');

  final eitherSuccess = Right<String, int>(42);
  final successValue = eitherSuccess.getOrElse(0);
  print('Success handling, value: $successValue');
}
```

### Asynchronous Operations

Work with asynchronous computations using `asyncMap` and `asyncFold`.

```dart
void main() {
  asyncExample();
}

Future<void> asyncExample() async {
  final either = Right<String, int>(42);

  final result = await either.asyncMap((r) async {
    await Future.delayed(Duration(seconds: 1));
    return r * 2;
  });

  result.fold(
    (left) => print('Left: $left'),
    (right) => print('Right after async transformation: $right'),
  );
}

```

### Additional Examples

#### `mapLeft`

Transform the left value inside an Either using `mapLeft`.

```dart
void main() {
  additionalExamples();
}

Future<void> additionalExamples() async {
  // Example for `mapLeft`
  final eitherLeft = Left<String, int>('Error occurred');
  final mapLeftResult = eitherLeft.mapLeft((left) => 'New $left');
  mapLeftResult.fold(
    (left) => print('Left after mapLeft: $left'),
    (right) => print('Right: $right'),
  );
}
```

#### `biMap`

Transform both left and right values inside an Either using `biMap`.

```dart
void main() {
  additionalExamples();
}

Future<void> additionalExamples() async {
  // Example for `biMap`
  final eitherRight = Right<String, int>(42);
  final biMapResult = eitherRight.biMap(
    (left) => 'New $left',
    (right) => right * 2,
  );
  biMapResult.fold(
    (left) => print('Left after biMap: $left'),
    (right) => print('Right after biMap: $right'),
  );

}
```

#### `orElse`

Provide an alternative Either if the current one is a Left.

```dart
void main() {
  additionalExamples();
}

Future<void> additionalExamples() async {
  // Example for `orElse`
  final orElseResult = eitherLeft.orElse(Right<String, int>(100));
  orElseResult.fold(
    (left) => print('Left: $left'),
    (right) => print('Right after orElse: $right'),
  );

}
```

#### `getOrElse`

Get the right value or provide a default value if the Either is a Left.

```dart
import 'package:either/either.dart';

void main() {
  // Example usage of Either with getOrElse
  Either<String, int> rightValue = Right(42);
  Either<String, int> leftValue = Left("Error");

  // Using getOrElse to provide default values
  int result1 = rightValue.getOrElse(0); // Should be 42
  int result2 = leftValue.getOrElse(0);  // Should be 0

  print('Result 1: $result1'); // Output: Result 1: 42
  print('Result 2: $result2'); // Output: Result 2: 0
}
```

#### `asyncMap`

Asynchronously transform the right value inside an Either.

```dart
void main() {
  asyncExample();
}

Future<void> asyncExample() async {
  final either = Right<String, int>(42);

  final result = await either.asyncMap((r) async {
    await Future.delayed(Duration(seconds: 1));
    return r * 2;
  });

  result.fold(
    (left) => print('Left: $left'),
    (right) => print('Right after async transformation: $right'),
  );
}```

#### `asyncFold`

Asynchronously handle both left and right cases inside an Either.

```dart
void main() {
  additionalExamples();
}

Future<void> additionalExamples() async {
  // Example for `asyncFold`
  final asyncFoldResult = await eitherLeft.asyncFold(
    (left) async {
      await Future.delayed(Duration(seconds: 1));
      return 'Failed with: $left';
    },
    (right) async {
      await Future.delayed(Duration(seconds: 1));
      return 'Success with: $right';
    },
  );
  print('Async fold result: $asyncFoldResult');
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
