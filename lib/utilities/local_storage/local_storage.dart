import 'package:get_storage/get_storage.dart';

class AppLocalStorage{

  static final AppLocalStorage _instance = AppLocalStorage._internal();

  factory AppLocalStorage() {
    return _instance;
  }

  AppLocalStorage._internal();

  final _storage=GetStorage();

  //Generic method to save data
  Future<void> saveData<App>(String key, App value) async{
    await _storage.write(key, value);
  }

  //Generic method to read data
  App? readData<App>(String key){
    return _storage.read<App>(key);
  }

  //Generic method to remove data
  Future<void> removeData(String key) async{
    await _storage.remove(key);
  }

  //clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
}
}
