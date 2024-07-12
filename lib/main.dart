import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/controller/home_cubit.dart';
import 'features/home/presentation/screens/layout_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false,create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const LayOutScreen(),
      ),
    );
  }
}


