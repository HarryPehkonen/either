import 'package:either/either.dart';

void main() {
  basicUsage();
  transformationExample();
  errorHandlingExample();
  asyncExample();
  asyncErrorHandlingExample();
}

void basicUsage() {
  final either = Right<String, int>(42);

  either.fold(
    (left) => print('Left: $left'),
    (right) => print('Right: $right'),
  );

  final eitherError = Left<String, int>('Error occurred');
  eitherError.fold(
    (left) => print('Left: $left'),
    (right) => print('Right: $right'),
  );
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

void errorHandlingExample() {
  final either = Left<String, int>('Error occurred');

  final message = either.getOrElse(0);
  print('Error handling, default value: $message');

  final eitherSuccess = Right<String, int>(42);
  final successMessage = eitherSuccess.getOrElse(0);
  print('Success handling, value: $successMessage');
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

Future<void> asyncErrorHandlingExample() async {
  final either = Left<String, int>('Error occurred');

  final result = await either.asyncFold(
    (left) async {
      await Future.delayed(Duration(seconds: 1));
      return 'Failed with: $left';
    },
    (right) async {
      await Future.delayed(Duration(seconds: 1));
      return 'Success with: $right';
    },
  );

  print('Async error handling: $result');

  final eitherSuccess = Right<String, int>(42);

  final successResult = await eitherSuccess.asyncFold(
    (left) async {
      await Future.delayed(Duration(seconds: 1));
      return 'Failed with: $left';
    },
    (right) async {
      await Future.delayed(Duration(seconds: 1));
      return 'Success with: $right';
    },
  );

  print('Async success handling: $successResult');
}

