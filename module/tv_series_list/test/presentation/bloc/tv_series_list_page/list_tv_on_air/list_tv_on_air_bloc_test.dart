import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tv_series_list/tv_series_list.dart';

import 'list_tv_on_air_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvOnAir,
])
void main() {
  late ListTvOnAirBloc listTvOnAirBloc;
  late MockGetTvOnAir mockGetTvOnAir;

  setUp(() {
    mockGetTvOnAir = MockGetTvOnAir();
    listTvOnAirBloc = ListTvOnAirBloc(getTvOnAir: mockGetTvOnAir);
  });

  final tTvSeriesList = testTvSeriesList;

  group('Fetch List Tv On Air', () {
    void arrangeUseCase() {
      when(mockGetTvOnAir.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
    }

    blocTest<ListTvOnAirBloc, ListTvOnAirState>(
      'should get data from the usecase',
      build: () {
        arrangeUseCase();
        return listTvOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchTvOnAir()),
      verify: (_) {
        verify(mockGetTvOnAir.execute());
      },
    );

    blocTest<ListTvOnAirBloc, ListTvOnAirState>(
      'should emit [Loading, Loaded] when data is fetched',
      build: () {
        arrangeUseCase();
        return listTvOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchTvOnAir()),
      expect: () => [
        TvOnAirLoading(),
        TvOnAirLoaded(tvOnAir: tTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetTvOnAir.execute());
      },
    );

    blocTest<ListTvOnAirBloc, ListTvOnAirState>(
      'should emit [Loading, Error] when data is fetched',
      build: () {
        when(mockGetTvOnAir.execute()).thenAnswer(
            (_) async => Left(ServerFailure('SERVER_FAILURE_MESSAGE')));
        return listTvOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchTvOnAir()),
      expect: () => [
        TvOnAirLoading(),
        TvOnAirError(message: 'SERVER_FAILURE_MESSAGE'),
      ],
      verify: (_) {
        verify(mockGetTvOnAir.execute());
      },
    );
  });
}
