import 'package:equatable/equatable.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';

class CountryModel extends Equatable {
  final String id;
  final String name;
  final FootballConfederations confederation;

  const CountryModel({
    required this.id,
    required this.name,
    required this.confederation,
  });

  factory CountryModel.fromJson(Map<dynamic, dynamic> json) {
    return CountryModel(
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
      return '🇸🇪';
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
      return '🇰🇳';
    case 'Saint Lucia':
      return '🇱🇨';
    case 'Saint Vincent and the Grenadines':
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
