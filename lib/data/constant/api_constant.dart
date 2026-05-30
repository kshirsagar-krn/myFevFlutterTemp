class ApiConstant {
  static const String _baseUrl = 'https://myFevTempV1.com/';
  // static const String _baseUrl =
  //     'https://tobago-jury-witch-html.trycloudflare.com/';
  static get baseUrl => _baseUrl;

  // login --
  static const String sendOtp = '/api/LoginAPI/CustomerSendOtp';
  static const String verifyOtp = '/api/LoginAPI/ValidateCustomerOtp';

  // Endpoints --
  static const String createSignUp = 'api/CustomerAPI/CustomerRegistration';
  static const String getLogout = 'api/account/logout';
  static const String fetchProfile = '/api/CustomerAPI/CustomerProfile';
  static const String deleteProfile = 'api/Account/DeleteUserAccount';

  static const String fetchBusinessSetting = 'api/Account/DeleteUserAccount';
  static const String fechDashBoard = 'api/Account/DeleteUserAccount';

  // dropdown --
  static const String fetchCountry =
      '/api/MasterAPI/dataList?Table=TBL_COUNTRYMASTER&Columns=COUNTRYID, COUNTRYNAME';
  static const String fetchState =
      'https://www.myFevTempV1.com/api/MasterAPI/dataList?Table=TBL_STATEMASTER&Columns=STATEID, STATENAME&WhereColumn=COUNTRYID&WhereValue='; // &WhereValue=
  static const String fetchCity =
      '/api/MasterAPI/dataList?Table=TBL_CITYMASTER&Columns=CITYID, CITYNAME&WhereColumn=STATEID&WhereValue=';
  static const String fetchGender =
      '/api/MasterAPI/dataList?Table=TBL_GENDERMASTER&Columns=GENDERID,GENDERNAME';

  // my booking --
  static const String fechCategories = '/api/MasterAPI/CategoryList';
  static const String fechMyBooking = 'api/Account/DeleteUserAccount';
  static const String fetchOrganizationList =
      '/api/CustomerAPI/OrganizationList';
  static const String fetchOrganizationDetails =
      '/api/CustomerAPI/getOrganizationById?OrganizationId=';

  // slot booking ------
  static const String fetchSlots = '/api/MasterAPI/TimeSlotList';
  static const String sendSlotsBooking = '/api/CustomerAPI/SlotBooking';
  static const String fetchSlotBookingsList =
      '/api/CustomerAPI/SlotBookingList';
  // static const String fetchSlotBookingHistory =
  //     '/api/ReportAPI/DownloadCustomerBookingHistory';

  // Timeouts --
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 60000;

  // Headers --
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const Map<String, String> multipartHeaders = {
    'Accept': 'application/json',
  };
}
