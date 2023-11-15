import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getTvOnAir() async {
    try {
      final result = await remoteDataSource.getTvOnAir();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeason>>> getTvSeason(
      int id, int totalSeason) async {
    try {
      var result = <TvSeasonResponse>[];
      for (var i = 1; i <= totalSeason; i++) {
        result.add(await remoteDataSource.getTvSeason(id, i));
      }
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network!'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated not valid : ${e.message}'));
    }
  }
}
