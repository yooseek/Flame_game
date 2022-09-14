part of 'noti_overlay_bloc.dart';

@immutable
abstract class NotiOverlayEvent {
  const NotiOverlayEvent();
}

class StartNotiOverlay extends NotiOverlayEvent {
  final String message;

  const StartNotiOverlay({
    required this.message,
  });
}

class EndNotiOverlay extends NotiOverlayEvent {
  const EndNotiOverlay();
}