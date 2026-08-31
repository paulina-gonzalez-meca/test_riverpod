import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_riverpod/entities/product.dart';
import 'package:test_riverpod/providers/provider.dart';

class EditScreen extends ConsumerStatefulWidget {
  final Product? product;

  const EditScreen({super.key, this.product});

  @override
  ConsumerState<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _typeController;
  late final TextEditingController _priceController;
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    // Cargar datos del producto si se va a editar
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    _typeController = TextEditingController(text: widget.product?.type ?? '');
    _priceController = TextEditingController(
      text: widget.product != null ? widget.product!.price.toString() : '',
    );
    _urlController = TextEditingController(text: widget.product?.url ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _priceController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Si existe se conserva la ID actual, de lo contrario se genera una basada en marcas de tiempo
      final String id = widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString();

      final updatedProduct = Product(
        id: id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        type: _typeController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        url: _urlController.text.trim().isEmpty
            ? 'https://via.placeholder.com/150'
            : _urlController.text.trim(),
      );

      if (widget.product != null) {
        // Editar producto existente
        ref
            .read(productsProvider.notifier)
            .updateProduct(widget.product!, updatedProduct);
      } else {
        // Crear nuevo producto
        ref.read(productsProvider.notifier).addProduct(updatedProduct);
      }

      // Regresar a la pantalla anterior
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Producto' : 'Agregar Nuevo Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre del producto'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese un nombre' : null,
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'Tipo / Categoría'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese un tipo/categoría' : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Por favor ingrese una descripción' : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Por favor ingrese un precio';
                    if (double.tryParse(value) == null) return 'Ingrese un número válido';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _urlController,
                  decoration: const InputDecoration(labelText: 'URL de la imagen'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: Text(isEditing ? 'Guardar Cambios' : 'Guardar Producto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}