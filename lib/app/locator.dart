import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'locator.config.dart';

GetIt locator = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void setupLocator() => locator.init();
