import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';
import 'package:rodsiaapp/main.dart';

part 'garage_event.dart';
part 'garage_state.dart';

class GarageListBloc extends Bloc<GarageListEvent, GarageListState> {
  final GarageRepository garagerRepository;
  int page = 1;

  bool isFetching = false;

  GarageListBloc({required this.garagerRepository})
      : super(GarageListInitialState());

  @override
  Stream<GarageListState> mapEventToState(
    GarageListEvent event,
  ) async* {
    if (event is GarageListFetchEvent) {
      try {
        yield GarageListLoadingState(message: mLoading);
        final garages = await garagerRepository.getGarages(page: page);
        if (garages.isNotEmpty) {
          yield GarageListSuccessState(garages: garages);
          page++;
        } else {
          yield GarageListEmptyState();
        }
      } catch (e) {
        logger.e(e);
        yield GarageListErrorState(error: mError);
      }
    }
  }
}
