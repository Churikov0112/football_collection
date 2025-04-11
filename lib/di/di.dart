import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async {
  $initGetIt(getIt);

  // bool gsEnabled = false;
  // if (Platform.isAndroid) {
  //   const platform = MethodChannel('android_utils_channel');
  //   gsEnabled = await platform.invokeMethod('checkGoogleServicesAvailability');
  // }
}
