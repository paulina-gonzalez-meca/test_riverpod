import 'package:go_router/go_router.dart';
import 'package:test_riverpod/screens/login.dart';
import 'package:test_riverpod/screens/register.dart'; // Import RegisterScreen
import 'package:test_riverpod/screens/results.dart';
import 'package:test_riverpod/screens/details.dart';
import 'package:test_riverpod/screens/edit.dart';
import 'package:test_riverpod/entities/product.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/results', builder: (context, state) => ResultsScreen()),
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
        final product = state.extra as Product;
        return DetailsScreen(product: product);
      },
    ),
  ],
);