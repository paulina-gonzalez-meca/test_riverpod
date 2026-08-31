import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_riverpod/providers/provider.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escucha las actualizaciones del estado desde Riverpod
    final productList = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              // Si fue abierto con push va a la pantalla anterior,
              // o bien redirige directamente al Login con context.go('/login')
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Lista de productos:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product.url,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                    title: Text(product.name),
                    subtitle: Text("Categoría: ${product.type}\nToca para ver más información."),
                    onTap: () {
                      context.push('/details', extra: product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/edit');
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar producto'),
      ),
    );
  }
}