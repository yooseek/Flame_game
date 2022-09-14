import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flame/components.dart';
import 'package:meta/meta.dart';

part 'george_position_event.dart';
part 'george_position_state.dart';

class GeorgePositionBloc
    extends Bloc<GeorgePositionEvent, GeorgePositionState> {
  GeorgePositionBloc() : super(GeorgePositionState.initial()) {
    on<ChangeGeorgePosition>(
      _changeGeorgePositionEvent,
      transformer: droppable(),
    );
  }

  Future<void> _changeGeorgePositionEvent(event, emit) async {
    await Future.delayed(
      const Duration(seconds: 3),
      emit(state.copyWith(position: event.position)),
    );
  }
}
