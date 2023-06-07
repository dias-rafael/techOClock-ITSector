typedef FutureEither<Error, Response> = Future<Either<Error, Response>>;

abstract class Either<L, R> {
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  bool isLeft() => fold((_) => true, (_) => false);
  bool isRight() => fold((_) => false, (_) => true);

  R getOrElse(R Function() dflt) => fold((_) => dflt(), id);
}

class Left<L, R> extends Either<L, R> {
  final L _l;

  Left(this._l);

  L get value => _l;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(value);

  @override
  bool operator ==(other) => other is Left && other._l == _l;

  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  final R _r;

  Right(this._r);

  R get value => _r;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(value);

  @override
  bool operator ==(other) => other is Right && other._r == _r;

  @override
  int get hashCode => _r.hashCode;
}

A id<A>(A a) => a;

class Unit {
  const Unit._();
}
