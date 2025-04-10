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
  convertDuplicateToQr,
  openQrScannerOnSecondDevice,
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
  AppGlossary.convertDuplicateToQr: {
    Languages.english: 'Convert duplicate to QR code for your friend? Duplicate will be deleted from your collection',
    Languages.russian: 'Конвертировать дубликат в QR код для друга? Дубликат будет удален из вашей коллекции',
    Languages.spanish: 'Convertir duplicado en código QR para tu amigo? El duplicado se eliminará de tu colección',
    Languages.portuguese: 'Converter duplicado em código QR para seu amigo? O duplicado será excluído da sua coleção',
    Languages.turkish: 'Eşdeğer kodu QR koduna dönüştürün? Eşdeğer koleksiyondan kaldırılacak',
    Languages.french: 'Convertir le doublon en code QR pour votre ami? Le doublon sera supprimé de votre collection',
    Languages.chinese: '将重复项转换为QR码给你的朋友？重复项将从您的收藏中删除',
    Languages.arabic: 'قم بتحويل التكرار إلى رمز QR لصديقك؟ سيتم حذف التكرار من مجموعتك',
    Languages.japanese: '友人のために重複をQRコードに変換しますか？重複はコレクションから削除されます',
    Languages.hindi: 'अपने दोस्त के लिए डुप्लिकेट को QR कोड में बदलें? डुप्लिकेट आपकी संग्रह से हटा दिया जाएगा',
    Languages.bengal: 'আপনার বন্ধুর জন্য ডুপ্লিকেটকে QR কোডে রূপান্তর করুন? ডুপ্লিকেট আপনার সংগ্রহ থেকে সরানো হবে',
    Languages.german:
        'Konvertieren Sie den Duplikat in den QR-Code für Ihren Freund? Das Duplikat wird aus Ihrer Sammlung entfernt',
    Languages.korean: '친구를 위해 중복을 QR 코드로 변환합니다. 중복은 컬렉션에서 삭제됩니다',
    Languages.italian:
        'Converti il duplicato in codice QR per il tuo amico? Il duplicato verrà eliminato dalla tua raccolta',
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
  }
};
