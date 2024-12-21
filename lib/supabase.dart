import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:TaskRM/utils/config/app_config.dart';

loadSupabase() async {
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );
}
