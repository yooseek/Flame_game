part of 'george_position_bloc.dart';

@immutable
abstract class GeorgePositionEvent {
  const GeorgePositionEvent();
}

class ChangeGeorgePosition extends GeorgePositionEvent {
  final Vector2 position;

  const ChangeGeorgePosition({
    required this.position,
  });

  @override
  List<Object> get props => [position];

  ChangeGeorgePosition copyWith({
    Vector2? position,
  }) {
    return ChangeGeorgePosition(
      position: position ?? this.position,
    );
  }
}