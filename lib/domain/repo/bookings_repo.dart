import 'package:dio/dio.dart';

import '../../data/api_client/api_client.dart';
import '../../data/constant/api_constant.dart';

class BookingsRepo {
  final dio = ApiClient();

  // country request --
  Future<Response> fetchCategories() async {
    return await dio.get(ApiConstant.fechCategories);
  }

  // Organization List --
  Future<Response> fetchOrganizationList() async {
    return await dio.post(ApiConstant.fetchOrganizationList, body: {});
  }

  // Organization details --
  Future<Response> fetchOrganizationDetails({required String id}) async {
    return await dio.get("${ApiConstant.fetchOrganizationDetails}$id");
  }

  // slots --
  Future<Response> fetchSlots({required Map<String, dynamic> body}) async {
    return await dio.post(ApiConstant.fetchSlots, body: body);
  }

  // create booking --
  Future<Response> sendSlotBooking({required Map<String, dynamic> body}) async {
    return await dio.post(ApiConstant.sendSlotsBooking, body: body);
  }

  Future<Response> fetchSlotBookingsList() async {
    return await dio.post(ApiConstant.fetchSlotBookingsList);
  }

  // Future<Response> fetchSlotBookingsHistory({
  //   required String fromDate,
  //   required String toDate,
  // }) async {
  //   return await dio.get(
  //     "${ApiConstant.fetchSlotBookingHistory}?fromDate=$fromDate&toDate=$toDate",
  //   );
  // }
}
