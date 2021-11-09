part of 'list_tv_season_bloc.dart';

abstract class ListTvSeasonEvent extends Equatable {
  const ListTvSeasonEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeason extends ListTvSeasonEvent {
  final int tvId;
  final int totalSeason;

  FetchTvSeason({required this.tvId, required this.totalSeason});

  @override
  List<Object> get props => [tvId, totalSeason];
}
