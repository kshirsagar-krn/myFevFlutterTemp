import 'dart:convert';
import '../../../../data/api_client/api_exception.dart';
import 'package:bloc/bloc.dart';
import '../../../../data/models/country_model.dart';
import '../../../../domain/repo/dropdown_repo.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final DropdownRepo dropdownRepo;

  CountryBloc(this.dropdownRepo) : super(CountryInitial()) {
    on<FetchCountry>(_onFetchCountry);
  }

  List<CountryModel> countries = <CountryModel>[];
  Future<void> _onFetchCountry(
    FetchCountry event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());

    try {
      var response = await dropdownRepo.fetchCountry();
      List<dynamic> data = response.data['Data'];
      countries = countryModelFromJson(jsonEncode(data));
      emit(CountrySuccess(countryModel: countries));
    } on ApiException catch (error) {
      emit(CountryFailure(error.message));
    }
  }
}
