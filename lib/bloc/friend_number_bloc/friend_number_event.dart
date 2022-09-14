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

class ResetFriend extends FriendNumberEvent {
  ResetFriend();

  @override
  List<Object?> get props => [];

  ResetFriend copyWith() {
    return ResetFriend();
  }
}

class AddFriend extends FriendNumberEvent {
  final int id;
  AddFriend({required this.id});

  @override
  List<Object?> get props => [];

  AddFriend copyWith({
    int? id,
  }) {
    return AddFriend(
      id: id ?? this.id,
    );
  }
}