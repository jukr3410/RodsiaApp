import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'garage_info_event.dart';
part 'garage_info_state.dart';

class GarageInfoBloc extends Bloc<GarageInfoEvent, GarageInfoState> {
  GarageInfoBloc() : super(GarageInfoInitial());

  @override
  Stream<GarageInfoState> mapEventToState(
    GarageInfoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
