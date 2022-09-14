part of 'friend_number_bloc.dart';

enum FriendState {
  init,
  find,
  notFind,
}

class FriendNumberState {
  final int findFriendNumber;
  final List<int> maxFriendNumber;
  final FriendState friendState;

  const FriendNumberState({
    required this.findFriendNumber,
    required this.friendState,
    required this.maxFriendNumber,
  });

  factory FriendNumberState.initial() {
    return const FriendNumberState(
        findFriendNumber: 0, friendState: FriendState.init,maxFriendNumber: []);
  }

  @override
  List<Object> get props => [findFriendNumber, friendState];

  FriendNumberState copyWith({
    int? findFriendNumber,
    List<int>? maxFriendNumber,
    FriendState? friendState,
  }) {
    return FriendNumberState(
      findFriendNumber: findFriendNumber ?? this.findFriendNumber,
      maxFriendNumber: maxFriendNumber ?? this.maxFriendNumber,
      friendState: friendState ?? this.friendState,
    );
  }
}