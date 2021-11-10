// Mocks generated by Mockito 5.0.16 from annotations
// in movie_detail/test/presentation/bloc/movie_watchlist/movie_watchlist_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i2;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_detail/domain/usecase/get_watchlist_status.dart' as _i4;
import 'package:movie_detail/domain/usecase/remove_watchlist_movie.dart' as _i7;
import 'package:movie_detail/domain/usecase/save_watchlist_movie.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeWatchlistRepository_0 extends _i1.Fake
    implements _i2.WatchlistRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetMovieWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieWatchListStatus extends _i1.Mock
    implements _i4.GetMovieWatchListStatus {
  MockGetMovieWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchlistRepository get repository => (super.noSuchMethod(
      Invocation.getter(#repository),
      returnValue: _FakeWatchlistRepository_0()) as _i2.WatchlistRepository);
  @override
  _i5.Future<_i3.Either<_i2.Failure, bool>> execute(
          int? id, _i2.WatchlistType? type) =>
      (super.noSuchMethod(Invocation.method(#execute, [id, type]),
              returnValue: Future<_i3.Either<_i2.Failure, bool>>.value(
                  _FakeEither_1<_i2.Failure, bool>()))
          as _i5.Future<_i3.Either<_i2.Failure, bool>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistMovie extends _i1.Mock
    implements _i6.SaveWatchlistMovie {
  MockSaveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchlistRepository get repository => (super.noSuchMethod(
      Invocation.getter(#repository),
      returnValue: _FakeWatchlistRepository_0()) as _i2.WatchlistRepository);
  @override
  _i5.Future<_i3.Either<_i2.Failure, String>> execute(_i2.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i2.Failure, String>>.value(
                  _FakeEither_1<_i2.Failure, String>()))
          as _i5.Future<_i3.Either<_i2.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistMovie extends _i1.Mock
    implements _i7.RemoveWatchlistMovie {
  MockRemoveWatchlistMovie() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchlistRepository get repository => (super.noSuchMethod(
      Invocation.getter(#repository),
      returnValue: _FakeWatchlistRepository_0()) as _i2.WatchlistRepository);
  @override
  _i5.Future<_i3.Either<_i2.Failure, String>> execute(_i2.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i2.Failure, String>>.value(
                  _FakeEither_1<_i2.Failure, String>()))
          as _i5.Future<_i3.Either<_i2.Failure, String>>);
  @override
  String toString() => super.toString();
}
