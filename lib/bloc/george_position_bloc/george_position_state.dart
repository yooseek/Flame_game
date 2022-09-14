part of 'george_position_bloc.dart';

class GeorgePositionState {
  final Vector2 position;

  const GeorgePositionState({
    required this.position,
  });

  factory GeorgePositionState.initial() {
    return GeorgePositionState(position: Vector2(529, 128));
  }

  @override
  List<Object> get props => [position];

  GeorgePositionState copyWith({
    Vector2? position,
  }) {
    return GeorgePositionState(
      position: position ?? this.position,
    );
  }
}
