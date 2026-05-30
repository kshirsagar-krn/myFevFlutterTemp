import 'package:dio/dio.dart';
import '../../data/api_client/api_client.dart';
import '../../data/constant/api_constant.dart';

class DropdownRepo {
  final dio = ApiClient();

  // country request --
  Future<Response> fetchCountry() async {
    return await dio.get(ApiConstant.fetchCountry);
  }

  // state request --
  Future<Response> fetchState({String? countryId}) async {
    return await dio.get("${ApiConstant.fetchState}$countryId");
  }

  // city request --
  Future<Response> fetchCity({String? stateId}) async {
    return await dio.get("${ApiConstant.fetchCity}$stateId");
  }

  // gender request --
  Future<Response> fetchGender() async {
    return await dio.get(ApiConstant.fetchGender);
  }

  // product items sub cat --
  // Future<Response> fetchSubCategories() async {
  //   return await dio.get(
  //     "${ApiConstant.fetchSubCategories}${ApiConstant.restaurantId}",
  //   );
  // }

  // Future<Response> fetchItemUnit() async {
  //   return await dio.get(ApiConstant.fetchProductUnits);
  // }
}
