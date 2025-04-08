import 'package:flutter/material.dart';

enum Languages { ru, en }

extension LanguagesExtension on Languages {
  String toShortString() {
    switch (this) {
      case Languages.en:
        return 'en-EN';
      case Languages.ru:
        return 'ru-RU';
    }
  }

  Locale get locale {
    switch (this) {
      case Languages.en:
        return const Locale('en', 'US');
      case Languages.ru:
        return const Locale('ru', 'RU');
    }
  }

  String get name {
    switch (this) {
      case Languages.en:
        return 'English';
      case Languages.ru:
        return 'Русский';
    }
  }

  String get emoji {
    switch (this) {
      case Languages.en:
        return '🇺🇸';
      case Languages.ru:
        return '🇷🇺';
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
    Languages.en: 'Language',
    Languages.ru: 'Язык',
  },
  AppGlossary.settings: {
    Languages.en: 'Settings',
    Languages.ru: 'Настройки',
  },
  AppGlossary.miniGames: {
    Languages.en: 'Mini Games',
    Languages.ru: 'Мини игры',
  },
  AppGlossary.openPack: {
    Languages.en: 'Open pack',
    Languages.ru: 'Открыть пак',
  },
  AppGlossary.scanQr: {
    Languages.en: 'Scan QR',
    Languages.ru: 'Сканировать QR',
  },
  AppGlossary.cheatCodes: {
    Languages.en: 'Cheat codes',
    Languages.ru: 'Чит коды',
  },
  AppGlossary.cheatCodeActivated: {
    Languages.en: 'Cheat code activated',
    Languages.ru: 'Чит код активирован',
  },
  AppGlossary.cheatCodeNotFound: {
    Languages.en: 'Cheat code not found',
    Languages.ru: 'Чит код не найден',
  },
  AppGlossary.about: {
    Languages.en: 'About',
    Languages.ru: 'О приложении',
  },
  AppGlossary.webVersion: {
    Languages.en: 'Web version',
    Languages.ru: 'Веб версия',
  },
  AppGlossary.cheatCodeHere: {
    Languages.en: 'Cheat code here',
    Languages.ru: 'Чит код',
  },
  AppGlossary.continents: {
    Languages.en: 'Continents',
    Languages.ru: 'Континенты',
  },
  AppGlossary.europe: {
    Languages.en: 'Europe',
    Languages.ru: 'Европа',
  },
  AppGlossary.africa: {
    Languages.en: 'Africa',
    Languages.ru: 'Африка',
  },
  AppGlossary.asia: {
    Languages.en: 'Asia',
    Languages.ru: 'Азия',
  },
  AppGlossary.northAmerica: {
    Languages.en: 'North America',
    Languages.ru: 'Северная Америка',
  },
  AppGlossary.southAmerica: {
    Languages.en: 'South America',
    Languages.ru: 'Южная Америка',
  },
  AppGlossary.oceania: {
    Languages.en: 'Oceania',
    Languages.ru: 'Океания',
  },
  AppGlossary.free: {
    Languages.en: 'Free',
    Languages.ru: 'Бесплатно',
  },
  AppGlossary.confirmToBuyPackFor: {
    Languages.en: 'Confirm to buy pack for',
    Languages.ru: 'Подтвердить покупку пака за',
  },
  AppGlossary.confirm: {
    Languages.en: 'Confirm',
    Languages.ru: 'Подтвердить',
  },
  AppGlossary.cancel: {
    Languages.en: 'Cancel',
    Languages.ru: 'Отменить',
  },
  AppGlossary.youHaveNotEnoughMoneyToBuyPack: {
    Languages.en: 'You have not enough 🏆 to buy pack',
    Languages.ru: 'У вас недостаточно 🏆 для покупки пака',
  },
  AppGlossary.playMiniGames: {
    Languages.en: 'Play mini games',
    Languages.ru: 'Играть в мини игры',
  },
  AppGlossary.watchAd: {
    Languages.en: 'Watch ad',
    Languages.ru: 'Смотреть рекламу',
  },
  AppGlossary.guessTransferValue: {
    Languages.en: 'Guess transfer value',
    Languages.ru: 'Угадай цену',
  },
  AppGlossary.whoCostsMore: {
    Languages.en: 'Who costs more',
    Languages.ru: 'Кто дороже',
  },
  AppGlossary.guessWhichPlayerIsMoreExpensive: {
    Languages.en: 'Guess which player is more expensive',
    Languages.ru: 'Угадайте, кто дороже',
  },
  AppGlossary.left: {
    Languages.en: 'Left',
    Languages.ru: 'Левый',
  },
  AppGlossary.right: {
    Languages.en: 'Right',
    Languages.ru: 'Правый',
  },
  AppGlossary.equal: {
    Languages.en: 'Equal',
    Languages.ru: 'Одинаково',
  },
  AppGlossary.incorrect: {
    Languages.en: 'Incorrect',
    Languages.ru: 'Неправильно',
  },
  AppGlossary.tryAgain: {
    Languages.en: 'Try again',
    Languages.ru: 'Попробуйте снова',
  },
  AppGlossary.correct: {
    Languages.en: 'Correct',
    Languages.ru: 'Правильно',
  },
  AppGlossary.rewarded: {
    Languages.en: 'Rewarded',
    Languages.ru: 'Награда',
  },
  AppGlossary.winstrick: {
    Languages.en: 'Winstrick',
    Languages.ru: 'Серия побед',
  },
  AppGlossary.balanceIncreased: {
    Languages.en: 'Balance increased',
    Languages.ru: 'Баланс увеличен',
  },
  AppGlossary.balanceDecreased: {
    Languages.en: 'Balance decreased',
    Languages.ru: 'Баланс уменьшен',
  },
  AppGlossary.convertDuplicateToQr: {
    Languages.en: 'Convert duplicate to QR code for your friend? Duplicate will be deleted from your collection',
    Languages.ru: 'Конвертировать дубликат в QR код для друга? Дубликат будет удален из вашей коллекции',
  },
  AppGlossary.openQrScannerOnSecondDevice: {
    Languages.en: 'Open QR scanner on second device from side menu and scan code',
    Languages.ru: 'Откройте QR сканер на втором устройстве из бокового меню и отсканируйте код',
  },
  AppGlossary.scanYourFriendQrToGetPlayer: {
    Languages.en: 'Scan your friend\'s QR to get player',
    Languages.ru: 'Отсканируйте QR код друга, чтобы получить игрока',
  }
};
