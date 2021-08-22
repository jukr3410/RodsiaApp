part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

class SearchLoadingState extends SearchState {
  final String message;

  const SearchLoadingState({required this.message});
}

class SearchSuccessState extends SearchState {
  final List<Garage> garages;
  final bool hasReachedMax;

  const SearchSuccessState(
      {required this.garages, required this.hasReachedMax});
  SearchSuccessState copyWith(
      {required List<Garage> garages, required bool hasReachedMax}) {
    return SearchSuccessState(garages: garages, hasReachedMax: hasReachedMax);
  }

  @override
  List<Object> get props => [garages, hasReachedMax];
}

class SearchErrorState extends SearchState {
  final String error;

  const SearchErrorState({required this.error});
}
