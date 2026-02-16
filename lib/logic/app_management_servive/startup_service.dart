import 'package:live_match/logic/locator.dart';

class StartupService {
  init() async {
    await Locator.hiveService.init();
    await Locator.firestoreService.init();
    await setupApplicationData();
    await Locator.userManagementService.init();

  }

  setupApplicationData() async {
    if (Locator.hiveService.userBox!.isNotEmpty) {
      var userModel = await Locator.userDatabaseService.readUserFromLocal();
      Locator.userManagementService.userData.value = userModel!;
       //  await syncProductData();

      }
    }
  }



  // syncClientData() async {
  //   if (Locator.userManagementService.userData.value != null &&
  //       Locator.companyManagementService.companyData.value != null) {
  //     var localLastModified =
  //         Locator.clientDatabaseService.getLocalDbLastModified();
  //     var remoteLastModified =
  //         await Locator.clientDatabaseService.getRemoteDbLastModified();
  //     if (localLastModified != null) {
  //       if (remoteLastModified.isAfter(localLastModified)) {
  //         await Locator.clientDatabaseService.fetchClients(localLastModified);
  //       }
  //       var localLastModifiedAfterFetch =
  //           Locator.clientDatabaseService.getLocalDbLastModified();
  //       Locator.clientDatabaseService
  //           .streamRemoteToLocal(localLastModifiedAfterFetch!);
  //     }
  //   }
  // }


