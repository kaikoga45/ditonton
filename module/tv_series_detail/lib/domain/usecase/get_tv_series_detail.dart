import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvSeriesDetail {
  TvSeriesRepository repository;
  GetTvSeriesDetail({required this.repository});

  Future<Either<Failure, TvSeriesDetail>> execute(int id) async {
    return await repository.getTvSeriesDetail(id);
  }
}
