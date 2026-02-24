import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Services
import 'package:project/core/services/storage_service.dart';
import 'package:project/core/services/api_service.dart';
import 'package:project/core/services/auth_service.dart';

// Repositories
import 'package:project/repositories/auth_repository.dart';

// Providers
import 'package:project/data/providers/auth_provider.dart';
import 'package:project/data/providers/user_provider.dart';

// Screens
import 'package:project/presentation/screens/splash_screen.dart';

// Global Variables
late StorageService storageService;
late ApiService apiService;
late AuthService authService;

late AuthRepository authRepository;

late AuthProvider authProvider;
late UserProvider userProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // System UI overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // ============ INITIALIZE SERVICES ============
  storageService = StorageService();
  await storageService.init();

  apiService = ApiService(storageService: storageService);
  authService = AuthService(apiService: apiService, storageService: storageService);


  // ============ INITIALIZE REPOSITORIES ============
  authRepository = AuthRepository(authService: authService);

  // ============ INITIALIZE PROVIDERS ============
  authProvider = AuthProvider(authRepository: authRepository);
  
  final prefs = await SharedPreferences.getInstance();
  userProvider = UserProvider(prefs);

  runApp(const GoCabApp());
}

class GoCabApp extends StatelessWidget {
  const GoCabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        Provider<ApiService>.value(value: apiService),
        Provider<AuthService>.value(value: authService),

        Provider<AuthRepository>.value(value: authRepository),

        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
      ],
      child: MaterialApp(
        title: 'GbatCar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Outfit',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
