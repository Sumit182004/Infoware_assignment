import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/blocs/product_bloc.dart';

import 'package:internship_assignment/respositories/product_api_service.dart';
import 'package:internship_assignment/respositories/product_respository.dart';
import 'package:internship_assignment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productRepository: ProductRepository(ProductApiService()),
      )..add(FetchProducts()),
      child: MaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
