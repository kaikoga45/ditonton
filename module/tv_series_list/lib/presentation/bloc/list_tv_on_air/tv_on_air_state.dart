part of 'tv_on_air_bloc.dart';

abstract class ListTvOnAirState extends Equatable {
  const ListTvOnAirState();

  @override
  List<Object> get props => [];
}

class TvOnAirEmpty extends ListTvOnAirState {}

class TvOnAirLoading extends ListTvOnAirState {}

class TvOnAirLoaded extends ListTvOnAirState {
  final List<TvSeries> tvOnAir;

  const TvOnAirLoaded({required this.tvOnAir});

  @override
  List<Object> get props => [tvOnAir];
}

class TvOnAirError extends ListTvOnAirState {
  final String message;

  const TvOnAirError({required this.message});

  @override
  List<Object> get props => [message];
}
