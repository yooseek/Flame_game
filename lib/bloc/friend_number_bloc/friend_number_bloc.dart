import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'friend_number_event.dart';
part 'friend_number_state.dart';

class FriendNumberBloc extends Bloc<FriendNumberEvent, FriendNumberState> {
  FriendNumberBloc() : super(FriendNumberState.initial()) {
    on<FindFriend>(
      _findFriendEvent,
      transformer: droppable(),
    );

    on<ResetFriend>((event, emit){
      emit(state.copyWith(friendState: FriendState.init,findFriendNumber: 0,maxFriendNumber: []));
    });

    on<AddFriend>((event, emit){
      if(state.maxFriendNumber.firstWhereOrNull((e) => e == event.id) == null) {
        emit(state.copyWith(maxFriendNumber: [...state.maxFriendNumber,event.id]));
      }
    });

  }

  Future<void> _findFriendEvent(event, emit) async {
    emit(state.copyWith(
        findFriendNumber: state.findFriendNumber + 1,
        friendState: FriendState.find));
  }
}
