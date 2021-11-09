part of 'list_tv_season_bloc.dart';

abstract class ListTvSeasonState extends Equatable {
  const ListTvSeasonState();

  @override
  List<Object> get props => [];
}

class ListTvSeasonEmpty extends ListTvSeasonState {}

class ListTvSeasonLoading extends ListTvSeasonState {}

class ListTvSeasonLoaded extends ListTvSeasonState {
  final List<TvSeason> tvSeasons;

  const ListTvSeasonLoaded({required this.tvSeasons});

  @override
  List<Object> get props => [tvSeasons];
}

class ListTvSeasonError extends ListTvSeasonState {
  final String message;

  const ListTvSeasonError({required this.message});

  @override
  List<Object> get props => [message];
}
