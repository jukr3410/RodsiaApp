import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/repository/garage_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GarageRepository garageRepository;
  int page = 1;

  SearchBloc({required this.garageRepository}) : super(SearchInitialState());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchFetchEvent) {
      try {
        final garages = await garageRepository.getByGaragesName(
            page: page, name: event.garageName);
        print(garages);
        yield SearchSuccessState(garages: garages, hasReachedMax: false);
      } catch (e) {
        print(e);
        yield SearchErrorState(error: mNotFound);
      }
    }
  }
}
