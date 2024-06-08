import 'package:either/either.dart';
import 'package:test/test.dart';

void main() {
  group('Either monad tests', () {
    test('Left contains the correct value', () {
      final either = Left<String, int>('Error occurred');
      expect(either.isLeft(), isTrue);
      expect(either.isRight(), isFalse);
      expect(either.getLeft(), 'Error occurred');
      expect(either.getRight(), isNull);
    });

    test('Right contains the correct value', () {
      final either = Right<String, int>(42);
      expect(either.isLeft(), isFalse);
      expect(either.isRight(), isTrue);
      expect(either.getLeft(), isNull);
      expect(either.getRight(), 42);
    });

    test('map on Left should not change the value', () {
      final either = Left<String, int>('Error occurred');
      final result = either.map((r) => r * 2);
      expect(result.isLeft(), isTrue);
      expect(result.getLeft(), 'Error occurred');
    });

    test('map on Right should change the value', () {
      final either = Right<String, int>(42);
      final result = either.map((r) => r * 2);
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 84);
    });

    test('fold on Left should use the left function', () {
      final either = Left<String, int>('Error occurred');
      final result = either.fold(
        (left) => 'Failed with: $left',
        (right) => 'Success with: $right',
      );
      expect(result, 'Failed with: Error occurred');
    });

    test('fold on Right should use the right function', () {
      final either = Right<String, int>(42);
      final result = either.fold(
        (left) => 'Failed with: $left',
        (right) => 'Success with: $right',
      );
      expect(result, 'Success with: 42');
    });

    test('match on Left should use the left function', () {
      final either = Left<String, int>('Error occurred');
      final result = either.match(
        left: (left) => 'Failed with: $left',
        right: (right) => 'Success with: $right',
      );
      expect(result, 'Failed with: Error occurred');
    });

    test('match on Right should use the right function', () {
      final either = Right<String, int>(42);
      final result = either.match(
        left: (left) => 'Failed with: $left',
        right: (right) => 'Success with: $right',
      );
      expect(result, 'Success with: 42');
    });

    test('getOrElse on Left should return default value', () {
      final either = Left<String, int>('Error occurred');
      final result = either.getOrElse(0);
      expect(result, 0);
    });

    test('getOrElse on Right should return the contained value', () {
      final either = Right<String, int>(42);
      final result = either.getOrElse(0);
      expect(result, 42);
    });

    test('orElse on Left should return the alternative Either', () {
      final either = Left<String, int>('Error occurred');
      final result = either.orElse(Right<String, int>(100));
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 100);
    });

    test('orElse on Right should return the original Either', () {
      final either = Right<String, int>(42);
      final result = either.orElse(Right<String, int>(100));
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 42);
    });

    test('biMap on Left should apply the left function', () {
      final either = Left<String, int>('Error occurred');
      final result = either.biMap(
        (left) => 'New $left',
        (right) => right * 2,
      );
      expect(result.isLeft(), isTrue);
      expect(result.getLeft(), 'New Error occurred');
    });

    test('biMap on Right should apply the right function', () {
      final either = Right<String, int>(42);
      final result = either.biMap(
        (left) => 'New $left',
        (right) => right * 2,
      );
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 84);
    });

    test('mapLeft on Left should change the left value', () {
      final either = Left<String, int>('Error occurred');
      final result = either.mapLeft((left) => 'New $left');
      expect(result.isLeft(), isTrue);
      expect(result.getLeft(), 'New Error occurred');
    });

    test('mapLeft on Right should not change the value', () {
      final either = Right<String, int>(42);
      final result = either.mapLeft((left) => 'New $left');
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 42);
    });
  });

  group('Either monad async tests', () {
    test('asyncMap on Right should change the value asynchronously', () async {
      final either = Right<String, int>(42);
      final result = await either.asyncMap((r) async => r * 2);
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 84);
    });

    test('asyncMap on Left should not change the value', () async {
      final either = Left<String, int>('Error occurred');
      final result = await either.asyncMap((r) async => r * 2);
      expect(result.isLeft(), isTrue);
      expect(result.getLeft(), 'Error occurred');
    });

    test('asyncMapLeft on Left should change the left value asynchronously', () async {
      final either = Left<String, int>('Error occurred');
      final result = await either.asyncMapLeft((left) async => 'New $left');
      expect(result.isLeft(), isTrue);
      expect(result.getLeft(), 'New Error occurred');
    });

    test('asyncMapLeft on Right should not change the value', () async {
      final either = Right<String, int>(42);
      final result = await either.asyncMapLeft((left) async => 'New $left');
      expect(result.isRight(), isTrue);
      expect(result.getRight(), 42);
    });

    test('asyncFold on Left should use the left function asynchronously', () async {
      final either = Left<String, int>('Error occurred');
      final result = await either.asyncFold(
        (left) async => 'Failed with: $left',
        (right) async => 'Success with: $right',
      );
      expect(result, 'Failed with: Error occurred');
    });

    test('asyncFold on Right should use the right function asynchronously', () async {
      final either = Right<String, int>(42);
      final result = await either.asyncFold(
        (left) async => 'Failed with: $left',
        (right) async => 'Success with: $right',
      );
      expect(result, 'Success with: 42');
    });
  });
}

