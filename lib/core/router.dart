import 'package:go_router/go_router.dart';

// Screens
import 'package:test_riverpod/screens/login.dart';
import 'package:test_riverpod/screens/results.dart';
import 'package:test_riverpod/screens/details.dart';
import 'package:test_riverpod/screens/edit.dart';
import 'package:test_riverpod/entities/product.dart';

// riverpod
// ignore: unused_import
import 'package:test_riverpod/providers/provider.dart';


final GoRouter appRouter = GoRouter(
initialLocation: '/login',

routes:
[
GoRoute(path: '/login', builder: (context,state) => const LoginScreen()),
GoRoute(path: '/results', builder: (context,state) => ResultsScreen()), 
GoRoute(
      path: '/edit',
      builder: (context, state) {
      final product = state.extra as Product?;
      return EditScreen(product: product);
      },
    ),
GoRoute(
      path: '/details',
      builder: (context, state) {
        // Retrieve the single Product passed via context.push
        final product = state.extra as Product;
        
        return DetailsScreen(
          product: product, // Make sure your DetailsScreen accepts a single Product!
        );
      },
    ),
]

);