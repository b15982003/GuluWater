import 'package:gulu_water/data/WaterDbHelper.dart';
import 'package:get_it/get_it.dart';


Future<void> setupDbHelper() async{
  GetIt.instance.registerSingleton<WaterDbHelper>(
    WaterDbHelper(),
  );
}