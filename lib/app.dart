import 'package:flutter/material.dart';
import 'package:rest_api_read_write/product_list_screen.dart';
import 'package:device_preview_minus/device_preview_minus.dart';

class CrudApp extends StatelessWidget{
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Crud App',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: const ProductListScreen(),
      themeMode: ThemeMode.system,
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
    );  }

  ThemeData _lightThemeData(){
    return ThemeData(
      brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.purple.shade200,width: 2)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.greenAccent.shade400,width: 2)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red,width: 2)
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,width: 2
                )
            )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),

                ),
                backgroundColor: Colors.purple.shade200,
                foregroundColor: Colors.white
            )
        )
    );

  }

  ThemeData _darkThemeData(){
    return ThemeData(
      brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.purple.shade200,width: 2)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.greenAccent.shade400,width: 2)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red,width: 2)
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,width: 2
                )
            )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),

                ),
                backgroundColor: Colors.purple.shade200,
                foregroundColor: Colors.white
            )
        )
    );

}
}