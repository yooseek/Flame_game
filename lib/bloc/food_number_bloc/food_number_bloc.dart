import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testtesttest/model/food_inventory_model.dart';
import 'package:collection/collection.dart';

part 'food_number_event.dart';
part 'food_number_state.dart';

class FoodNumberBloc extends Bloc<FoodNumberEvent, FoodNumberState> {
  FoodNumberBloc() : super(FoodNumberState.initial()) {
    on<FindFood>((event, emit) {
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

        if(newState.length == FoodCategory.values.length) {
          emit(state.copyWith(foodInventory: newState,foodState: FoodState.full));
        }else{
          emit(state.copyWith(foodInventory: newState));
        }
      }
    });

    on<RemoveFood>((event, emit) {
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
    });
  }
}
