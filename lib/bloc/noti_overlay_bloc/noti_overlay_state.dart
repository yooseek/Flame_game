part of 'noti_overlay_bloc.dart';

class NotiOverlayState {
  final bool showNoti;
  final String message;

  const NotiOverlayState({
    required this.showNoti,
    required this.message,
  });

  factory NotiOverlayState.initial() {
    return NotiOverlayState(showNoti: true, message: '안녕 내 이름은 조지! '
        '만나서 반가워! '
        '같이 친구를 찾아보자!');
  }

  NotiOverlayState copyWith({
    bool? showNoti,
    String? message,
  }) {
    return NotiOverlayState(
      showNoti: showNoti ?? this.showNoti,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [showNoti, message];
}