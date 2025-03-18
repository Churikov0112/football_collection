enum Confederations {
  caf,
  concacaf,
  ofc,
  uefa,
  afc,
  conmebol,
  unknown,
}

extension ConfederationExtension on Confederations {
  String toJson() => name.toUpperCase();
}

Confederations confederationFromCountryName(String countryName) {
  // Определяем конфедерацию на основе названия страны
  switch (countryName) {
    // UEFA (Европа)
    case 'England':
    case 'France':
    case 'Spain':
    case 'Portugal':
    case 'Netherlands':
    case 'Italy':
    case 'Germany':
    case 'Belgium':
    case 'Norway':
    case 'Denmark':
    case 'Sweden':
    case 'Ukraine':
    case 'Croatia':
    case 'Switzerland':
    case 'Austria':
    case 'Poland':
    case 'Czech Republic':
    case 'Serbia':
    case 'Greece':
    case 'Scotland':
    case 'Wales':
    case 'Hungary':
    case 'Slovenia':
    case 'Slovakia':
    case 'Russia':
    case 'Turkey':
    case 'Turkiye':
    case 'Romania':
    case 'Iceland':
    case 'Bulgaria':
    case 'Armenia':
    case 'Belarus':
    case 'Andorra':
    case 'Gibraltar':
    case 'Liechtenstein':
    case 'San Marino':
    case 'Faroe Islands':
    case 'Finland':
    case 'Republic of Ireland':
    case 'Northern Ireland':
    case 'Georgia':
    case 'Albania':
    case 'Bosnia-Herzegovina':
    case 'Montenegro':
    case 'Luxembourg':
    case 'Cyprus':
    case 'Estonia':
    case 'Latvia':
    case 'Lithuania':
    case 'Malta':
    case 'Moldova':
    case 'North Macedonia':
    case 'Kosovo':
      return Confederations.uefa;

    // CONMEBOL (Южная Америка)
    case 'Argentina':
    case 'Brazil':
    case 'Uruguay':
    case 'Colombia':
    case 'Chile':
    case 'Paraguay':
    case 'Peru':
    case 'Ecuador':
    case 'Bolivia':
    case 'Venezuela':
      return Confederations.conmebol;

    // CAF (Африка)
    case 'Nigeria':
    case 'Senegal':
    case 'Cameroon':
    case 'Morocco':
    case 'Ivory Coast':
    case 'Ghana':
    case 'Algeria':
    case 'Tunisia':
    case 'Egypt':
    case 'Mali':
    case 'Burkina Faso':
    case 'Democratic Republic of the Congo':
    case 'Guinea':
    case 'South Africa':
    case 'Zambia':
    case 'Cape Verde':
    case 'Gabon':
    case 'Uganda':
    case 'Madagascar':
    case 'Angola':
    case 'Benin':
    case 'Mauritania':
    case 'Niger':
    case 'Tanzania':
    case 'Zimbabwe':
    case 'Comoros':
    case 'Guinea-Bissau':
    case 'Malawi':
    case 'Mozambique':
    case 'The Gambia':
    case 'Botswana':
    case 'Kenya':
    case 'Republic of the Congo':
    case 'Guyana':
    case 'Namibia':
    case 'Boswana':
    case 'Mauritius':
    case 'São Tomé and Príncipe':
    case 'Chad':
    case 'Mayotte':
    case 'Togo':
    case 'Sierra Leone':
    case 'Burundi':
    case 'Central African Republic':
    case 'Djibouti':
    case 'Equatorial Guinea':
    case 'Eswatini':
    case 'Ethiopia':
    case 'Gambia':
    case 'Lesotho':
    case 'Liberia':
    case 'Libya':
    case 'Rwanda':
    case 'Sao Tome and Principe':
    case 'Seychelles':
    case 'Somalia':
    case 'Sudan':
    case 'South Sudan':
      return Confederations.caf;

    // AFC (Азия)
    case 'Japan':
    case 'South Korea':
    case 'Iran':
    case 'Saudi Arabia':
    case 'Australia':
    case 'United Arab Emirates':
    case 'China':
    case 'Iraq':
    case 'Qatar':
    case 'Uzbekistan':
    case 'Syria':
    case 'Jordan':
    case 'Vietnam':
    case 'Oman':
    case 'Kuwait':
    case 'Bahrain':
    case 'Israel':
    case 'Azerbaijan':
    case 'Kazakhstan':
    case 'Brunei Darussalam':
    case 'Thailand':
    case 'North Korea':
    case 'India':
    case 'Palestine':
    case 'Philippines':
    case 'Tajikistan':
    case 'Kyrgyzstan':
    case 'Lebanon':
    case 'Malaysia':
    case 'Singapore':
    case 'Yemen':
    case 'Afghanistan':
    case 'Bangladesh':
    case 'Bhutan':
    case 'Brunei':
    case 'Cambodia':
    case 'Hong Kong':
    case 'Indonesia':
    case 'Laos':
    case 'Macau':
    case 'Maldives':
    case 'Mongolia':
    case 'Myanmar':
    case 'Nepal':
    case 'Pakistan':
    case 'Sri Lanka':
    case 'Chinese Taipei':
    case 'Timor-Leste':
    case 'Turkmenistan':
      return Confederations.afc;

    // CONCACAF (Северная и Центральная Америка, Карибы)
    case 'United States':
    case 'Mexico':
    case 'Canada':
    case 'Costa Rica':
    case 'Honduras':
    case 'Jamaica':
    case 'Panama':
    case 'Trinidad and Tobago':
    case 'El Salvador':
    case 'Guatemala':
    case 'Haiti':
    case 'Nicaragua':
    case 'Cuba':
    case 'Dominican Republic':
    case 'Puerto Rico':
    case 'Antigua and Barbuda':
    case 'Barbados':
    case 'Belize':
    case 'Bermuda':
    case 'Saint-Martin':
    case 'Bonaire':
    case 'Sint Maarten':
    case 'Guam':
    case 'Cayman Islands':
    case 'Grenada':
    case 'Guadeloupe':
    case 'Martinique':
    case 'Saint Kitts and Nevis':
    case 'Saint Lucia':
    case 'Saint Vincent and the Grenadines':
    case 'Suriname':
    case 'Aruba':
    case 'Bahamas':
    case 'British Virgin Islands':
    case 'Curacao':
    case 'Curaçao':
    case 'French Guiana':
    case 'Montserrat':
    case 'Turks and Caicos Islands':
      return Confederations.concacaf;

    // OFC (Океания)
    case 'New Zealand':
    case 'Fiji':
    case 'Papua New Guinea':
    case 'Solomon Islands':
    case 'Tahiti':
    case 'New Caledonia':
    case 'Vanuatu':
    case 'Samoa':
    case 'American Samoa':
    case 'Cook Islands':
    case 'Tonga':
    case 'Tuvalu':
      return Confederations.ofc;

    // Если страна не найдена
    default:
      return Confederations.unknown;
  }
}
