

import 'package:get_it/get_it.dart';
import 'package:live_match/data/database_service/user_database_service.dart';
import 'package:live_match/logic/app_management_servive/firestore_service.dart';
import 'package:live_match/logic/app_management_servive/hive_service.dart';
import 'package:live_match/logic/app_management_servive/navigation_service.dart';
import 'package:live_match/logic/app_management_servive/startup_service.dart';
import 'package:live_match/logic/data_management_service/user_management_service.dart';

class Locator {
  static void setup() {
    //Support Services
    GetIt.instance.registerLazySingleton(() => StartupService());
    GetIt.instance.registerLazySingleton(() => HiveService());
    GetIt.instance.registerLazySingleton(() => FirestoreService());
    GetIt.instance.registerLazySingleton(() => NavigationService());

    //databaseServices
    GetIt.instance.registerLazySingleton(() => UserDatabaseService());
   

    //DataManagementServices
    GetIt.instance.registerLazySingleton(() => UserManagementService());
    
  }

  //Support Services
  static StartupService get startupService => GetIt.I<StartupService>();
  static HiveService get hiveService => GetIt.I<HiveService>();
  static FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  static NavigationService get navigationService =>
      GetIt.I<NavigationService>();

  //databaseServices
  static UserDatabaseService get userDatabaseService =>
      GetIt.I<UserDatabaseService>();


  //DataManagementServices
  static UserManagementService get userManagementService =>
      GetIt.I<UserManagementService>();
 
}
