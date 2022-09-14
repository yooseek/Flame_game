import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'friend_number_event.dart';
part 'friend_number_state.dart';

class FriendNumberBloc extends Bloc<FriendNumberEvent, FriendNumberState> {
  FriendNumberBloc() : super(FriendNumberState.initial()) {
    on<FindFriend>((event, emit) {
      emit(state.copyWith(findFriendNumber: state.findFriendNumber + 1,friendState: FriendState.find));
    });
  }
}
