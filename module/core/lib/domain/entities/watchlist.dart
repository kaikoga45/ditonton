import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  Watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.label,
    required this.type,
  });

  final int id;
  final String? overview;
  final String posterPath;
  final String label;
  final String type;

  @override
  List<Object?> get props => [
        id,
        overview,
        posterPath,
        label,
        type,
      ];
}
