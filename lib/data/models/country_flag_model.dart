class CountryFlagModel {
  final String countryName;
  final String countryCode;
  final String flag;
  final int minDigit;
  final int maxDigit;
  final String eg;

  CountryFlagModel({
    required this.countryName,
    required this.countryCode,
    required this.flag,
    required this.minDigit,
    required this.maxDigit,
    required this.eg,
  });

  factory CountryFlagModel.fromJson(Map<String, dynamic> json) {
    return CountryFlagModel(
      countryName: json['country_name'],
      countryCode: json['country_code'],
      flag: json['flag'],
      minDigit: json['min_digit'],
      maxDigit: json['max_digit'],
      eg: json['eg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_name': countryName,
      'country_code': countryCode,
      'flag': flag,
      'min_digit': minDigit,
      'max_digit': maxDigit,
      'eg': eg,
    };
  }
}

class CountriesData {
  static const String jsonString = '''
{
  "countries": [
    {
      "country_name": "India",
      "country_code": "+91",
      "flag": "🇮🇳",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "United Kingdom",
      "country_code": "+44",
      "flag": "🇬🇧",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Australia",
      "country_code": "+61",
      "flag": "🇦🇺",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Canada",
      "country_code": "+1",
      "flag": "🇨🇦",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Germany",
      "country_code": "+49",
      "flag": "🇩🇪",
      "min_digit": 10,
      "max_digit": 11,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "France",
      "country_code": "+33",
      "flag": "🇫🇷",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Italy",
      "country_code": "+39",
      "flag": "🇮🇹",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Spain",
      "country_code": "+34",
      "flag": "🇪🇸",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Brazil",
      "country_code": "+55",
      "flag": "🇧🇷",
      "min_digit": 10,
      "max_digit": 11,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Mexico",
      "country_code": "+52",
      "flag": "🇲🇽",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Japan",
      "country_code": "+81",
      "flag": "🇯🇵",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "China",
      "country_code": "+86",
      "flag": "🇨🇳",
      "min_digit": 11,
      "max_digit": 11,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Russia",
      "country_code": "+7",
      "flag": "🇷🇺",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "South Africa",
      "country_code": "+27",
      "flag": "🇿🇦",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "United Arab Emirates",
      "country_code": "+971",
      "flag": "🇦🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Saudi Arabia",
      "country_code": "+966",
      "flag": "🇸🇦",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Singapore",
      "country_code": "+65",
      "flag": "🇸🇬",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Malaysia",
      "country_code": "+60",
      "flag": "🇲🇾",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Indonesia",
      "country_code": "+62",
      "flag": "🇮🇩",
      "min_digit": 10,
      "max_digit": 11,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Thailand",
      "country_code": "+66",
      "flag": "🇹🇭",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Vietnam",
      "country_code": "+84",
      "flag": "🇻🇳",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Philippines",
      "country_code": "+63",
      "flag": "🇵🇭",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Pakistan",
      "country_code": "+92",
      "flag": "🇵🇰",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Bangladesh",
      "country_code": "+880",
      "flag": "🇧🇩",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Sri Lanka",
      "country_code": "+94",
      "flag": "🇱🇰",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Nepal",
      "country_code": "+977",
      "flag": "🇳🇵",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "New Zealand",
      "country_code": "+64",
      "flag": "🇳🇿",
      "min_digit": 8,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Ireland",
      "country_code": "+353",
      "flag": "🇮🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Netherlands",
      "country_code": "+31",
      "flag": "🇳🇱",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Sweden",
      "country_code": "+46",
      "flag": "🇸🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Norway",
      "country_code": "+47",
      "flag": "🇳🇴",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Denmark",
      "country_code": "+45",
      "flag": "🇩🇰",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Finland",
      "country_code": "+358",
      "flag": "🇫🇮",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Poland",
      "country_code": "+48",
      "flag": "🇵🇱",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Turkey",
      "country_code": "+90",
      "flag": "🇹🇷",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Egypt",
      "country_code": "+20",
      "flag": "🇪🇬",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Nigeria",
      "country_code": "+234",
      "flag": "🇳🇬",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Kenya",
      "country_code": "+254",
      "flag": "🇰🇪",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Argentina",
      "country_code": "+54",
      "flag": "🇦🇷",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Chile",
      "country_code": "+56",
      "flag": "🇨🇱",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Colombia",
      "country_code": "+57",
      "flag": "🇨🇴",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Peru",
      "country_code": "+51",
      "flag": "🇵🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Venezuela",
      "country_code": "+58",
      "flag": "🇻🇪",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Israel",
      "country_code": "+972",
      "flag": "🇮🇱",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Qatar",
      "country_code": "+974",
      "flag": "🇶🇦",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Kuwait",
      "country_code": "+965",
      "flag": "🇰🇼",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Oman",
      "country_code": "+968",
      "flag": "🇴🇲",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Bahrain",
      "country_code": "+973",
      "flag": "🇧🇭",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Jordan",
      "country_code": "+962",
      "flag": "🇯🇴",
      "min_digit": 8,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Lebanon",
      "country_code": "+961",
      "flag": "🇱🇧",
      "min_digit": 7,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Afghanistan",
      "country_code": "+93",
      "flag": "🇦🇫",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Albania",
      "country_code": "+355",
      "flag": "🇦🇱",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Algeria",
      "country_code": "+213",
      "flag": "🇩🇿",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Angola",
      "country_code": "+244",
      "flag": "🇦🇴",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Armenia",
      "country_code": "+374",
      "flag": "🇦🇲",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Austria",
      "country_code": "+43",
      "flag": "🇦🇹",
      "min_digit": 10,
      "max_digit": 11,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Azerbaijan",
      "country_code": "+994",
      "flag": "🇦🇿",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Bahamas",
      "country_code": "+1242",
      "flag": "🇧🇸",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Belarus",
      "country_code": "+375",
      "flag": "🇧🇾",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Belgium",
      "country_code": "+32",
      "flag": "🇧🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Belize",
      "country_code": "+501",
      "flag": "🇧🇿",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Benin",
      "country_code": "+229",
      "flag": "🇧🇯",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Bhutan",
      "country_code": "+975",
      "flag": "🇧🇹",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Bolivia",
      "country_code": "+591",
      "flag": "🇧🇴",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Bosnia and Herzegovina",
      "country_code": "+387",
      "flag": "🇧🇦",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Botswana",
      "country_code": "+267",
      "flag": "🇧🇼",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Brunei",
      "country_code": "+673",
      "flag": "🇧🇳",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Bulgaria",
      "country_code": "+359",
      "flag": "🇧🇬",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Burkina Faso",
      "country_code": "+226",
      "flag": "🇧🇫",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Burundi",
      "country_code": "+257",
      "flag": "🇧🇮",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Cambodia",
      "country_code": "+855",
      "flag": "🇰🇭",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Cameroon",
      "country_code": "+237",
      "flag": "🇨🇲",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Cape Verde",
      "country_code": "+238",
      "flag": "🇨🇻",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Central African Republic",
      "country_code": "+236",
      "flag": "🇨🇫",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Chad",
      "country_code": "+235",
      "flag": "🇹🇩",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Comoros",
      "country_code": "+269",
      "flag": "🇰🇲",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Congo",
      "country_code": "+242",
      "flag": "🇨🇬",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Costa Rica",
      "country_code": "+506",
      "flag": "🇨🇷",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Croatia",
      "country_code": "+385",
      "flag": "🇭🇷",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Cuba",
      "country_code": "+53",
      "flag": "🇨🇺",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Cyprus",
      "country_code": "+357",
      "flag": "🇨🇾",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Czech Republic",
      "country_code": "+420",
      "flag": "🇨🇿",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Djibouti",
      "country_code": "+253",
      "flag": "🇩🇯",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Dominica",
      "country_code": "+1767",
      "flag": "🇩🇲",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Dominican Republic",
      "country_code": "+1849",
      "flag": "🇩🇴",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Ecuador",
      "country_code": "+593",
      "flag": "🇪🇨",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "El Salvador",
      "country_code": "+503",
      "flag": "🇸🇻",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Equatorial Guinea",
      "country_code": "+240",
      "flag": "🇬🇶",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Eritrea",
      "country_code": "+291",
      "flag": "🇪🇷",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Estonia",
      "country_code": "+372",
      "flag": "🇪🇪",
      "min_digit": 7,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Eswatini",
      "country_code": "+268",
      "flag": "🇸🇿",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Ethiopia",
      "country_code": "+251",
      "flag": "🇪🇹",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Fiji",
      "country_code": "+679",
      "flag": "🇫🇯",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Gabon",
      "country_code": "+241",
      "flag": "🇬🇦",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Gambia",
      "country_code": "+220",
      "flag": "🇬🇲",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Georgia",
      "country_code": "+995",
      "flag": "🇬🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Ghana",
      "country_code": "+233",
      "flag": "🇬🇭",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Greece",
      "country_code": "+30",
      "flag": "🇬🇷",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Grenada",
      "country_code": "+1473",
      "flag": "🇬🇩",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Guatemala",
      "country_code": "+502",
      "flag": "🇬🇹",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Guinea",
      "country_code": "+224",
      "flag": "🇬🇳",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Guinea-Bissau",
      "country_code": "+245",
      "flag": "🇬🇼",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Guyana",
      "country_code": "+592",
      "flag": "🇬🇾",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Haiti",
      "country_code": "+509",
      "flag": "🇭🇹",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Honduras",
      "country_code": "+504",
      "flag": "🇭🇳",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Hungary",
      "country_code": "+36",
      "flag": "🇭🇺",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Iceland",
      "country_code": "+354",
      "flag": "🇮🇸",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Iran",
      "country_code": "+98",
      "flag": "🇮🇷",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Iraq",
      "country_code": "+964",
      "flag": "🇮🇶",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Jamaica",
      "country_code": "+1876",
      "flag": "🇯🇲",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Kazakhstan",
      "country_code": "+7",
      "flag": "🇰🇿",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Kiribati",
      "country_code": "+686",
      "flag": "🇰🇮",
      "min_digit": 5,
      "max_digit": 5,
      "eg": "Eg. 98765"
    },
    {
      "country_name": "Korea, North",
      "country_code": "+850",
      "flag": "🇰🇵",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Korea, South",
      "country_code": "+82",
      "flag": "🇰🇷",
      "min_digit": 10,
      "max_digit": 11,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Kosovo",
      "country_code": "+383",
      "flag": "🇽🇰",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Kyrgyzstan",
      "country_code": "+996",
      "flag": "🇰🇬",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Laos",
      "country_code": "+856",
      "flag": "🇱🇦",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Latvia",
      "country_code": "+371",
      "flag": "🇱🇻",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Lesotho",
      "country_code": "+266",
      "flag": "🇱🇸",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Liberia",
      "country_code": "+231",
      "flag": "🇱🇷",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Libya",
      "country_code": "+218",
      "flag": "🇱🇾",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Liechtenstein",
      "country_code": "+423",
      "flag": "🇱🇮",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Lithuania",
      "country_code": "+370",
      "flag": "🇱🇹",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Luxembourg",
      "country_code": "+352",
      "flag": "🇱🇺",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Madagascar",
      "country_code": "+261",
      "flag": "🇲🇬",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Malawi",
      "country_code": "+265",
      "flag": "🇲🇼",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Maldives",
      "country_code": "+960",
      "flag": "🇲🇻",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Mali",
      "country_code": "+223",
      "flag": "🇲🇱",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Malta",
      "country_code": "+356",
      "flag": "🇲🇹",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Marshall Islands",
      "country_code": "+692",
      "flag": "🇲🇭",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Mauritania",
      "country_code": "+222",
      "flag": "🇲🇷",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Mauritius",
      "country_code": "+230",
      "flag": "🇲🇺",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Micronesia",
      "country_code": "+691",
      "flag": "🇫🇲",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Moldova",
      "country_code": "+373",
      "flag": "🇲🇩",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Monaco",
      "country_code": "+377",
      "flag": "🇲🇨",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Mongolia",
      "country_code": "+976",
      "flag": "🇲🇳",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Montenegro",
      "country_code": "+382",
      "flag": "🇲🇪",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Morocco",
      "country_code": "+212",
      "flag": "🇲🇦",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Mozambique",
      "country_code": "+258",
      "flag": "🇲🇿",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Myanmar",
      "country_code": "+95",
      "flag": "🇲🇲",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Namibia",
      "country_code": "+264",
      "flag": "🇳🇦",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Nauru",
      "country_code": "+674",
      "flag": "🇳🇷",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Nicaragua",
      "country_code": "+505",
      "flag": "🇳🇮",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Niger",
      "country_code": "+227",
      "flag": "🇳🇪",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "North Macedonia",
      "country_code": "+389",
      "flag": "🇲🇰",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Palau",
      "country_code": "+680",
      "flag": "🇵🇼",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Panama",
      "country_code": "+507",
      "flag": "🇵🇦",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Papua New Guinea",
      "country_code": "+675",
      "flag": "🇵🇬",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Paraguay",
      "country_code": "+595",
      "flag": "🇵🇾",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Portugal",
      "country_code": "+351",
      "flag": "🇵🇹",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Romania",
      "country_code": "+40",
      "flag": "🇷🇴",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Rwanda",
      "country_code": "+250",
      "flag": "🇷🇼",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Saint Kitts and Nevis",
      "country_code": "+1869",
      "flag": "🇰🇳",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Saint Lucia",
      "country_code": "+1758",
      "flag": "🇱🇨",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Saint Vincent and the Grenadines",
      "country_code": "+1784",
      "flag": "🇻🇨",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Samoa",
      "country_code": "+685",
      "flag": "🇼🇸",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "San Marino",
      "country_code": "+378",
      "flag": "🇸🇲",
      "min_digit": 6,
      "max_digit": 6,
      "eg": "Eg. 987654"
    },
    {
      "country_name": "Sao Tome and Principe",
      "country_code": "+239",
      "flag": "🇸🇹",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Senegal",
      "country_code": "+221",
      "flag": "🇸🇳",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Serbia",
      "country_code": "+381",
      "flag": "🇷🇸",
      "min_digit": 8,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Seychelles",
      "country_code": "+248",
      "flag": "🇸🇨",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Sierra Leone",
      "country_code": "+232",
      "flag": "🇸🇱",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Slovakia",
      "country_code": "+421",
      "flag": "🇸🇰",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Slovenia",
      "country_code": "+386",
      "flag": "🇸🇮",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Solomon Islands",
      "country_code": "+677",
      "flag": "🇸🇧",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Somalia",
      "country_code": "+252",
      "flag": "🇸🇴",
      "min_digit": 7,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Sudan",
      "country_code": "+249",
      "flag": "🇸🇩",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Suriname",
      "country_code": "+597",
      "flag": "🇸🇷",
      "min_digit": 6,
      "max_digit": 6,
      "eg": "Eg. 987654"
    },
    {
      "country_name": "Switzerland",
      "country_code": "+41",
      "flag": "🇨🇭",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Syria",
      "country_code": "+963",
      "flag": "🇸🇾",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Taiwan",
      "country_code": "+886",
      "flag": "🇹🇼",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Tajikistan",
      "country_code": "+992",
      "flag": "🇹🇯",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Tanzania",
      "country_code": "+255",
      "flag": "🇹🇿",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Timor-Leste",
      "country_code": "+670",
      "flag": "🇹🇱",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Togo",
      "country_code": "+228",
      "flag": "🇹🇬",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Tonga",
      "country_code": "+676",
      "flag": "🇹🇴",
      "min_digit": 5,
      "max_digit": 5,
      "eg": "Eg. 98765"
    },
    {
      "country_name": "Trinidad and Tobago",
      "country_code": "+1868",
      "flag": "🇹🇹",
      "min_digit": 10,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Tunisia",
      "country_code": "+216",
      "flag": "🇹🇳",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Turkmenistan",
      "country_code": "+993",
      "flag": "🇹🇲",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Tuvalu",
      "country_code": "+688",
      "flag": "🇹🇻",
      "min_digit": 5,
      "max_digit": 5,
      "eg": "Eg. 98765"
    },
    {
      "country_name": "Uganda",
      "country_code": "+256",
      "flag": "🇺🇬",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Ukraine",
      "country_code": "+380",
      "flag": "🇺🇦",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Uruguay",
      "country_code": "+598",
      "flag": "🇺🇾",
      "min_digit": 8,
      "max_digit": 8,
      "eg": "Eg. 98765432"
    },
    {
      "country_name": "Uzbekistan",
      "country_code": "+998",
      "flag": "🇺🇿",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Vanuatu",
      "country_code": "+678",
      "flag": "🇻🇺",
      "min_digit": 7,
      "max_digit": 7,
      "eg": "Eg. 9876543"
    },
    {
      "country_name": "Vatican City",
      "country_code": "+379",
      "flag": "🇻🇦",
      "min_digit": 6,
      "max_digit": 6,
      "eg": "Eg. 987654"
    },
    {
      "country_name": "Vietnam",
      "country_code": "+84",
      "flag": "🇻🇳",
      "min_digit": 9,
      "max_digit": 10,
      "eg": "Eg. 9876543210"
    },
    {
      "country_name": "Yemen",
      "country_code": "+967",
      "flag": "🇾🇪",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Zambia",
      "country_code": "+260",
      "flag": "🇿🇲",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    },
    {
      "country_name": "Zimbabwe",
      "country_code": "+263",
      "flag": "🇿🇼",
      "min_digit": 9,
      "max_digit": 9,
      "eg": "Eg. 987654321"
    }
  ]
}
''';
}
