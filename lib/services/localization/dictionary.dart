import 'package:flutter/material.dart';

enum Languages {
  english,
  spanish,
  portuguese,
  french,
  italian,
  russian,
  turkish,
  chinese,
  arabic,
  japanese,
  hindi,
  bengal,
  german,
  korean,
}

extension LanguagesExtension on Languages {
  String toShortString() {
    switch (this) {
      case Languages.english:
        return 'en-EN';
      case Languages.russian:
        return 'ru-RU';
      case Languages.spanish:
        return 'es-ES';
      case Languages.portuguese:
        return 'pt-BR';
      case Languages.turkish:
        return 'tr-TR';
      case Languages.french:
        return 'fr-FR';
      case Languages.chinese:
        return 'zh-CN';
      case Languages.arabic:
        return 'ar-SA';
      case Languages.japanese:
        return 'ja-JP';
      case Languages.hindi:
        return 'hi-IN';
      case Languages.bengal:
        return 'bn-IN';
      case Languages.german:
        return 'de-DE';
      case Languages.korean:
        return 'ko-KR';
      case Languages.italian:
        return 'it-IT';
    }
  }

  Locale get locale {
    switch (this) {
      case Languages.english:
        return const Locale('en', 'US');
      case Languages.russian:
        return const Locale('ru', 'RU');
      case Languages.spanish:
        return const Locale('es', 'ES');
      case Languages.portuguese:
        return const Locale('pt', 'BR');
      case Languages.turkish:
        return const Locale('tr', 'TR');
      case Languages.french:
        return const Locale('fr', 'FR');
      case Languages.chinese:
        return const Locale('zh', 'CN');
      case Languages.arabic:
        return const Locale('ar', 'SA');
      case Languages.japanese:
        return const Locale('ja', 'JP');
      case Languages.hindi:
        return const Locale('hi', 'IN');
      case Languages.bengal:
        return const Locale('bn', 'IN');
      case Languages.german:
        return const Locale('de', 'DE');
      case Languages.korean:
        return const Locale('ko', 'KR');
      case Languages.italian:
        return const Locale('it', 'IT');
    }
  }

  String get name {
    switch (this) {
      case Languages.english:
        return 'English';
      case Languages.russian:
        return 'Русский';
      case Languages.spanish:
        return 'Español';
      case Languages.portuguese:
        return 'Português';
      case Languages.turkish:
        return 'Türkçe';
      case Languages.french:
        return 'Français';
      case Languages.chinese:
        return '中文';
      case Languages.arabic:
        return 'العربية';
      case Languages.japanese:
        return '日本語';
      case Languages.hindi:
        return 'हिन्दी';
      case Languages.bengal:
        return 'বাংলা';
      case Languages.german:
        return 'Deutsch';
      case Languages.korean:
        return '한국어';
      case Languages.italian:
        return 'Italiano';
    }
  }

  String get englishName {
    switch (this) {
      case Languages.english:
        return 'English';
      case Languages.russian:
        return 'Russian';
      case Languages.spanish:
        return 'Spanish';
      case Languages.portuguese:
        return 'Portuguese';
      case Languages.turkish:
        return 'Turkish';
      case Languages.french:
        return 'French';
      case Languages.chinese:
        return 'Chinese';
      case Languages.arabic:
        return 'Arabic';
      case Languages.japanese:
        return 'Japanese';
      case Languages.hindi:
        return 'Hindi';
      case Languages.bengal:
        return 'Bengali';
      case Languages.german:
        return 'German';
      case Languages.korean:
        return 'Korean';
      case Languages.italian:
        return 'Italian';
    }
  }

  String get emoji {
    switch (this) {
      case Languages.english:
        return '🇺🇸';
      case Languages.russian:
        return '🇷🇺';
      case Languages.spanish:
        return '🇪🇸';
      case Languages.portuguese:
        return '🇧🇷';
      case Languages.turkish:
        return '🇹🇷';
      case Languages.french:
        return '🇫🇷';
      case Languages.chinese:
        return '🇨🇳';
      case Languages.arabic:
        return '🇸🇦';
      case Languages.japanese:
        return '🇯🇵';
      case Languages.hindi:
        return '🇮🇳';
      case Languages.bengal:
        return '🇧🇩';
      case Languages.german:
        return '🇩🇪';
      case Languages.korean:
        return '🇰🇷';
      case Languages.italian:
        return '🇮🇹';
    }
  }
}

enum AppGlossary {
  unknown,
  language,
  settings,
  miniGames,
  openPack,
  scanQr,
  scanYourFriendQrToGetPlayer,
  cheatCodes,
  cheatCodeHere,
  cheatCodeActivated,
  cheatCodeNotFound,
  about,
  webVersion,
  continents,
  europe,
  africa,
  asia,
  northAmerica,
  southAmerica,
  oceania,
  free,
  confirmToBuyPackFor,
  confirm,
  cancel,
  youHaveNotEnoughMoneyToBuyPack,
  playMiniGames,
  watchAd,
  guessTransferValue,
  whoCostsMore,
  guessWhichPlayerIsMoreExpensive,
  left,
  right,
  equal,
  incorrect,
  tryAgain,
  correct,
  rewarded,
  winstrick,
  balanceIncreased,
  balanceDecreased,
  // convertDuplicateToQr,
  whatToDoWithDuplicate,
  shareViaQr,
  sell,
  openQrScannerOnSecondDevice,
  onboardingWelcome,
  onboardingWhoWeAre,
  onboardingPressPacksButton,
  onboardingOpenPacks,
  onboardingTapOnPackToOpenIt,
  onboardingSwipeCardsToSave,
  onboardingEverySwipedCardWillBeSavedYouCanSwipeAnyDirection,
  onboardingCardsAreSaved,
  onboardingTapOnCardToSeeInfo,
  next,
  onboardingShareCardsWithFriendsOrSell,
  onboardingShareCardsWithFriendsOrSellDescription,
  onboardingStartCollectioning,
  settingsVibrationOnPackOpening,
  ourWebsite,
}

const dictionary = {
  AppGlossary.language: {
    Languages.english: 'Language',
    Languages.russian: 'Язык',
    Languages.spanish: 'Idioma',
    Languages.portuguese: 'Idioma',
    Languages.turkish: 'Dil',
    Languages.french: 'Langue',
    Languages.chinese: '语言',
    Languages.arabic: 'لغة',
    Languages.japanese: '言語',
    Languages.hindi: 'भाषा',
    Languages.bengal: 'ভাষা',
    Languages.german: 'Sprache',
    Languages.korean: '언어',
    Languages.italian: 'Lingua',
  },
  AppGlossary.settings: {
    Languages.english: 'Settings',
    Languages.russian: 'Настройки',
    Languages.spanish: 'Ajustes',
    Languages.portuguese: 'Configurações',
    Languages.turkish: 'Ayarlar',
    Languages.french: 'Paramètres',
    Languages.chinese: '设置',
    Languages.arabic: 'الإعدادات',
    Languages.japanese: '設定',
    Languages.hindi: 'सेटिंग्स',
    Languages.bengal: 'সেটিংস',
    Languages.german: 'Einstellungen',
    Languages.korean: '설정',
    Languages.italian: 'Impostazioni',
  },
  AppGlossary.miniGames: {
    Languages.english: 'Mini Games',
    Languages.russian: 'Мини игры',
    Languages.spanish: 'Mini juegos',
    Languages.portuguese: 'Mini jogos',
    Languages.turkish: 'Mini oyunlar',
    Languages.french: 'Mini-jeux',
    Languages.chinese: '迷你游戏',
    Languages.arabic: 'مايكروغيمز',
    Languages.japanese: 'ミニゲーム',
    Languages.hindi: 'मिनी गेम्स',
    Languages.bengal: 'মিনি গেমস',
    Languages.german: 'Mini-Spiele',
    Languages.korean: '미니게임',
    Languages.italian: 'Mini-giochi',
  },
  AppGlossary.openPack: {
    Languages.english: 'Open pack',
    Languages.russian: 'Открыть пак',
    Languages.spanish: 'Abrir paquete',
    Languages.portuguese: 'Abrir pacote',
    Languages.turkish: 'Paketi aç',
    Languages.french: 'Ouvrir le paquet',
    Languages.chinese: '打开包',
    Languages.arabic: 'فتح الحزمة',
    Languages.japanese: 'パックを開く',
    Languages.hindi: 'चाल कोड सक्रिय करें',
    Languages.bengal: 'প্যাক খোলুন',
    Languages.german: 'Paket öffnen',
    Languages.korean: '팩 열기',
    Languages.italian: 'Apri il pacchetto',
  },
  AppGlossary.scanQr: {
    Languages.english: 'Scan QR',
    Languages.russian: 'Сканировать QR',
    Languages.spanish: 'Escanear QR',
    Languages.portuguese: 'Escanear QR',
    Languages.turkish: 'QR kodu tarayın',
    Languages.french: 'Scanner QR',
    Languages.chinese: '扫描二维码',
    Languages.arabic: 'مسح QR',
    Languages.japanese: 'QRコードをスキャン',
    Languages.hindi: 'चाल कोड सक्रिय करें',
    Languages.bengal: 'QR कोड स्कैन करेন',
    Languages.german: 'QR-Code scannen',
    Languages.korean: 'QR 코드 스캔',
    Languages.italian: 'Scansione QR',
  },
  AppGlossary.cheatCodes: {
    Languages.english: 'Cheat codes',
    Languages.russian: 'Чит коды',
    Languages.spanish: 'Códigos de truco',
    Languages.portuguese: 'Códigos de trapaça',
    Languages.turkish: 'Saldırgan kodlar',
    Languages.french: 'Codes triche',
    Languages.chinese: '作弊码',
    Languages.arabic: 'كود التجسس',
    Languages.japanese: 'チートコード',
    Languages.hindi: 'चाल कोड',
    Languages.bengal: 'চাল কোড',
    Languages.german: 'Cheat-Codes',
    Languages.korean: '치트 코드',
    Languages.italian: 'Codici truccati',
  },
  AppGlossary.cheatCodeActivated: {
    Languages.english: 'Cheat code activated',
    Languages.russian: 'Чит код активирован',
    Languages.spanish: 'Código de truco activado',
    Languages.portuguese: 'Código de trapaça ativado',
    Languages.turkish: 'Saldırgan kod etkinleştirildi',
    Languages.french: 'Code triche activé',
    Languages.chinese: '作弊码已激活',
    Languages.arabic: 'تم تنشيط كود التجسس',
    Languages.japanese: 'チートコードが有効になりました',
    Languages.hindi: 'चाल कोड सक्रिय करें',
    Languages.bengal: 'চাল কোড সক্রিয় করা হয়েছে',
    Languages.german: 'Cheat-Code aktiviert',
    Languages.korean: '치트 코드가 활성화되었습니다',
    Languages.italian: 'Codice truccato trovato',
  },
  AppGlossary.cheatCodeNotFound: {
    Languages.english: 'Cheat code not found',
    Languages.russian: 'Чит код не найден',
    Languages.spanish: 'Código de truco no encontrado',
    Languages.portuguese: 'Código de trapaça não encontrado',
    Languages.turkish: 'Saldırgan kod bulunamadı',
    Languages.french: 'Code triche introuvable',
    Languages.chinese: '作弊码未找到',
    Languages.arabic: 'لم يتم العثور على كود التجسس',
    Languages.japanese: 'チートコードが見つかりませんでした',
    Languages.hindi: 'चाल कोड नहीं मिला',
    Languages.bengal: 'চাল কোড পাওয়া যায়নি',
    Languages.german: 'Cheat-Code nicht gefunden',
    Languages.korean: '치트 코드를 찾을 수 없습니다',
    Languages.italian: 'Codice truccato non trovato',
  },
  AppGlossary.about: {
    Languages.english: 'About',
    Languages.russian: 'О приложении',
    Languages.spanish: 'Acerca de',
    Languages.portuguese: 'Sobre',
    Languages.turkish: 'Hakkında',
    Languages.french: 'À propos',
    Languages.chinese: '关于',
    Languages.arabic: 'حول التطبيق',
    Languages.japanese: 'アプリについて',
    Languages.hindi: 'अपने बारे में',
    Languages.bengal: 'সম্পর্কে',
    Languages.german: 'Über',
    Languages.korean: '앱에 대해',
    Languages.italian: 'Informazioni',
  },
  AppGlossary.webVersion: {
    Languages.english: 'Web version',
    Languages.russian: 'Веб версия',
    Languages.spanish: 'Versión web',
    Languages.portuguese: 'Versão da Web',
    Languages.turkish: 'Web sürümü',
    Languages.french: 'Version Web',
    Languages.chinese: '网络版',
    Languages.arabic: 'الإصدار الويب',
    Languages.japanese: 'Webバージョン',
    Languages.hindi: 'वेब संस्करण',
    Languages.bengal: 'ওয়েব সংস্করণ',
    Languages.german: 'Web-Version',
    Languages.korean: '웹 버전',
    Languages.italian: 'Versione Web',
  },
  AppGlossary.cheatCodeHere: {
    Languages.english: 'Cheat code here',
    Languages.russian: 'Чит код',
    Languages.spanish: 'Código de truco aquí',
    Languages.portuguese: 'Código de trapaça aqui',
    Languages.turkish: 'Saldırgan kod burada',
    Languages.french: 'Code triche ici',
    Languages.chinese: '作弊码在这里',
    Languages.arabic: 'كود التجسس هنا',
    Languages.japanese: 'チートコードここに',
    Languages.hindi: 'चाल कोड यहाँ',
    Languages.bengal: 'চাল কোড এখানে',
    Languages.german: 'Cheat-Code hier',
    Languages.korean: '치트 코드 여기',
    Languages.italian: 'Codice truccato qui',
  },
  AppGlossary.continents: {
    Languages.english: 'Continents',
    Languages.russian: 'Континенты',
    Languages.spanish: 'Continentes',
    Languages.portuguese: 'Continentes',
    Languages.turkish: 'Kıtalar',
    Languages.french: 'Continents',
    Languages.chinese: '大陆',
    Languages.arabic: 'القارات',
    Languages.japanese: '大陸',
    Languages.hindi: 'भूमध्यसागर',
    Languages.bengal: 'ভূমধ্যসাগর',
    Languages.german: 'Kontinente',
    Languages.korean: '대륙',
    Languages.italian: 'Continenti',
  },
  AppGlossary.europe: {
    Languages.english: 'Europe',
    Languages.russian: 'Европа',
    Languages.spanish: 'Europa',
    Languages.portuguese: 'Europa',
    Languages.turkish: 'Avrupa',
    Languages.french: 'Europe',
    Languages.chinese: '欧洲',
    Languages.arabic: 'أوروبا',
    Languages.japanese: 'ヨーロッパ',
    Languages.hindi: 'यूरोप',
    Languages.bengal: 'ইউরোপ',
    Languages.german: 'Europa',
    Languages.korean: '유럽',
    Languages.italian: 'Europa',
  },
  AppGlossary.africa: {
    Languages.english: 'Africa',
    Languages.russian: 'Африка',
    Languages.spanish: 'África',
    Languages.portuguese: 'África',
    Languages.turkish: 'Afrika',
    Languages.french: 'Afrique',
    Languages.chinese: '非洲',
    Languages.arabic: 'أفريقيا',
    Languages.japanese: 'アフリカ',
    Languages.hindi: 'अफ्रीका',
    Languages.bengal: 'অফরিকা',
    Languages.german: 'Afrika',
    Languages.korean: '아프리카',
    Languages.italian: 'Africa',
  },
  AppGlossary.asia: {
    Languages.english: 'Asia',
    Languages.russian: 'Азия',
    Languages.spanish: 'Asia',
    Languages.portuguese: 'Ásia',
    Languages.turkish: 'Asya',
    Languages.french: 'Asie',
    Languages.chinese: '亚洲',
    Languages.arabic: 'آسيا',
    Languages.japanese: 'アジア',
    Languages.hindi: 'एशिया',
    Languages.bengal: 'এশিয়া',
    Languages.german: 'Asien',
    Languages.korean: '아시아',
    Languages.italian: 'Asia',
  },
  AppGlossary.northAmerica: {
    Languages.english: 'North America',
    Languages.russian: 'Северная Америка',
    Languages.spanish: 'América del Norte',
    Languages.portuguese: 'América do Norte',
    Languages.turkish: 'Kuzey Amerika',
    Languages.french: 'Amérique du Nord',
    Languages.chinese: '北美',
    Languages.arabic: 'أمريكا الشمالية',
    Languages.japanese: '北アメリカ',
    Languages.hindi: 'उत्तर अमेरिका',
    Languages.bengal: 'উত্তর আমেরিকা',
    Languages.german: 'Nordamerika',
    Languages.korean: '북아메리카',
    Languages.italian: 'America del Nord',
  },
  AppGlossary.southAmerica: {
    Languages.english: 'South America',
    Languages.russian: 'Южная Америка',
    Languages.spanish: 'América del Sur',
    Languages.portuguese: 'América do Sul',
    Languages.turkish: 'Güney Amerika',
    Languages.french: 'Amérique du Sud',
    Languages.chinese: '南美洲',
    Languages.arabic: 'أمريكا الجنوبية',
    Languages.japanese: '南アメリカ',
    Languages.hindi: 'दक्षिण अमेरिका',
    Languages.bengal: 'দক্ষিণ আমেরিকা',
    Languages.german: 'Südamerika',
    Languages.korean: '남아메리카',
    Languages.italian: 'America del Sud',
  },
  AppGlossary.oceania: {
    Languages.english: 'Oceania',
    Languages.russian: 'Океания',
    Languages.spanish: 'Oceanía',
    Languages.portuguese: 'Oceania',
    Languages.turkish: 'Okyanusya',
    Languages.french: 'Océanie',
    Languages.chinese: '大洋洲',
    Languages.arabic: 'المحيط الهادئ',
    Languages.japanese: 'オセアニア',
    Languages.hindi: 'ऑसीयानिया',
    Languages.bengal: 'অস্ট্রেলিয়া',
    Languages.german: 'Ozeanien',
    Languages.korean: '오세아니아',
    Languages.italian: 'Oceania',
  },
  AppGlossary.free: {
    Languages.english: 'Free',
    Languages.russian: 'Бесплатно',
    Languages.spanish: 'Gratis',
    Languages.portuguese: 'Gratuito',
    Languages.turkish: 'Ücretsiz',
    Languages.french: 'Gratuit',
    Languages.chinese: '免费',
    Languages.arabic: 'مجاني',
    Languages.japanese: '無料',
    Languages.hindi: 'मुफ्त',
    Languages.bengal: 'মুফত',
    Languages.german: 'Kostenlos',
    Languages.korean: '무료',
    Languages.italian: 'Gratuito',
  },
  AppGlossary.confirmToBuyPackFor: {
    Languages.english: 'Confirm to buy pack for',
    Languages.russian: 'Подтвердить покупку пака за',
    Languages.spanish: 'Confirmar la compra del paquete por',
    Languages.portuguese: 'Confirmar a compra do pacote por',
    Languages.turkish: 'Paketi satın almak için onayla',
    Languages.french: 'Confirmer l\'achat du pack pour',
    Languages.chinese: '确认购买包',
    Languages.arabic: 'قم بتأكيد شراء الحزمة ل',
    Languages.japanese: 'パックを購入するには',
    Languages.hindi: 'पैक के लिए खरीदने की पुष्टि करें',
    Languages.bengal: 'প্যাক কেনার জন্য নিশ্চিত করুন',
    Languages.german: 'Bestätigen Sie den Kauf des Pakets für',
    Languages.korean: '팩을 구매하려면',
    Languages.italian: 'Conferma acquisto pacchetto per',
  },
  AppGlossary.confirm: {
    Languages.english: 'Confirm',
    Languages.russian: 'Подтвердить',
    Languages.spanish: 'Confirmar',
    Languages.portuguese: 'Confirmar',
    Languages.turkish: 'Onayla',
    Languages.french: 'Confirmer',
    Languages.chinese: '确认',
    Languages.arabic: 'قم بالتأكيد',
    Languages.japanese: '確認',
    Languages.hindi: 'पुष्टि करें',
    Languages.bengal: 'নিশ্চিত করুন',
    Languages.german: 'Bestätigen',
    Languages.korean: '확인',
    Languages.italian: 'Conferma',
  },
  AppGlossary.cancel: {
    Languages.english: 'Cancel',
    Languages.russian: 'Отменить',
    Languages.spanish: 'Cancelar',
    Languages.portuguese: 'Cancelar',
    Languages.turkish: 'İptal',
    Languages.french: 'Annuler',
    Languages.chinese: '取消',
    Languages.arabic: 'إلغاء',
    Languages.japanese: 'キャンセル',
    Languages.hindi: 'रद्द करना',
    Languages.bengal: 'বাতিল করুন',
    Languages.german: 'Stornieren',
    Languages.korean: '취소',
    Languages.italian: 'Annulla',
  },
  AppGlossary.youHaveNotEnoughMoneyToBuyPack: {
    Languages.english: 'You have not enough 🏆 to buy pack',
    Languages.russian: 'У вас недостаточно 🏆 для покупки пака',
    Languages.spanish: 'No tienes suficiente 🏆 para comprar el paquete',
    Languages.portuguese: 'Você não tem dinheiro suficiente 🏆 para comprar o pacote',
    Languages.turkish: 'Paketi satın almak için yeterli 🏆 yok',
    Languages.french: 'Vous n\'avez pas assez de 🏆 pour acheter le pack',
    Languages.chinese: '你没有足够的🏆购买包',
    Languages.arabic: 'لا يوجد لديك ما يكفي من 🏆 لشراء الحزمة',
    Languages.japanese: 'パックを購入するには、もっと🏆が必要です',
    Languages.hindi: 'आपके पास पैक खरीदने के लिए पर्याप्त 🏆 नहीं है',
    Languages.bengal: 'আপনার পাশে প্যাক কেনার জন্য যথেষ্ট 🏆 নেই',
    Languages.german: 'Sie haben nicht genug 🏆, um das Paket zu kaufen',
    Languages.korean: '팩을 구매하려면 더 많은 🏆가 필요합니다',
    Languages.italian: 'Non hai abbastanza 🏆 per acquistare il pacchetto',
  },
  AppGlossary.playMiniGames: {
    Languages.english: 'Play mini games',
    Languages.russian: 'Играть в мини игры',
    Languages.spanish: 'Jugar a los mini juegos',
    Languages.portuguese: 'Jogar mini jogos',
    Languages.turkish: 'Mini oyunları oyna',
    Languages.french: 'Jouer aux mini-jeux',
    Languages.chinese: '玩迷你游戏',
    Languages.arabic: 'العب الألعاب الصغيرة',
    Languages.japanese: 'ミニゲームをプレイする',
    Languages.hindi: 'मिनी गेम खेलें',
    Languages.bengal: 'মিনি গেম খেলুন',
    Languages.german: 'Mini-Spiele spielen',
    Languages.korean: '미니 게임 플레이',
    Languages.italian: 'Gioca ai mini giochi',
  },
  AppGlossary.watchAd: {
    Languages.english: 'Watch ad',
    Languages.russian: 'Смотреть рекламу',
    Languages.spanish: 'Ver el anuncio',
    Languages.portuguese: 'Assistir anúncio',
    Languages.turkish: 'Reklam izle',
    Languages.french: 'Regarder la publicité',
    Languages.chinese: '看广告',
    Languages.arabic: 'مشاهدة الإعلان',
    Languages.japanese: '広告を見る',
    Languages.hindi: 'विज्ञापन देखें',
    Languages.bengal: 'বিজ্ঞাপন দেখুন',
    Languages.german: 'Zuschauen',
    Languages.korean: '광고 보기',
    Languages.italian: 'Guarda l\'annuncio',
  },
  AppGlossary.guessTransferValue: {
    Languages.english: 'Guess transfer value',
    Languages.russian: 'Угадай цену',
    Languages.spanish: 'Adivina el valor de la transferencia',
    Languages.portuguese: 'Adivinhe o valor da transferência',
    Languages.turkish: 'Transfer değerini tahmin et',
    Languages.french: 'Devinez la valeur de la transaction',
    Languages.chinese: '猜转会价值',
    Languages.arabic: 'تخمين قيمة التحويل',
    Languages.japanese: '転送価値を推測する',
    Languages.hindi: 'ट्रांसफर मूल्य का अनुमान लगाएं',
    Languages.bengal: 'ট্রান্সফার মূল্য অনুমান করুন',
    Languages.german: 'Übertragungswert erraten',
    Languages.korean: '전송 가치 추측',
    Languages.italian: 'Indovina il valore di trasferimento',
  },
  AppGlossary.whoCostsMore: {
    Languages.english: 'Who costs more',
    Languages.russian: 'Кто дороже',
    Languages.spanish: 'Quién es más caro',
    Languages.portuguese: 'Quem é mais caro',
    Languages.turkish: 'Kim daha fazla',
    Languages.french: 'Qui est plus cher',
    Languages.chinese: '谁更贵',
    Languages.arabic: 'من يكلف أكثر',
    Languages.japanese: '誰がより高いか',
    Languages.hindi: 'जो अधिक लागत है',
    Languages.bengal: 'কে বেশি খরচ করে',
    Languages.german: 'Wer ist teurer',
    Languages.korean: '누가 더 비쌉니까',
    Languages.italian: 'Chi costa di più',
  },
  AppGlossary.guessWhichPlayerIsMoreExpensive: {
    Languages.english: 'Guess which player is more expensive',
    Languages.russian: 'Угадайте, кто дороже',
    Languages.spanish: 'Adivina cuál es el jugador más caro',
    Languages.portuguese: 'Adivinhe qual jogador é mais caro',
    Languages.turkish: 'Hangi oyuncu daha fazla',
    Languages.french: 'Devinez quel joueur est plus cher',
    Languages.chinese: '猜哪个玩家更贵',
    Languages.arabic: 'تخمين من يكلف أكثر',
    Languages.japanese: 'どのプレーヤーがより高いかを推測する',
    Languages.hindi: 'जो अधिक लागत है का अनुमान लगाएं',
    Languages.bengal: 'কে বেশি খরচ করে কি অনুমান করুন',
    Languages.german: 'Erraten, wer teurer ist',
    Languages.korean: '누가 더 비쌉니까',
    Languages.italian: 'Indovina quale giocatore costa di più',
  },
  AppGlossary.left: {
    Languages.english: 'Left',
    Languages.russian: 'Левый',
    Languages.spanish: 'Izquierda',
    Languages.portuguese: 'Esquerda',
    Languages.turkish: 'Sol',
    Languages.french: 'À gauche',
    Languages.chinese: '左',
    Languages.arabic: 'اليسار',
    Languages.japanese: '左',
    Languages.hindi: 'बाईं',
    Languages.bengal: 'বাম',
    Languages.german: 'Links',
    Languages.korean: '왼쪽',
    Languages.italian: 'A sinistra',
  },
  AppGlossary.right: {
    Languages.english: 'Right',
    Languages.russian: 'Правый',
    Languages.spanish: 'Derecha',
    Languages.portuguese: 'Direita',
    Languages.turkish: 'Sağ',
    Languages.french: 'À droite',
    Languages.chinese: '右',
    Languages.arabic: 'اليمين',
    Languages.japanese: '右',
    Languages.hindi: 'दाईं',
    Languages.bengal: 'ডান',
    Languages.german: 'Rechts',
    Languages.korean: '오른쪽',
    Languages.italian: 'A destra',
  },
  AppGlossary.equal: {
    Languages.english: 'Equal',
    Languages.russian: 'Одинаково',
    Languages.spanish: 'Igual',
    Languages.portuguese: 'Igual',
    Languages.turkish: 'Eşit',
    Languages.french: 'Égal',
    Languages.chinese: '平等',
    Languages.arabic: 'متساوي',
    Languages.japanese: '平等',
    Languages.hindi: 'समान',
    Languages.bengal: 'সমান',
    Languages.german: 'Gleich',
    Languages.korean: '동등한',
    Languages.italian: 'Uguale',
  },
  AppGlossary.incorrect: {
    Languages.english: 'Incorrect',
    Languages.russian: 'Неправильно',
    Languages.spanish: 'Incorrecto',
    Languages.portuguese: 'Incorreto',
    Languages.turkish: 'Yanlış',
    Languages.french: 'Incorrect',
    Languages.chinese: '不正确',
    Languages.arabic: 'خاطئ',
    Languages.japanese: '不正',
    Languages.hindi: 'गलत',
    Languages.bengal: 'ভুল',
    Languages.german: 'Falsch',
    Languages.korean: '잘못된',
    Languages.italian: 'Errato',
  },
  AppGlossary.tryAgain: {
    Languages.english: 'Try again',
    Languages.russian: 'Попробуйте снова',
    Languages.spanish: 'Inténtalo de nuevo',
    Languages.portuguese: 'Tente novamente',
    Languages.turkish: 'Tekrar deneyin',
    Languages.french: 'Réessayer',
    Languages.chinese: '再试一次',
    Languages.arabic: 'حاول مرة أخرى',
    Languages.japanese: 'もう一度試してみてください',
    Languages.hindi: 'पुनः प्रयास करें',
    Languages.bengal: 'আবার চেষ্টা করুন',
    Languages.german: 'Versuchen Sie es erneut',
    Languages.korean: '다시 시도하세요',
    Languages.italian: 'Riprova',
  },
  AppGlossary.correct: {
    Languages.english: 'Correct',
    Languages.russian: 'Правильно',
    Languages.spanish: 'Correcto',
    Languages.portuguese: 'Correto',
    Languages.turkish: 'Doğru',
    Languages.french: 'Correct',
    Languages.chinese: '正确',
    Languages.arabic: 'صحيح',
    Languages.japanese: '正しい',
    Languages.hindi: 'सही',
    Languages.bengal: 'সঠিক',
    Languages.german: 'Richtig',
    Languages.korean: '올바른',
    Languages.italian: 'Corretto',
  },
  AppGlossary.rewarded: {
    Languages.english: 'Rewarded',
    Languages.russian: 'Награда',
    Languages.spanish: 'Recompensa',
    Languages.portuguese: 'Recompensa',
    Languages.turkish: 'Ödül',
    Languages.french: 'Récompense',
    Languages.chinese: '奖励',
    Languages.arabic: 'مكافأة',
    Languages.japanese: '報酬',
    Languages.hindi: 'पुरस्कार',
    Languages.bengal: 'পুরস্কার',
    Languages.german: 'Belohnung',
    Languages.korean: '보상',
    Languages.italian: 'Riconoscimento',
  },
  AppGlossary.winstrick: {
    Languages.english: 'Winstrick',
    Languages.russian: 'Серия побед',
    Languages.spanish: 'Racha de victorias',
    Languages.portuguese: 'Vencer',
    Languages.turkish: 'Kazanma dizisi',
    Languages.french: 'Série de victoires',
    Languages.chinese: '连胜',
    Languages.arabic: 'سلسلة من الفوز',
    Languages.japanese: '勝ち越し',
    Languages.hindi: 'विजयी श्रृंखला',
    Languages.bengal: 'বিজয়ী সিরিজ',
    Languages.german: 'Siegesserie',
    Languages.korean: '승리 시리즈',
    Languages.italian: 'Vincita',
  },
  AppGlossary.balanceIncreased: {
    Languages.english: 'Balance increased',
    Languages.russian: 'Баланс увеличен',
    Languages.spanish: 'Balance aumentado',
    Languages.portuguese: 'Saldo aumentado',
    Languages.turkish: 'Bakiye artırıldı',
    Languages.french: 'Balance augmenté',
    Languages.chinese: '余额增加',
    Languages.arabic: 'تم تحديث الميزانية',
    Languages.japanese: '残高が増加しました',
    Languages.hindi: 'बैलेंस बढ़ गया',
    Languages.bengal: 'ব্যালেন্স বাড়ে गया',
    Languages.german: 'Balance erhöht',
    Languages.korean: '잔액 증가',
    Languages.italian: 'Saldo aumentato',
  },
  AppGlossary.balanceDecreased: {
    Languages.english: 'Balance decreased',
    Languages.russian: 'Баланс уменьшен',
    Languages.spanish: 'Balance reducido',
    Languages.portuguese: 'Saldo reduzido',
    Languages.turkish: 'Bakiye azaltıldı',
    Languages.french: 'Balance diminué',
    Languages.chinese: '余额减少',
    Languages.arabic: 'تم تحديث الميزانية',
    Languages.japanese: '残高が減少しました',
    Languages.hindi: 'बैलेंस घट गया',
    Languages.bengal: 'ব্যালেন্স কমে গিয়েছে',
    Languages.german: 'Balance verringert',
    Languages.korean: '잔액 감소',
    Languages.italian: 'Saldo ridotto',
  },
  // AppGlossary.convertDuplicateToQr: {
  //   Languages.english: 'Convert duplicate to QR code for your friend? Duplicate will be deleted from your collection',
  //   Languages.russian: 'Конвертировать дубликат в QR код для друга? Дубликат будет удален из вашей коллекции',
  //   Languages.spanish: 'Convertir duplicado en código QR para tu amigo? El duplicado se eliminará de tu colección',
  //   Languages.portuguese: 'Converter duplicado em código QR para seu amigo? O duplicado será excluído da sua coleção',
  //   Languages.turkish: 'Eşdeğer kodu QR koduna dönüştürün? Eşdeğer koleksiyondan kaldırılacak',
  //   Languages.french: 'Convertir le doublon en code QR pour votre ami? Le doublon sera supprimé de votre collection',
  //   Languages.chinese: '将重复项转换为QR码给你的朋友？重复项将从您的收藏中删除',
  //   Languages.arabic: 'قم بتحويل التكرار إلى رمز QR لصديقك؟ سيتم حذف التكرار من مجموعتك',
  //   Languages.japanese: '友人のために重複をQRコードに変換しますか？重複はコレクションから削除されます',
  //   Languages.hindi: 'अपने दोस्त के लिए डुप्लिकेट को QR कोड में बदलें? डुप्लिकेट आपकी संग्रह से हटा दिया जाएगा',
  //   Languages.bengal: 'আপনার বন্ধুর জন্য ডুপ্লিকেটকে QR কোডে রূপান্তর করুন? ডুপ্লিকেট আপনার সংগ্রহ থেকে সরানো হবে',
  //   Languages.german:
  //       'Konvertieren Sie den Duplikat in den QR-Code für Ihren Freund? Das Duplikat wird aus Ihrer Sammlung entfernt',
  //   Languages.korean: '친구를 위해 중복을 QR 코드로 변환합니다. 중복은 컬렉션에서 삭제됩니다',
  //   Languages.italian:
  //       'Converti il duplicato in codice QR per il tuo amico? Il duplicato verrà eliminato dalla tua raccolta',
  // },
  AppGlossary.whatToDoWithDuplicate: {
    Languages.english: 'What to do with card duplicate?',
    Languages.russian: 'Что сделать с дубликатом карточки?',
    Languages.spanish: '¿Qué hacer con la duplicación de tarjeta?',
    Languages.portuguese: 'O que fazer com o duplicado do cartão?',
    Languages.turkish: 'Kart çoğaltması ile ne yapmalısın?',
    Languages.french: 'Que faire avec le doublon de carte?',
    Languages.chinese: '如何处理卡片重复？',
    Languages.arabic: 'ما الذي يجب القيام به مع التكرار البطاقة؟',
    Languages.japanese: 'カードの重複について何をすべきですか？',
    Languages.hindi: 'कार्ड डुप्लिकेट के साथ क्या करना है?',
    Languages.bengal: 'কার্ড ডুপ্লিকেটের সাথে কি করতে হবে?',
    Languages.german: 'Was mit dem Duplikat der Karte zu tun ist?',
    Languages.korean: '카드 중복에 대해 무엇을 해야 합니까?',
    Languages.italian: 'Cosa fare con il duplicato della carta?',
  },
  AppGlossary.shareViaQr: {
    Languages.english: 'Share via QR',
    Languages.russian: 'Передать через QR',
    Languages.spanish: 'Compartir a través de QR',
    Languages.portuguese: 'Compartilhar via QR',
    Languages.turkish: 'QR üzerinden paylaş',
    Languages.french: 'Partager via QR',
    Languages.chinese: '通过QR分享',
    Languages.arabic: 'مشاركة عبر QR',
    Languages.japanese: 'QR経由で共有',
    Languages.hindi: 'QR के माध्यम से साझा करें',
    Languages.bengal: 'QR মাধ্যমে ভাগ করুন',
    Languages.german: 'Über QR teilen',
    Languages.korean: 'QR을 통해 공유',
    Languages.italian: 'Condividi tramite QR',
  },
  AppGlossary.sell: {
    Languages.english: "Sell",
    Languages.russian: "Продать",
    Languages.spanish: "Vender",
    Languages.portuguese: "Vender",
    Languages.turkish: "Sat",
    Languages.french: "Vendre",
    Languages.chinese: "出售",
    Languages.arabic: "بيع",
    Languages.japanese: "売る",
    Languages.hindi: "बेचना",
    Languages.bengal: "বিক্রি করা",
    Languages.german: "Verkaufen",
    Languages.korean: "판매",
    Languages.italian: "Vendi",
  },
  AppGlossary.openQrScannerOnSecondDevice: {
    Languages.english: 'Open QR scanner on second device from side menu and scan code',
    Languages.russian: 'Откройте QR сканер на втором устройстве из бокового меню и отсканируйте код',
    Languages.spanish: 'Abra el escáner QR en el segundo dispositivo desde el menú lateral y escanee el código',
    Languages.portuguese: 'Abra o scanner QR no segundo dispositivo a partir do menu lateral e escaneie o código',
    Languages.turkish: 'İkinci cihazdan yan menüden QR tarayıcısını açın ve kodu tarayın',
    Languages.french: 'Ouvrez le scanner QR sur le deuxième appareil à partir du menu latéral et scannez le code',
    Languages.chinese: '从侧边栏打开第二个设备的QR扫描仪并扫描代码',
    Languages.arabic: 'افتح مسح الباركود على الجهاز الثاني من قائمة القوائم واقرأ الرمز',
    Languages.japanese: '側面メニューから2番目のデバイスでQRスキャナーを開き、コードをスキャンします',
    Languages.hindi: 'दूसरे उपकरण से साइड मेनू से QR स्कैनर खोलें और कोड स्कैन करें',
    Languages.bengal: 'সাইড মেনু থেকে দ্বিতীয় উপকরণ থেকে QR স্ক্যানার খোলুন এবং কোড স্ক্যান করুন',
    Languages.german: 'Öffnen Sie den QR-Scanner auf dem zweiten Gerät aus der Seitenleiste und scannen Sie den Code',
    Languages.korean: '측면 메뉴에서 두 번째 장치에서 QR 스캐너를 열고 코드를 스캔하십시오',
    Languages.italian: 'Apri lo scanner QR sul secondo dispositivo dalla barra laterale e scansiona il codice',
  },
  AppGlossary.scanYourFriendQrToGetPlayer: {
    Languages.english: 'Scan your friend\'s QR to get player',
    Languages.russian: 'Отсканируйте QR код друга, чтобы получить игрока',
    Languages.spanish: 'Escanee el código QR de su amigo para obtener al jugador',
    Languages.portuguese: 'Escaneie o QR do seu amigo para obter o jogador',
    Languages.turkish: 'Arkadaşınızın QR\'sini tarayın ve oyuncuyu alın',
    Languages.french: 'Scannez le QR de votre ami pour obtenir le joueur',
    Languages.chinese: '扫描朋友的QR码获取玩家',
    Languages.arabic: 'اقرأ رمز QR لصديقك للحصول على لاعب',
    Languages.japanese: '友人のQRをスキャンしてプレイヤーを取得します',
    Languages.hindi: 'अपने दोस्त के QR को स्कैन करें और खिलाड़ी प्राप्त करें',
    Languages.bengal: 'আপনার বন্ধুর QR কে স্ক্যান করুন এবং খেলোয়াড় পান',
    Languages.german: 'Scannen Sie den QR-Code Ihres Freundes, um den Spieler zu erhalten',
    Languages.korean: '친구의 QR을 스캔하여 플레이어를 얻으십시오',
    Languages.italian: 'Scansiona il codice QR del tuo amico per ottenere il giocatore',
  },
  AppGlossary.onboardingWelcome: {
    Languages.english: 'Welcome to Football Collection!',
    Languages.russian: 'Добро пожаловать в Football Collection!',
    Languages.spanish: '¡Bienvenido a Football Collection!',
    Languages.portuguese: 'Bem-vindo ao Football Collection!',
    Languages.turkish: 'Football Collection\'e hoş geldiniz!',
    Languages.french: 'Bienvenue à Football Collection!',
    Languages.chinese: '欢迎来到足球收藏！',
    Languages.arabic: 'مرحبًا بك في Football Collection!',
    Languages.japanese: 'Football Collectionへようこそ！',
    Languages.hindi: 'Football Collection में आपका स्वागत है!',
    Languages.bengal: 'ফুটবল কলেকশনে স্বাগতম!',
    Languages.german: 'Willkommen bei Football Collection!',
    Languages.korean: 'Football Collection에 오신 것을 환영합니다!',
    Languages.italian: 'Benvenuto in Football Collection!',
  },
  AppGlossary.onboardingWhoWeAre: {
    Languages.english:
        'We are 2 brothers who love football and we are here to help all world football lovers collect their favorite football cards for free. Cards are divided into packs.',
    Languages.russian:
        'Мы двое братьев, которые любят футбол, и мы здесь, чтобы помочь всем любителям футбола собирать свои любимые футбольные карточки бесплатно. Карты разделены на паки.',
    Languages.spanish:
        'Somos dos hermanos que amamos el fútbol y estamos aquí para ayudar a todos los amantes del fútbol a recopilar sus tarjetas de fútbol favoritas de forma gratuita. Las tarjetas se dividen en paquetes.',
    Languages.portuguese:
        'Somos dois irmãos que amamos o futebol e estamos aqui para ajudar todos os amantes do futebol a colecionar suas cartas de futebol favoritas gratuitamente. As cartas são divididas em pacotes.',
    Languages.turkish:
        'Futbolu sevenen iki kardeşiz ve dünyadaki tüm futbol severlerin favori futbol kartlarını toplamak için buradayız. Kartlar paketlere ayrılır.',
    Languages.french:
        'Nous sommes deux frères qui aiment le football et nous sommes là pour aider tous les amateurs de football à collecter leurs cartes de football favorites gratuitement. Les cartes sont divisées en paquets.',
    Languages.chinese: '我们是一对热爱足球的兄弟，我们在这里帮助所有热爱足球的人免费收集他们最喜欢的足球卡。卡片分为包。',
    Languages.arabic:
        'نحن إخوان يحبون الكرة القدم ونحن هنا لمساعدة كل محبي كرة القدم على تجميع أفضل ألعاب كرة القدم المفضلة للجميع بشكل مجاني. تم تقسيم الألعاب إلى حزم.',
    Languages.japanese: '私たちはサッカーが大好きな兄弟で、世界中のサッカー好きの皆さんが無料でお気に入りのサッカーカードを集めるのを手助けしています。カードはパックに分かれています。',
    Languages.hindi:
        'हम फुटबॉल को प्यार करने वाले दो भाई हैं और हम यहां दुनिया भर के सभी फुटबॉल प्यारियों को मुफ्त में अपनी पसंदीदा फुटबॉल कार्ड एकत्र करने में मदद कर रहे हैं। कार्ड पैक में विभाजित हैं।',
    Languages.bengal:
        'আমরা ফুটবল প্রিয় দুই ভাইয়ের আছি এবং আমরা সবার জন্য মুফতে তাদের প্রিয় ফুটবল কার্ড সংগ্রহ করার জন্য এখানে আছি। কার্ড প্যাকের ভিত্তিতে বিভক্ত।',
    Languages.german:
        'Wir sind zwei Brüder, die Fußball lieben, und wir sind hier, um allen Fußballliebhabern zu helfen, ihre Lieblingsfußballkarten kostenlos zu sammeln. Die Karten werden in Pakete unterteilt.',
    Languages.korean: '우리는 축구를 사랑하는 형제이며, 우리는 모든 축구 팬들이 무료로 자신의 축구 카드를 수집할 수 있도록 여기에 있습니다. 카드는 팩으로 나뉩니다.',
    Languages.italian:
        'Siamo due fratelli che amano il calcio e siamo qui per aiutare tutti gli appassionati di calcio a raccogliere le loro carte di calcio preferite gratuitamente. Le carte sono divise in pacchetti.',
  },
  AppGlossary.onboardingPressPacksButton: {
    Languages.english: 'Press the button below to go to the packs page.',
    Languages.russian: 'Нажмите кнопку ниже, чтобы перейти на страницу открытия пака.',
    Languages.spanish: 'Presiona el botón de abajo para ir a la página de paquetes.',
    Languages.portuguese: 'Pressione o botão abaixo para ir para a página de pacotes.',
    Languages.turkish: 'Aşağıdaki düğmeye basarak paketler sayfasına gidin.',
    Languages.french: 'Appuyez sur le bouton ci-dessous pour accéder à la page des paquets.',
    Languages.chinese: '按下下面的按钮转到包页面。',
    Languages.arabic: 'اضغط على الزر أدناه للانتقال إلى صفحة الحزم.',
    Languages.japanese: '下のボタンを押してパックページに移動します。',
    Languages.hindi: 'नीचे दिए गए बटन पर क्लिक करें और पैकेज पेज पर जाएं।',
    Languages.bengal: 'নীচের বাটনটি টিপে প্যাকেজ পেজে যান।',
    Languages.german: 'Klicken Sie auf die Schaltfläche unten, um zur Paketseite zu gelangen.',
    Languages.korean: '아래의 버튼을 눌러 팩 페이지로 이동하세요.',
    Languages.italian: 'Clicca sul pulsante qui sotto per andare alla pagina dei pacchetti.',
  },
  AppGlossary.onboardingSwipeCardsToSave: {
    Languages.english: 'Swipe cards to save!',
    Languages.russian: 'Смахните карточку, чтобы ее сохранить!',
    Languages.spanish: '¡Desliza las tarjetas para guardarlas!',
    Languages.portuguese: 'Arraste as cartas para salvar!',
    Languages.turkish: 'Kartları kaydetmek için kaydırın!',
    Languages.french: 'Faites glisser les cartes pour les sauvegarder !',
    Languages.chinese: '滑动卡片以保存！',
    Languages.arabic: 'اسحب البطاقات لحفظها!',
    Languages.japanese: 'カードをスワイプして保存！',
    Languages.hindi: 'कार्ड सहेजने के लिए कार्ड स्वाइप करें!',
    Languages.bengal: 'কার্ড সংরক্ষণ করতে কার্ড স্ক্রুপ করুন!',
    Languages.german: 'Schieben Sie die Karten, um sie zu speichern!',
    Languages.korean: '카드를 스와이프하여 저장하세요!',
    Languages.italian: 'Scorri le carte per salvarle!',
  },
  AppGlossary.onboardingEverySwipedCardWillBeSavedYouCanSwipeAnyDirection: {
    Languages.english: 'Every card you swipe will be saved in your collection. You can swipe in any direction.',
    Languages.russian:
        'Каждая карта, которую вы смахнете, будет сохранена в вашей коллекции. Вы можете смахнуть в любом направлении.',
    Languages.spanish: 'Cada tarjeta que desliza se guardará en tu colección. Puedes deslizar en cualquier dirección.',
    Languages.portuguese:
        'Todas as cartas que deslizar serão salvas em sua coleção. Você pode deslizar em qualquer direção.',
    Languages.turkish:
        'Sürüklediğiniz her kartınızın koleksiyonunuzda saklanacağını unutmayın. Herhangi bir yönde sürükleyebilirsiniz.',
    Languages.french:
        'Chaque carte que vous ferez glisser sera enregistrée dans votre collection. Vous pouvez faire glisser dans n\'importe quelle direction.',
    Languages.chinese: '您滑动过的每张卡片都将保存在您的收藏中。您可以在任何方向上滑动。',
    Languages.arabic: 'سيتم حفظ كل بطاقة تمسحها في مجموعتك. يمكنك التمسك بأي اتجاه.',
    Languages.japanese: 'スワイプしたカードはすべてコレクションに保存されます。どの方向にもスワイプできます。',
    Languages.hindi:
        'आप स्वाइप किए गए प्रत्येक कार्ड आपकी संग्रह में सहेजा जाएगा। आप किसी भी दिशा में स्वाइप कर सकते हैं।',
    Languages.bengal: 'আপনি স্ক্রুপ করা প্রতিটি কার্ড আপনার সংগ্রহে সংরক্ষিত হবে। আপনি যে কোন দিকে স্ক্রুপ করতে পারেন।',
    Languages.german:
        'Jedes Karte, die Sie schieben, wird in Ihrer Sammlung gespeichert. Sie können in jede Richtung schieben.',
    Languages.korean: '스와이프한 모든 카드는 컬렉션에 저장됩니다. 어떤 방향으로든 스와이프할 수 있습니다.',
    Languages.italian: 'Ogni carta che scuoti verrà salvata nella tua raccolta. Puoi scuotere in qualsiasi direzione.',
  },
  AppGlossary.onboardingCardsAreSaved: {
    Languages.english: 'Now cards are saved in your collection!',
    Languages.russian: 'Теперь карты сохранены в вашей коллекции!',
    Languages.spanish: '¡Ahora las tarjetas se guardan en tu colección!',
    Languages.portuguese: 'Agora as cartas são salvas em sua coleção!',
    Languages.turkish: 'Artık kartlarınız koleksiyonunuzda saklanıyor!',
    Languages.french: 'Maintenant, les cartes sont sauvegardées dans votre collection !',
    Languages.chinese: '现在卡片已保存到您的收藏中！',
    Languages.arabic: 'الآن تم حفظ البطاقات في مجموعتك!',
    Languages.japanese: '今カードはコレクションに保存されています！',
    Languages.hindi: 'अब कार्ड आपकी संग्रह में सहेजे गए हैं!',
    Languages.bengal: 'এখন কার্ড আপনার সংগ্রহে সংরক্ষিত হয়েছে!',
    Languages.german: 'Jetzt werden die Karten in Ihrer Sammlung gespeichert!',
    Languages.korean: '이제 카드가 컬렉션에 저장되었습니다!',
    Languages.italian: 'Ora le carte sono salvate nella tua raccolta!',
  },
  AppGlossary.onboardingTapOnCardToSeeInfo: {
    Languages.english: 'Tap on a card to see more information about it.',
    Languages.russian: 'Нажмите на карточку, чтобы узнать больше о ней.',
    Languages.spanish: 'Toca en una tarjeta para ver más información sobre ella.',
    Languages.portuguese: 'Toque em uma carta para ver mais informações sobre ela.',
    Languages.turkish: 'Kartın üzerine dokunun ve daha fazla bilgi görün.',
    Languages.french: 'Appuyez sur une carte pour en voir plus d\'informations.',
    Languages.chinese: '点击卡片以查看更多信息。',
    Languages.arabic: 'انقر على بطاقة لمعرفة المزيد من المعلومات عنها.',
    Languages.japanese: 'カードをタップして詳細を確認します。',
    Languages.hindi: 'कार्ड पर टैप करें और इसके बारे में अधिक जानकारी प्राप्त करें।',
    Languages.bengal: 'কার্ডে ট্যাপ করুন এবং এর সম্পর্কে আরও তথ্য পেনে যান।',
    Languages.german: 'Tippen Sie auf eine Karte, um mehr über sie zu erfahren.',
    Languages.korean: '카드를 탭하여 자세한 정보를 확인하세요.',
    Languages.italian: 'Tocca su una carta per vedere ulteriori informazioni su di essa.',
  },
  AppGlossary.next: {
    Languages.english: 'Next',
    Languages.russian: 'Далее',
    Languages.spanish: 'Siguiente',
    Languages.portuguese: 'Próximo',
    Languages.turkish: 'Sonraki',
    Languages.french: 'Suivant',
    Languages.chinese: '下一个',
    Languages.arabic: 'التالي',
    Languages.japanese: '次へ',
    Languages.hindi: 'अगला',
    Languages.bengal: 'পরবর্তী',
    Languages.german: 'Nächster',
    Languages.korean: '다음',
    Languages.italian: 'Successivo',
  },
  AppGlossary.onboardingShareCardsWithFriendsOrSell: {
    Languages.english: 'Share  cards with friends or sell!',
    Languages.russian: 'Поделитесь карточками с друзьями или продайте!',
    Languages.spanish: '¡Comparte tarjetas con amigos o vende!',
    Languages.portuguese: 'Compartilhe cartas com amigos ou venda!',
    Languages.turkish: 'Arkadaşlarınızla veya satın alın!',
    Languages.french: 'Partagez des cartes avec vos amis ou vendez-les !',
    Languages.chinese: '与朋友分享卡片或出售！',
    Languages.arabic: 'شارك البطاقات مع أصدقائك أو اشتريها!',
    Languages.japanese: '友達とカードを共有するか、売却する！',
    Languages.hindi: 'दोस्तों के साथ कार्ड साझा करें या बेचें!',
    Languages.bengal: 'বন্ধুদের সাথে কার্ড শেয়ার করুন বা বিক্রি করুন!',
    Languages.german: 'Teile Karten mit Ihren Freunden oder verkaufen!',
    Languages.korean: '친구들과 카드를 공유하거나 판매하세요!',
    Languages.italian: 'Condividi le carte con i tuoi amici o vendile!',
  },
  AppGlossary.onboardingShareCardsWithFriendsOrSellDescription: {
    Languages.english:
        'Sometimes you can find a card that you already have. You can share it with your friends or sell. Just tap on count label.',
    Languages.russian:
        'Иногда вы можете найти карточку, которую уже имеете. Вы можете поделиться ею со своими друзьями или продать. Просто нажмите на метку количества.',
    Languages.spanish:
        'A veces puedes encontrar una tarjeta que ya tienes. Puedes compartirla con tus amigos o vendérsela. Simplemente toca en la etiqueta de recuento.',
    Languages.portuguese:
        'Às vezes você pode encontrar uma carta que você já tem. Você pode compartilhar com seus amigos ou vendê-la. Basta tocar na etiqueta de contagem.',
    Languages.turkish:
        'Bazen zaten sahip olduğunuz bir kart bulabilirsiniz. Arkadaşlarınızla paylaşabilir veya satabilirsiniz. Sadece sayı etiketine dokunun.',
    Languages.french:
        'Parfois, vous pouvez trouver une carte que vous avez déjà. Vous pouvez la partager avec vos amis ou la vendre. Cliquez simplement sur l\'étiquette de comptage.',
    Languages.chinese: '有时您可能会找到一张您已经拥有的卡片。您可以与朋友分享或出售它。只需点击计数标签。',
    Languages.arabic:
        'أحيانًا يمكنك العثور على بطاقة قمت بالحصول عليها مسبقًا. يمكنك مشاركتها مع أصدقائك أو إيجارها. فقط اضغط على علامة العد.',
    Languages.japanese: '時々、すでに持っているカードを見つけることができます。友達と共有したり、売却したりできます。カウントラベルをタップしてください。',
    Languages.hindi:
        'कभी-कभी आप एक कार्ड पा सकते हैं जिसे आप पहले से ही हैं। आप इसे अपने दोस्तों के साथ साझा कर सकते हैं या बेच सकते हैं। बस गिनती लेबल पर टैप करें।',
    Languages.bengal:
        'কখনোই আপনি একটি কার্ড পাওয়া যায় যা আপনি ইতিমধ্যে আপণ আছে। আপনি এটি আপনার বন্ধুদের সাথে ভাগ করতে পারেন বা বিক্রি করতে পারেন। শুধু গণনা লেবেলে ট্যাপ করুন।',
    Languages.german:
        'Manchmal können Sie eine Karte finden, die Sie bereits haben. Sie können sie mit Ihren Freunden teilen oder verkaufen. Tippen Sie einfach auf die Anzahl-Bezeichnung.',
    Languages.korean: '때로는 이미 보유 중인 카드를 찾을 수 있습니다. 친구들과 공유하거나 판매할 수 있습니다. 단순히 수량 레이블을 탭하세요.',
    Languages.italian:
        'A volte puoi trovare una carta che hai già. Puoi condividerla con i tuoi amici o vendere. Basta toccare l\'etichetta di conteggio.',
  },
  AppGlossary.onboardingStartCollectioning: {
    Languages.english: 'Start collecting',
    Languages.russian: 'Начните коллекционировать',
    Languages.spanish: 'Comienza a recopilar',
    Languages.portuguese: 'Comece a coletar',
    Languages.turkish: 'Toplayın başlayın',
    Languages.french: 'Commencer à collecter',
    Languages.chinese: '开始收集',
    Languages.arabic: 'ابدأ التجميع',
    Languages.japanese: 'コレクションを開始',
    Languages.hindi: 'संग्रह शुरू करें',
    Languages.bengal: 'সংগ্রহ শুরু করুন',
    Languages.german: 'Beginne zu sammeln',
    Languages.korean: '수집 시작',
    Languages.italian: 'Inizia a raccogliere',
  },
  AppGlossary.onboardingTapOnPackToOpenIt: {
    Languages.english: 'Tap on the pack to open it.',
    Languages.russian: 'Нажмите на пак, чтобы открыть его.',
    Languages.spanish: 'Toque en el paquete para abrirlo.',
    Languages.portuguese: 'Toque no pacote para abri-lo.',
    Languages.turkish: 'Paketi açmak için tıklayın.',
    Languages.french: 'Appuyez sur le paquet pour l\'ouvrir.',
    Languages.chinese: '点击包以打开它。',
    Languages.arabic: 'انقر فوق الحزمة لفتحها.',
    Languages.japanese: 'パックをタップして開きます。',
    Languages.hindi: 'इसे खोलने के लिए पैक पर टैप करें।',
    Languages.bengal: 'এটি খোলার জন্য প্যাকের উপর ট্যাপ করুন।',
    Languages.german: 'Klicken Sie auf das Paket, um es zu öffnen.',
    Languages.korean: '팩을 탭하여 열 수 있습니다.',
    Languages.italian: 'Tocca sul pacchetto per aprirlo.',
  },
  AppGlossary.onboardingOpenPacks: {
    Languages.english: 'Open packs!',
    Languages.russian: 'Открывайте паки!',
    Languages.spanish: '¡Abra los paquetes!',
    Languages.portuguese: 'Abra os pacotes!',
    Languages.turkish: 'Paketleri açın!',
    Languages.french: 'Ouvrez les paquets !',
    Languages.chinese: '打开包！',
    Languages.arabic: 'افتح الحزم!',
    Languages.japanese: 'パックを開きます！',
    Languages.hindi: 'पैक खोलें!',
    Languages.bengal: 'প্যাক খোলুন!',
    Languages.german: 'Packungen öffnen!',
    Languages.korean: '팩을 열어!',
    Languages.italian: 'Apri i pacchetti!',
  },
  AppGlossary.settingsVibrationOnPackOpening: {
    Languages.english: 'Vibration on pack opening',
    Languages.russian: 'Вибрация при открытии пака',
    Languages.spanish: 'Vibración al abrir el paquete',
    Languages.portuguese: 'Vibração ao abrir o pacote',
    Languages.turkish: 'Paket açılışında titreşim',
    Languages.french: 'Vibration au déballage du paquet',
    Languages.chinese: '包打开时的振动',
    Languages.arabic: 'تذبذب عند فتح الحزمة',
    Languages.japanese: 'パックを開くときの振動',
    Languages.hindi: 'पैक खोलने पर दौलन',
    Languages.bengal: 'প্যাকের খোলার সময়ে ঝগড়া',
    Languages.german: 'Vibration beim Öffnen des Pakets',
    Languages.korean: '팩을 열 때 진동',
    Languages.italian: 'Vibrazione all\'apertura del pacchetto',
  },
  AppGlossary.ourWebsite: {
    Languages.english: 'Our website',
    Languages.russian: 'Наш веб-сайт',
    Languages.spanish: 'Nuestro sitio web',
    Languages.portuguese: 'Nosso site',
    Languages.turkish: 'Web sitesi',
    Languages.french: 'Notre site web',
    Languages.chinese: '我们的网站',
    Languages.arabic: 'موقعنا',
    Languages.japanese: '私たちのウェブサイト',
    Languages.hindi: 'हमारा वेबसाइट',
    Languages.bengal: 'আমাদের ওয়েবসাইট',
    Languages.german: 'Unsere Website',
    Languages.korean: '우리 웹사이트',
    Languages.italian: 'Il nostro sito web',
  },
};
