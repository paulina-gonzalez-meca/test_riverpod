import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_riverpod/entities/product.dart';
import 'package:test_riverpod/providers/provider.dart';

class DetailsScreen extends ConsumerWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  product.url,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nombre: ${product.name}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text('Tipo / Categoría: ${product.type}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Text('Descripción: ${product.description}',
                  style: const TextStyle(fontSize: 16)),
              Text('Precio: \$${product.price}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.push('/edit', extra: product);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ref.read(productsProvider.notifier).deleteProduct(product);
                      context.pop();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}