part of 'friend_number_bloc.dart';

@immutable
abstract class FriendNumberEvent {
  const FriendNumberEvent();
}

class FindFriend extends FriendNumberEvent {
  FindFriend();

  @override
  List<Object?> get props => [];

  FindFriend copyWith() {
    return FindFriend();
  }
}