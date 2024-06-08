abstract class Either<L, R> {
  const Either();

  bool isLeft();
  bool isRight();

  L? getLeft();
  R? getRight();

  Either<L2, R> mapLeft<L2>(L2 Function(L) f);
  Either<L, R2> map<R2>(R2 Function(R) f);

  Either<L2, R2> biMap<L2, R2>(L2 Function(L) fLeft, R2 Function(R) fRight);

  Future<Either<L2, R>> asyncMapLeft<L2>(Future<L2> Function(L) f);
  Future<Either<L, R2>> asyncMap<R2>(Future<R2> Function(R) f);

  Future<T> asyncFold<T>(Future<T> Function(L) onLeft, Future<T> Function(R) onRight);

  R getOrElse(R defaultValue);
  Either<L, R> orElse(Either<L, R> other);

  T fold<T>(T Function(L) onLeft, T Function(R) onRight);

  T match<T>({required T Function(L) left, required T Function(R) right});
}

class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  L? getLeft() => value;

  @override
  R? getRight() => null;

  @override
  Either<L2, R> mapLeft<L2>(L2 Function(L) f) => Left<L2, R>(f(value));

  @override
  Either<L, R2> map<R2>(R2 Function(R) f) => Left<L, R2>(value);

  @override
  Either<L2, R2> biMap<L2, R2>(L2 Function(L) fLeft, R2 Function(R) fRight) =>
      Left<L2, R2>(fLeft(value));

  @override
  Future<Either<L2, R>> asyncMapLeft<L2>(Future<L2> Function(L) f) async => Left<L2, R>(await f(value));

  @override
  Future<Either<L, R2>> asyncMap<R2>(Future<R2> Function(R) f) async => Left<L, R2>(value);

  @override
  Future<T> asyncFold<T>(Future<T> Function(L) onLeft, Future<T> Function(R) onRight) => onLeft(value);

  @override
  R getOrElse(R defaultValue) => defaultValue;

  @override
  Either<L, R> orElse(Either<L, R> other) => other;

  @override
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) => onLeft(value);

  @override
  T match<T>({required T Function(L) left, required T Function(R) right}) => left(value);
}

class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  L? getLeft() => null;

  @override
  R? getRight() => value;

  @override
  Either<L2, R> mapLeft<L2>(L2 Function(L) f) => Right<L2, R>(value);

  @override
  Either<L, R2> map<R2>(R2 Function(R) f) => Right<L, R2>(f(value));

  @override
  Either<L2, R2> biMap<L2, R2>(L2 Function(L) fLeft, R2 Function(R) fRight) =>
      Right<L2, R2>(fRight(value));

  @override
  Future<Either<L2, R>> asyncMapLeft<L2>(Future<L2> Function(L) f) async => Right<L2, R>(value);

  @override
  Future<Either<L, R2>> asyncMap<R2>(Future<R2> Function(R) f) async => Right<L, R2>(await f(value));

  @override
  Future<T> asyncFold<T>(Future<T> Function(L) onLeft, Future<T> Function(R) onRight) => onRight(value);

  @override
  R getOrElse(R defaultValue) => value;

  @override
  Either<L, R> orElse(Either<L, R> other) => this;

  @override
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) => onRight(value);

  @override
  T match<T>({required T Function(L) left, required T Function(R) right}) => right(value);
}

