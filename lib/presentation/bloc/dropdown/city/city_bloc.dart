import 'dart:convert';
import '../../../../data/api_client/api_exception.dart';
import 'package:bloc/bloc.dart';
import '../../../../data/models/city_model.dart';
import '../../../../domain/repo/dropdown_repo.dart';
import 'city_event.dart';
import 'city_state.dart';

class CitysBloc extends Bloc<CityEvent, CitysState> {
  final DropdownRepo dropdownRepo;

  CitysBloc(this.dropdownRepo) : super(CityInitial()) {
    on<FetchCitys>(_onfetchState);
  }

  List<CityModel> cities = <CityModel>[];
  Future<void> _onfetchState(FetchCitys event, Emitter<CitysState> emit) async {
    emit(CityLoading());

    try {
      var response = await dropdownRepo.fetchCity(stateId: event.id);
      List<dynamic> data = response.data['Data'];
      cities = cityModelFromJson(jsonEncode(data));
      emit(CitySuccess(cityModel: cities));
    } on ApiException catch (error) {
      emit(CityFailure(error.message));
    }
  }
}
