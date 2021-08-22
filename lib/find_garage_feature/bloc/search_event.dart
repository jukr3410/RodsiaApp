part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class SearchFetchEvent extends SearchEvent {
  final String garageName;
  const SearchFetchEvent({required this.garageName});
}
