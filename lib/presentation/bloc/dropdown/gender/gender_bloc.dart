import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../data/api_client/api_exception.dart';
import '../../../../data/models/gender_model.dart';
import '../../../../domain/repo/dropdown_repo.dart';
part 'gender_event.dart';
part 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvent, GenderState> {
  final DropdownRepo dropdownRepo;
  GenderBloc(this.dropdownRepo) : super(GenderInitial()) {
    on<GetGender>(_onFetchGenderList);
  }

  List<GenderModel> countries = <GenderModel>[];
  Future<void> _onFetchGenderList(
    GetGender event,
    Emitter<GenderState> emit,
  ) async {
    emit(GenderLoading());
    try {
      var response = await dropdownRepo.fetchGender();
      List<dynamic> data = response.data['Data'];
      countries = genderModelFromJson(jsonEncode(data));
      emit(GenderSuccess(genderModel: countries));
    } on ApiException catch (error) {
      emit(GenderFaild(errorMessage: error.message));
    }
  }
}
