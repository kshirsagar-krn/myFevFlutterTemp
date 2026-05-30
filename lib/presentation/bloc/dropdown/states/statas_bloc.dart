import 'dart:convert';
import '../../../../data/api_client/api_exception.dart';
import 'package:bloc/bloc.dart';
import '../../../../data/models/state_model.dart';
import '../../../../domain/repo/dropdown_repo.dart';
import 'states_event.dart';
import 'states_state.dart';

class StatesBloc extends Bloc<StatesEvent, StatesState> {
  final DropdownRepo dropdownRepo;

  StatesBloc(this.dropdownRepo) : super(StatesInitial()) {
    on<FetchState>(_onfetchState);
  }

  List<StateModel> states = <StateModel>[];
  Future<void> _onfetchState(
    FetchState event,
    Emitter<StatesState> emit,
  ) async {
    emit(StatesLoading());

    try {
      var response = await dropdownRepo.fetchState(countryId: event.id);
      List<dynamic> data = response.data['Data'];
      states = stateModelFromJson(jsonEncode(data));
      emit(StateSuccess(stateModel: states));
    } on ApiException catch (error) {
      emit(StatesFailure(error.message));
    }
  }
}
