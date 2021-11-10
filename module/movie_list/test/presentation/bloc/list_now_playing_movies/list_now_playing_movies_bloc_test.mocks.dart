// Mocks generated by Mockito 5.0.16 from annotations
// in movie_list/test/presentation/bloc/list_now_playing_movies/list_now_playing_movies_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i2;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_list/domain/usecases/get_now_playing_movies.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetListNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetListNowPlayingMovies extends _i1.Mock
    implements _i4.GetListNowPlayingMovies {
  MockGetListNowPlayingMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i2.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i2.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i2.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i2.Movie>>>);
  @override
  String toString() => super.toString();
}
