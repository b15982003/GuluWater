import 'package:gulu_water/data/water_db_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:gulu_water/service/share_database.dart';


Future<void> setupDbHelper() async{
  GetIt.instance.registerSingleton<WaterDbHelper>(
    WaterDbHelper(),
  );

  GetIt.instance.registerSingleton<ShareDataBase>(
    ShareDataBase(),
  );
}