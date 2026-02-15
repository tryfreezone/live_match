


import 'package:live_match/data/data_model/user_model.dart';

class HiveService{
  Box<UserModel>? userBox;

  


  init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());

    userBox=await Hive.openBox<UserModel>("userBox");

}
   
  clearAllBox()
  {
    userBox?.clear();

  }
}
