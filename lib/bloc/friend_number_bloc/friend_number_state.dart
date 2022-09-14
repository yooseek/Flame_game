part of 'friend_number_bloc.dart';

enum FriendState {
  init,
  find,
  notFind,
}

class FriendNumberState {
  final int findFriendNumber;
  final FriendState friendState;

  const FriendNumberState({
    required this.findFriendNumber,
    required this.friendState,
  });

  factory FriendNumberState.initial() {
    return const FriendNumberState(
        findFriendNumber: 0, friendState: FriendState.init);
  }

  @override
  List<Object> get props => [findFriendNumber, friendState];

  FriendNumberState copyWith({
    int? findFriendNumber,
    FriendState? friendState,
  }) {
    return FriendNumberState(
      findFriendNumber: findFriendNumber ?? this.findFriendNumber,
      friendState: friendState ?? this.friendState,
    );
  }
}