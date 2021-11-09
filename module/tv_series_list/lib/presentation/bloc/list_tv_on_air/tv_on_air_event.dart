part of 'tv_on_air_bloc.dart';

abstract class ListTvOnAirEvent extends Equatable {
  const ListTvOnAirEvent();

  @override
  List<Object> get props => [];
}

class FetchTvOnAir extends ListTvOnAirEvent {}
