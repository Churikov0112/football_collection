import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';

class FootballNationalTeamModel extends Equatable {
  final String id;
  final String name;
  final FootballConfederations confederation;

  const FootballNationalTeamModel({required this.id, required this.name, required this.confederation});

  factory FootballNationalTeamModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballNationalTeamModel(
      id: json['id'],
      name: json['name'],
      confederation: footballConfederationFromCountryName(json['name']),
    );
  }

  @override
  List<Object?> get props => [id];
}

String? emojiFlagByCountryName(String? countryName) {
  // Определяем конфедерацию на основе названия страны
  switch (countryName) {
    // UEFA (Европа)
    case 'England':
      return '🏴󠁧󠁢󠁥󠁮󠁧󠁿';
    case 'France':
      return '🇫🇷';
    case 'Spain':
      return '🇪🇸';
    case 'Portugal':
      return '🇵🇹';
    case 'Netherlands':
      return '🇳🇱';
    case 'Italy':
      return '🇮🇹';
    case 'Germany':
      return '🇩🇪';
    case 'Belgium':
      return '🇧🇪';
    case 'Norway':
      return '🇳🇴';
    case 'Denmark':
      return '🇩🇰';
    case 'Sweden':
      return '🇸🇪';
    case 'Ukraine':
      return '🇺🇦';
    case 'Croatia':
      return '🇭🇷';
    case 'Switzerland':
      return '🇨🇭';
    case 'Austria':
      return '🇦🇹';
    case 'Poland':
      return '🇵🇱';
    case 'Czech Republic':
    case 'Czechia':
      return '🇨🇿';
    case 'Serbia':
      return '🇷🇸';
    case 'Greece':
      return '🇬🇷';
    case 'Scotland':
      return '🏴󠁧󠁢󠁳󠁣󠁴󠁿';
    case 'Wales':
      return '🏴󠁧󠁢󠁷󠁬󠁳󠁿';
    case 'Hungary':
      return '🇭🇺';
    case 'Slovenia':
      return '🇸🇮';
    case 'Slovakia':
      return '🇸🇰';
    case 'Russia':
      return '🇷🇺';
    case 'Turkey':
      return '🇹🇷';
    case 'Turkiye':
      return '🇹🇷';
    case 'Romania':
      return '🇷🇴';
    case 'Iceland':
      return '🇮🇸';
    case 'Bulgaria':
      return '🇧🇬';
    case 'Armenia':
      return '🇦🇲';
    case 'Belarus':
      return '🇧🇾';
    case 'Andorra':
      return '🇦🇩';
    case 'Gibraltar':
      return '🇬🇮';
    case 'Liechtenstein':
      return '🇱🇮';
    case 'San Marino':
      return '🇸🇲';
    case 'Faroe Islands':
      return '🇫🇴';
    case 'Finland':
      return '🇫🇮';
    case 'Republic of Ireland':
      return '🇮🇪';
    case 'Northern Ireland':
      return '🇯🇪';
    case 'Georgia':
      return '🇬🇪';
    case 'Albania':
      return '🇦🇱';
    case 'Bosnia-Herzegovina':
      return '🇧🇦';
    case 'Montenegro':
      return '🇲🇪';
    case 'Luxembourg':
      return '🇱🇺';
    case 'Cyprus':
      return '🇨🇾';
    case 'Estonia':
      return '🇪🇪';
    case 'Latvia':
      return '🇱🇻';
    case 'Lithuania':
      return '🇱🇹';
    case 'Malta':
      return '🇲🇹';
    case 'Moldova':
      return '🇲🇩';
    case 'North Macedonia':
      return '🇲🇰';
    case 'Kosovo':
      return '🇽🇰';

    // CONMEBOL (Южная Америка)
    case 'Argentina':
      return '🇦🇷';
    case 'Brazil':
      return '🇧🇷';
    case 'Uruguay':
      return '🇺🇾';
    case 'Colombia':
      return '🇨🇴';
    case 'Chile':
      return '🇨🇱';
    case 'Paraguay':
      return '🇵🇾';
    case 'Peru':
      return '🇵🇪';
    case 'Ecuador':
      return '🇪🇨';
    case 'Bolivia':
      return '🇧🇴';
    case 'Venezuela':
      return '🇻🇪';

    // CAF (Африка)
    case 'Nigeria':
      return '🇳🇬';
    case 'Senegal':
      return '🇸🇳';
    case 'Cameroon':
      return '🇨🇲';
    case 'Morocco':
      return '🇲🇦';
    case 'Ivory Coast':
    case "Cote d'Ivoire":
      return '🇨🇮';
    case 'Ghana':
      return '🇬🇭';
    case 'Algeria':
      return '🇩🇿';
    case 'Tunisia':
      return '🇹🇳';
    case 'Egypt':
      return '🇪🇬';
    case 'Mali':
      return '🇲🇱';
    case 'Burkina Faso':
      return '🇧🇫';
    case 'Democratic Republic of the Congo':
    case 'DR Congo':
      return '🇨🇩';
    case 'Guinea':
      return '🇬🇳';
    case 'South Africa':
      return '🇿🇦';
    case 'Zambia':
      return '🇿🇲';
    case 'Cape Verde':
      return '🇨🇻';
    case 'Gabon':
      return '🇬🇦';
    case 'Uganda':
      return '🇺🇬';
    case 'Madagascar':
      return '🇲🇬';
    case 'Angola':
      return '🇨🇬';
    case 'Benin':
      return '🇧🇯';
    case 'Mauritania':
      return '🇲🇷';
    case 'Niger':
      return '🇳🇪';
    case 'Tanzania':
      return '🇹🇿';
    case 'Zimbabwe':
      return '🇿🇼';
    case 'Comoros':
      return '🇰🇲';
    case 'Guinea-Bissau':
      return '🇬🇼';
    case 'Malawi':
      return '🇲🇼';
    case 'Mozambique':
      return '🇲🇿';
    case 'The Gambia':
      return '🇬🇲';
    case 'Botswana':
      return '🇧🇼';
    case 'Kenya':
      return '🇰🇪';
    case 'Republic of the Congo':
    case 'Congo':
      return '🇨🇬';
    case 'Guyana':
      return '🇬🇾';
    case 'Namibia':
      return '🇳🇦';
    case 'Boswana':
      return '🇧🇼';
    case 'Mauritius':
      return '🇲🇺';
    case 'São Tomé and Príncipe':
      return '🇸🇹';
    case 'Chad':
      return '🇹🇨';
    case 'Mayotte':
      return '🇾🇹';
    case 'Togo':
      return '🇹🇬';
    case 'Sierra Leone':
      return '🇸🇱';
    case 'Burundi':
      return '🇧🇮';
    case 'Central African Republic':
      return '🇨🇫';
    case 'Djibouti':
      return '🇩🇯';
    case 'Equatorial Guinea':
      return '🇬🇶';
    case 'Eswatini':
      return '🇸🇿';
    case 'Ethiopia':
      return '🇪🇹';
    case 'Gambia':
      return '🇬🇲';
    case 'Lesotho':
      return '🇱🇰';
    case 'Liberia':
      return '🇱🇷';
    case 'Libya':
      return '🇱🇾';
    case 'Rwanda':
      return '🇷🇼';
    case 'Sao Tome and Principe':
      return '🇸🇹';
    case 'Seychelles':
      return '🇸🇨';
    case 'Somalia':
      return '🇸🇴';
    case 'Sudan':
      return '🇸🇩';
    case 'South Sudan':
      return '🇸🇸';

    // AFC (Азия)
    case 'Japan':
      return '🇯🇵';
    case 'South Korea':
      return '🇰🇷';
    case 'Iran':
      return '🇮🇷';
    case 'Saudi Arabia':
      return '🇸🇦';
    case 'Australia':
      return '🇦🇺';
    case 'United Arab Emirates':
      return '🇦🇪';
    case 'China':
      return '🇨🇳';
    case 'Iraq':
      return '🇮🇶';
    case 'Qatar':
      return '🇶🇦';
    case 'Uzbekistan':
      return '🇺🇿';
    case 'Syria':
      return '🇸🇾';
    case 'Jordan':
      return '🇯🇴';
    case 'Vietnam':
      return '🇻🇳';
    case 'Oman':
      return '🇴🇲';
    case 'Kuwait':
      return '🇰🇼';
    case 'Bahrain':
      return '🇧🇭';
    case 'Israel':
      return '🇮🇱';
    case 'Azerbaijan':
      return '🇦🇿';
    case 'Kazakhstan':
      return '🇰🇿';
    case 'Brunei Darussalam':
      return '🇧🇳';
    case 'Thailand':
      return '🇹🇭';
    case 'North Korea':
      return '🇰🇵';
    case 'India':
      return '🇮🇳';
    case 'Palestine':
      return '🇵🇸';
    case 'Philippines':
      return '🇵🇭';
    case 'Tajikistan':
      return '🇹🇯';
    case 'Kyrgyzstan':
      return '🇰🇬';
    case 'Lebanon':
      return '🇱🇧';
    case 'Malaysia':
      return '🇲🇾';
    case 'Singapore':
      return '🇸🇬';
    case 'Yemen':
      return '🇾🇪';
    case 'Afghanistan':
      return '🇦🇫';
    case 'Bangladesh':
      return '🇧🇩';
    case 'Bhutan':
      return '🇧🇹';
    case 'Brunei':
      return '🇧🇳';
    case 'Cambodia':
      return '🇰🇭';
    case 'Hong Kong':
    case 'Hongkong':
      return '🇭🇰';
    case 'Indonesia':
      return '🇮🇩';
    case 'Laos':
      return '🇱🇦';
    case 'Macau':
      return '🇲🇴';
    case 'Maldives':
      return '🇲🇻';
    case 'Mongolia':
      return '🇲🇳';
    case 'Myanmar':
      return '🇲🇲';
    case 'Nepal':
      return '🇳🇵';
    case 'Pakistan':
      return '🇵🇰';
    case 'Sri Lanka':
      return '🇱🇰';
    case 'Chinese Taipei':
      return '🇹🇼';
    case 'Timor-Leste':
      return '🇹🇱';
    case 'Turkmenistan':
      return '🇹🇲';

    // CONCACAF (Северная и Центральная Америка, Карибы)
    case 'United States':
      return '🇺🇸';
    case 'Anguilla':
      return '🇦🇮';
    case 'Mexico':
      return '🇲🇽';
    case 'Canada':
      return '🇨🇦';
    case 'Costa Rica':
      return '🇨🇷';
    case 'Honduras':
      return '🇭🇳';
    case 'Jamaica':
      return '🇯🇲';
    case 'Panama':
      return '🇵🇦';
    case 'Trinidad and Tobago':
      return '🇹🇹';
    case 'El Salvador':
      return '🇸🇻';
    case 'Guatemala':
      return '🇬🇹';
    case 'Haiti':
      return '🇭🇹';
    case 'Nicaragua':
      return '🇳🇮';
    case 'Cuba':
      return '🇨🇺';
    case 'Dominican Republic':
      return '🇩🇴';
    case 'Puerto Rico':
      return '🇵🇷';
    case 'Antigua and Barbuda':
      return '🇦🇬';
    case 'Barbados':
      return '🇧🇧';
    case 'Belize':
      return '🇧🇿';
    case 'Bermuda':
      return '🇧🇲';
    case 'Saint-Martin':
      return '🇲🇫';
    case 'Bonaire':
      return '🇧🇶';
    case 'Sint Maarten':
      return '🇸🇲';
    case 'Guam':
      return '🇬🇺';
    case 'Cayman Islands':
      return '🇰🇾';
    case 'Grenada':
      return '🇬🇩';
    case 'Guadeloupe':
      return '🇬🇵';
    case 'Martinique':
      return '🇲🇶';
    case 'Saint Kitts and Nevis':
    case "St. Kitts & Nevis":
      return '🇰🇳';
    case 'Saint Lucia':
    case "St. Lucia":
      return '🇱🇨';
    case 'Saint Vincent and the Grenadines':
    case "St. Vincent & Grenadinen":
      return '🇻🇨';
    case 'Suriname':
      return '🇸🇷';
    case 'Aruba':
      return '🇦🇼';
    case 'Bahamas':
      return '🇧🇧';
    case 'British Virgin Islands':
      return '🇻🇬';
    case 'Curacao':
    case 'Curaçao':
      return '🇨🇼';
    case 'French Guiana':
      return '🇬🇫';
    case 'Montserrat':
      return '🇲🇸';
    case 'Turks and Caicos Islands':
      return '🇹🇨';

    // OFC (Океания)
    case 'New Zealand':
      return '🇳🇿';
    case 'Fiji':
      return '🇫🇯';
    case 'Papua New Guinea':
      return '🇵🇬';
    case 'Solomon Islands':
      return '🇸🇧';
    case 'Tahiti':
      return '🇵🇫';
    case 'New Caledonia':
      return '🇳🇨';
    case 'Vanuatu':
      return '🇻🇺';
    case 'Samoa':
      return '🇼🇸';
    case 'American Samoa':
      return '🇦🇸';
    case 'Cook Islands':
      return '🇨🇰';
    case 'Tonga':
      return '🇹🇴';
    case 'Tuvalu':
      return '🇹🇻';

    // Если страна не найдена
    default:
      return null;
  }
}

Color? shirtColorByCountryName(String? countryName) {
  // Определяем конфедерацию на основе названия страны
  switch (countryName) {
    // UEFA (Европа)
    case 'England':
      return const Color.fromARGB(255, 20, 96, 158);
    case 'France':
      return const Color.fromARGB(255, 15, 68, 112);
    case 'Spain':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Portugal':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Netherlands':
      return const Color.fromARGB(255, 217, 104, 43);
    case 'Italy':
      return const Color.fromARGB(255, 43, 121, 217);
    case 'Germany':
      return Colors.white;
    case 'Belgium':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Norway':
      return const Color.fromARGB(255, 225, 255, 253);
    case 'Denmark':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Sweden':
      return const Color.fromARGB(255, 217, 200, 43);
    case 'Ukraine':
      return const Color.fromARGB(255, 217, 200, 43);
    case 'Croatia':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Switzerland':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Austria':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Poland':
      return Colors.white;
    case 'Czech Republic':
    case 'Czechia':
      return Colors.blue;
    case 'Serbia':
      return Colors.white;
    case 'Greece':
      return const Color.fromARGB(255, 26, 119, 195);
    case 'Scotland':
      return const Color.fromARGB(255, 26, 119, 195);
    case 'Wales':
      return const Color.fromARGB(255, 19, 142, 31);
    case 'Hungary':
      return const Color.fromARGB(255, 19, 142, 31);
    case 'Slovenia':
      return Colors.white;
    case 'Slovakia':
      return Colors.white;
    case 'Russia':
      return const Color.fromARGB(255, 130, 27, 27);
    case 'Turkey':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Turkiye':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Romania':
      return const Color.fromARGB(255, 217, 200, 43);
    case 'Iceland':
      return const Color.fromARGB(255, 26, 119, 195);
    case 'Bulgaria':
      return const Color.fromARGB(255, 19, 142, 31);
    case 'Armenia':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Belarus':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Andorra':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Gibraltar':
      return const Color.fromARGB(255, 217, 43, 43);
    case 'Liechtenstein':
      return const Color.fromARGB(255, 19, 87, 142);
    case 'San Marino':
      return const Color.fromARGB(255, 33, 145, 237);
    case 'Faroe Islands':
      return Colors.white;
    case 'Finland':
      return Colors.white;
    case 'Republic of Ireland':
      return const Color.fromARGB(255, 19, 142, 31);
    case 'Northern Ireland':
      return Colors.white;
    case 'Georgia':
      return Colors.white;
    case 'Albania':
      return Colors.red;
    case 'Bosnia-Herzegovina':
      return Colors.amber;
    case 'Montenegro':
      return Colors.red;
    case 'Luxembourg':
      return Colors.lightBlue;
    case 'Cyprus':
      return Colors.white;
    case 'Estonia':
      return Colors.black;
    case 'Latvia':
      return const Color.fromARGB(255, 117, 3, 3);
    case 'Lithuania':
      return const Color.fromARGB(255, 19, 142, 31);
    case 'Malta':
      return Colors.red;
    case 'Moldova':
      return Colors.amber;
    case 'North Macedonia':
      return Colors.red;
    case 'Kosovo':
      return const Color.fromARGB(255, 30, 48, 138);

    // CONMEBOL (Южная Америка)
    case 'Argentina':
      return const Color.fromARGB(255, 60, 161, 255);
    case 'Brazil':
      return const Color.fromARGB(255, 255, 239, 60);
    case 'Uruguay':
      return const Color.fromARGB(255, 45, 120, 190);
    case 'Colombia':
      return Colors.amber;
    case 'Chile':
      return Colors.red;
    case 'Paraguay':
      return Colors.white;
    case 'Peru':
      return Colors.red;
    case 'Ecuador':
      return Colors.amber;
    case 'Bolivia':
      return Colors.green;
    case 'Venezuela':
      return Colors.amber;

    // CAF (Африка)
    case 'Nigeria':
      return Colors.green;
    case 'Senegal':
      return Colors.orange;
    case 'Cameroon':
      return Colors.green;

    case 'Morocco':
      return Colors.red;

    case 'Ivory Coast':
      return Colors.green;

    case 'Ghana':
      return Colors.amber;

    case 'Algeria':
      return Colors.green;

    case 'Tunisia':
      return Colors.red;

    case 'Egypt':
      return Colors.black;

    case 'Mali':
      return Colors.yellow;

    case 'Burkina Faso':
      return Colors.green;

    case 'Democratic Republic of the Congo':
      return Colors.lightBlue;

    case 'Guinea':
      return Colors.yellow;

    case 'South Africa':
      return Colors.black;

    case 'Zambia':
      return Colors.green;

    case 'Cape Verde':
      return const Color.fromARGB(255, 13, 35, 98);

    case 'Gabon':
      return Colors.green;

    case 'Uganda':
      return Colors.yellow;

    case 'Madagascar':
      return Colors.white;

    case 'Angola':
      return Colors.red;

    case 'Benin':
      return Colors.red;

    case 'Mauritania':
      return Colors.green;

    case 'Niger':
      return Colors.orange;

    case 'Tanzania':
      return Colors.black;

    case 'Zimbabwe':
      return Colors.green;

    case 'Comoros':
      return Colors.green;

    case 'Guinea-Bissau':
      return Colors.green;

    case 'Malawi':
      return Colors.black;

    case 'Mozambique':
      return Colors.black;

    case 'The Gambia':
      return Colors.black;
    case 'Botswana':
      return const Color.fromARGB(255, 1, 28, 119);

    case 'Kenya':
      return Colors.black;

    case 'Republic of the Congo':
      return Colors.green;

    case 'Guyana':
      return Colors.green;

    case 'Namibia':
      return Colors.green;

    case 'Boswana':
      return Colors.blue;

    case 'Mauritius':
      return Colors.black;

    case 'São Tomé and Príncipe':
      return Colors.green;

    case 'Chad':
      return Colors.black;

    case 'Mayotte':
      return Colors.white;

    case 'Togo':
      return Colors.red;

    case 'Sierra Leone':
      return Colors.green;

    case 'Burundi':
      return Colors.white;

    case 'Central African Republic':
      return Colors.red;

    case 'Djibouti':
      return Colors.blue;

    case 'Equatorial Guinea':
      return Colors.green;

    case 'Eswatini':
      return Colors.amber;

    case 'Ethiopia':
      return Colors.green;

    case 'Gambia':
      return Colors.black;

    case 'Lesotho':
      return const Color.fromARGB(255, 121, 0, 0);

    case 'Liberia':
      return const Color.fromARGB(255, 0, 20, 152);

    case 'Libya':
      return Colors.black;

    case 'Rwanda':
      return Colors.blue;

    case 'Sao Tome and Principe':
      return Colors.green;

    case 'Seychelles':
      return Colors.red;

    case 'Somalia':
      return Colors.blue;

    case 'Sudan':
      return Colors.red;

    case 'South Sudan':
      return Colors.black;

    // AFC (Азия)
    case 'Japan':
      return Colors.white;

    case 'South Korea':
      return Colors.white;

    case 'Iran':
      return Colors.red;

    case 'Saudi Arabia':
      return Colors.green;

    case 'Australia':
      return Colors.yellow;

    case 'United Arab Emirates':
      return Colors.red;

    case 'China':
      return Colors.red;

    case 'Iraq':
      return Colors.black;

    case 'Qatar':
      return const Color.fromARGB(255, 111, 0, 0);

    case 'Uzbekistan':
      return Colors.blue;

    case 'Syria':
      return Colors.green;

    case 'Jordan':
      return Colors.black;

    case 'Vietnam':
      return Colors.red;

    case 'Oman':
      return Colors.red;

    case 'Kuwait':
      return Colors.black;

    case 'Bahrain':
      return Colors.red;

    case 'Israel':
      return const Color.fromARGB(255, 0, 136, 255);

    case 'Azerbaijan':
      return Colors.green;

    case 'Kazakhstan':
      return Colors.blue;

    case 'Brunei Darussalam':
      return Colors.yellow;

    case 'Thailand':
      return const Color.fromARGB(255, 0, 32, 113);

    case 'North Korea':
      return const Color.fromARGB(255, 255, 0, 0);

    case 'India':
      return Colors.orange;

    case 'Palestine':
      return Colors.black;

    case 'Philippines':
      return Colors.white;

    case 'Tajikistan':
      return Colors.red;

    case 'Kyrgyzstan':
      return Colors.red;

    case 'Lebanon':
      return Colors.red;

    case 'Malaysia':
      return Colors.red;

    case 'Singapore':
      return Colors.white;

    case 'Yemen':
      return Colors.black;

    case 'Afghanistan':
      return Colors.black;

    case 'Bangladesh':
      return Colors.green;

    case 'Bhutan':
      return Colors.yellow;

    case 'Brunei':
      return Colors.yellow;

    case 'Cambodia':
      return const Color.fromARGB(255, 7, 0, 135);

    case 'Hong Kong':
      return Colors.red;

    case 'Indonesia':
      return Colors.white;

    case 'Laos':
      return const Color.fromARGB(255, 153, 0, 0);

    case 'Macau':
      return Colors.green;

    case 'Maldives':
      return Colors.green;

    case 'Mongolia':
      return const Color.fromARGB(255, 198, 0, 0);

    case 'Myanmar':
      return Colors.yellow;

    case 'Nepal':
      return Colors.red;

    case 'Pakistan':
      return Colors.green;

    case 'Sri Lanka':
      return Colors.orange;

    case 'Chinese Taipei':
      return Colors.red;

    case 'Timor-Leste':
      return Colors.red;

    case 'Turkmenistan':
      return Colors.green;

    // CONCACAF (Северная и Центральная Америка, Карибы)
    case 'United States':
      return Colors.blue;

    case 'Anguilla':
      return Colors.orange;

    case 'Mexico':
      return Colors.green;

    case 'Canada':
      return Colors.red;

    case 'Costa Rica':
      return Colors.red;

    case 'Honduras':
      return Colors.blue;

    case 'Jamaica':
      return Colors.black;

    case 'Panama':
      return Colors.white;

    case 'Trinidad and Tobago':
      return Colors.red;

    case 'El Salvador':
      return const Color.fromARGB(255, 0, 6, 112);

    case 'Guatemala':
      return Colors.lightBlueAccent;

    case 'Haiti':
      return const Color.fromARGB(255, 13, 0, 108);

    case 'Nicaragua':
      return const Color.fromARGB(255, 0, 145, 255);

    case 'Cuba':
      return Colors.red;

    case 'Dominican Republic':
      return Colors.red;

    case 'Puerto Rico':
      return Colors.red;

    case 'Antigua and Barbuda':
      return Colors.red;

    case 'Barbados':
      return Colors.amber;

    case 'Belize':
      return const Color.fromARGB(255, 14, 0, 137);

    case 'Bermuda':
      return Colors.red;

    case 'Saint-Martin':
      return Colors.white;

    case 'Bonaire':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Sint Maarten':
      return const Color.fromARGB(255, 0, 140, 255);

    case 'Guam':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Cayman Islands':
      return const Color.fromARGB(255, 0, 13, 60);

    case 'Grenada':
      return Colors.green;

    case 'Guadeloupe':
      return const Color.fromARGB(255, 0, 13, 60);

    case 'Martinique':
      return Colors.black;

    case 'Saint Kitts and Nevis':
      return Colors.green;

    case 'Saint Lucia':
      return const Color.fromARGB(255, 0, 128, 255);

    case 'Saint Vincent and the Grenadines':
      return Colors.amber;

    case 'Suriname':
      return Colors.red;

    case 'Aruba':
      return Colors.blue;

    case 'Bahamas':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'British Virgin Islands':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Curacao':
    case 'Curaçao':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'French Guiana':
      return Colors.green;

    case 'Montserrat':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Turks and Caicos Islands':
      return const Color.fromARGB(255, 0, 27, 123);

    // OFC (Океания)
    case 'New Zealand':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Fiji':
      return const Color.fromARGB(255, 0, 162, 255);

    case 'Papua New Guinea':
      return Colors.black;

    case 'Solomon Islands':
      return Colors.green;

    case 'Tahiti':
      return const Color.fromARGB(255, 135, 0, 0);

    case 'New Caledonia':
      return Colors.red;

    case 'Vanuatu':
      return Colors.green;

    case 'Samoa':
      return Colors.red;

    case 'American Samoa':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Cook Islands':
      return const Color.fromARGB(255, 0, 27, 123);

    case 'Tonga':
      return Colors.red;

    case 'Tuvalu':
      return const Color.fromARGB(255, 0, 162, 255);

    // Если страна не найдена
    default:
      return null;
  }
}

const allCitizenships = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Bosnia-Herzegovina",
  "Botswana",
  "Brazil",
  "British Virgin Islands",
  "Brunei Darussalam",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Cape Verde",
  "Cayman Islands",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Chinese Taipei",
  "Colombia",
  "Comoros",
  "Congo",
  "Costa Rica",
  "Cote d'Ivoire",
  "Croatia",
  "Cuba",
  "Curacao",
  "Cyprus",
  "Czech Republic",
  "DR Congo",
  "Denmark",
  "Djibouti",
  "Dominican Republic",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "England",
  "Equatorial Guinea",
  "Estonia",
  "Eswatini",
  "Ethiopia",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "French Guiana",
  "Gabon",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Honduras",
  "Hongkong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iraq",
  "Ireland",
  "Isle of Man",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Korea, North",
  "Kosovo",
  "Kuwait",
  "Kyrgyzstan",
  "Laos",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macao",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mexico",
  "Moldova",
  "Mongolia",
  "Montenegro",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nepal",
  "Netherlands",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "North Macedonia",
  "Northern Ireland",
  "Norway",
  "Oman",
  "Pakistan",
  "Palestine",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Romania",
  "Russia",
  "Rwanda",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Scotland",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "Southern Sudan",
  "Spain",
  "Sri Lanka",
  "St. Kitts & Nevis",
  "St. Lucia",
  "St. Vincent & Grenadinen",
  "Sudan",
  "Suriname",
  "Sweden",
  "Switzerland",
  "Syria",
  "Tahiti",
  "Tajikistan",
  "Tanzania",
  "Thailand",
  "The Gambia",
  "Timor-Leste",
  "Togo",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkmenistan",
  "Turks- and Caicosinseln",
  "Türkiye",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United States",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Venezuela",
  "Vietnam",
  "Wales",
  "Yemen",
  "Zambia",
  "Zanzibar",
  "Zimbabwe",
];
