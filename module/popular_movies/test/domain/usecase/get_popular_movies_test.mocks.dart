// Mocks generated by Mockito 5.0.16 from annotations
// in popular_movies/test/domain/usecase/get_popular_movies_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/core.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i4
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i4
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i4
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, _i3.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i3.Failure, _i3.MovieDetail>>.value(
              _FakeEither_0<_i3.Failure, _i3.MovieDetail>())) as _i4
          .Future<_i2.Either<_i3.Failure, _i3.MovieDetail>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i4
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i4
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  String toString() => super.toString();
}
