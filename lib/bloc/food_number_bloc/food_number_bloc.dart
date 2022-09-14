import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:collection/collection.dart';

part 'food_number_event.dart';
part 'food_number_state.dart';

class FoodNumberBloc extends Bloc<FoodNumberEvent, FoodNumberState> {
  FoodNumberBloc() : super(FoodNumberState.initial()) {
    on<FindFood>(
      _findFoodEvent,
      // droppable - 앞선 이벤트 처리가 끝날 때 까지 뒤이어 온 이벤트 무시
      // restartable - 앞선 이벤트를 무시하고 뒤이온 온 이벤트 처리
      // concurrent - 개별적으로 진행 - default
      // sequential - 들어온 이벤트대로 순서대로 진행
      transformer: droppable(),
    );

    on<RemoveFood>(
      _removeFoodEvent,
      transformer: droppable(),
    );

    on<RemoveTotalFood>(
        _removeTotalFoodEvent,
      transformer: droppable(),
    );

    on<RemoveALLFood>((event,emit) {
      emit(state.copyWith(foodInventory: [],foodState: FoodState.init));
    });
  }

  Future<void> _findFoodEvent(event, emit) async {
    final selectFood = state.foodInventory
        .firstWhereOrNull((e) => e.foodCategory == event.foodCategory);

    if (selectFood == null) {
      emit(state.copyWith(foodInventory: [
        ...state.foodInventory,
        FoodInventory(foodCategory: event.foodCategory, count: 1)
      ], foodState: FoodState.normal));
    } else {
      final newSelectFood = selectFood.copyWith(count: selectFood.count + 1);
      final newState = state.foodInventory
          .map(
            (e) => e.foodCategory == event.foodCategory ? newSelectFood : e,
          )
          .toList();

      if (newState.length == FoodCategory.values.length) {
        emit(
            state.copyWith(foodInventory: newState, foodState: FoodState.full));
      } else {
        emit(state.copyWith(foodInventory: newState));
      }
    }
  }

  Future<void> _removeFoodEvent(event, emit) async {
    final selectFood = state.foodInventory
        .firstWhereOrNull((e) => e.foodCategory == event.foodCategory);

    final newSelectFood = selectFood!.copyWith(count: selectFood.count - 1);

    if (newSelectFood.count == 0) {
      final List<FoodInventory> tmpState = state.foodInventory;
      tmpState.removeWhere(
          (element) => element.foodCategory == newSelectFood.foodCategory);
      if (tmpState.isEmpty) {
        emit(state.copyWith(foodInventory: [], foodState: FoodState.empty));
      } else {
        emit(state.copyWith(foodInventory: tmpState));
      }
    } else {
      final newState = state.foodInventory
          .map(
            (e) => e.foodCategory == event.foodCategory ? newSelectFood : e,
          )
          .toList();

      emit(state.copyWith(foodInventory: newState));
    }
  }

  Future<void> _removeTotalFoodEvent(event, emit) async {
    if(state.foodState == FoodState.empty) {
      return;
    }

    final selectFood = state.foodInventory[0];

    final newSelectFood = selectFood.copyWith(count: selectFood.count - 1);

    if (newSelectFood.count == 0) {
      final List<FoodInventory> tmpState = state.foodInventory;
      tmpState.removeWhere(
              (element) => element.foodCategory == newSelectFood.foodCategory);
      if (tmpState.isEmpty) {
        emit(state.copyWith(foodInventory: [], foodState: FoodState.empty));
      } else {
        emit(state.copyWith(foodInventory: tmpState));
      }
    } else {
      final newState = state.foodInventory
          .map(
            (e) => e.foodCategory == event.foodCategory ? newSelectFood : e,
      )
          .toList();

      emit(state.copyWith(foodInventory: newState));
    }
  }
}
