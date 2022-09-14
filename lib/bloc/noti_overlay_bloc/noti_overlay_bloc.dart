import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';

part 'noti_overlay_event.dart';
part 'noti_overlay_state.dart';

class NotiOverlayBloc extends Bloc<NotiOverlayEvent, NotiOverlayState> {
  NotiOverlayBloc() : super(NotiOverlayState.initial()) {
    on<StartNotiOverlay>(
      _startNotiOverlayEvent,
      transformer: droppable(),
    );
    on<EndNotiOverlay>(
      _endNotiOverlayEvent,
      transformer: droppable(),
    );
  }

  Future<void> _startNotiOverlayEvent(event, emit) async {
    emit(state.copyWith(message: event.message, showNoti: true));
  }

  Future<void> _endNotiOverlayEvent(event, emit) async {
    emit(state.copyWith(showNoti: false));
  }
}
