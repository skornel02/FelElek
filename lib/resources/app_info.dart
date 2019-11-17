import 'package:package_info/package_info.dart';

class FelElekAppInfo{

  static final FelElekAppInfo _singleton = new FelElekAppInfo._internal();
  factory FelElekAppInfo() {
    return _singleton;
  }
  FelElekAppInfo._internal();

  PackageInfo _packageInfo;


  PackageInfo get getInfo{
    if(_packageInfo != null){
      return _packageInfo;
    }
    throw Exception("packageInfo was not initalized");
  }

  Future<PackageInfo> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo;
  }

}