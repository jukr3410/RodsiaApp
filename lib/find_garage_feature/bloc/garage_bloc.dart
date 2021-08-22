import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';

part 'garage_event.dart';
part 'garage_state.dart';

class GarageListBloc extends Bloc<GarageListEvent, GarageListState> {
  final GarageRepository garagerRepository;
  int page = 1;

  GarageListBloc({required this.garagerRepository})
      : super(GarageListInitialState());

  @override
  GarageListState get initialState => GarageListInitialState();

  @override
  Stream<GarageListState> mapEventToState(
    GarageListEvent event,
  ) async* {
    final currentState = state;
    if (event is GarageListFetchEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is GarageListInitialState) {
          yield GarageListLoadingState(message: mLoading);
          final garages = await garagerRepository.getGarages(page: page);
          yield GarageListSuccessState(garages: garages, hasReachedMax: false);
          return;
        }
        if (currentState is GarageListSuccessState) {
          final garages = await garagerRepository.getGarages(page: ++page);
          yield garages.isEmpty
              ? currentState.copyWith(garages: [], hasReachedMax: true)
              : GarageListSuccessState(garages: garages, hasReachedMax: false);
        }
      } catch (e) {
        print(e);
        yield GarageListErrorState(error: mError);
      }
    }
  }

  bool _hasReachedMax(GarageListState state) =>
      state is GarageListSuccessState && state.hasReachedMax;
}
