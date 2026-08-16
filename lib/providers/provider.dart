import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_riverpod/entities/product.dart';

// -----------------------------------------------------------------------------
// 1. Users Provider (Read-only)
// -----------------------------------------------------------------------------
class UsersNotifier extends Notifier<List<User>> {
  @override
  List<User> build() {
    return [
      User(email: "user123@gmail.com", password: "pass1234", name: "Usuario1"),
      User(email: "Usuario@gmail.com", password: "adm123", name: "Usuario2"),
    ];
  }

  void addUser(User user) {
    state = [...state, user];
  }
}

final usersProvider = NotifierProvider<UsersNotifier, List<User>>(UsersNotifier.new);
// -----------------------------------------------------------------------------
// 2. Products Provider (Stateful list using Riverpod Notifier)
// -----------------------------------------------------------------------------
class ProductsNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [
      Product(
        name: "Fideos instantáneos",
        description: "Fideos instantáneos sabor a carne.",
        price: 4000,
        url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4kigyrL6zmBI52fvq8Fv2E3vDN7nXllrV0A&s",
      ),
      Product(
        name: "Bolsa de papas fritas",
        description: "Marca Lays, sabor común.",
        price: 3500,
        url: "https://dcdn-us.mitiendanube.com/stores/001/151/835/products/77903109836381-00914fc6f15dd2786216110235723239-1024-1024.webp",
      ),
      Product(
        name: "Bolsa Doritos",
        description: "Snacks sabor a queso.",
        price: 3200,
        url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d8DDd1Dmuz383semFlFpD-OEsIlFYieI6A&s",
      ),
      Product(
        name: "Bolsa Cheetos",
        description: "Snacks chizito sabor a queso.",
        price: 2800,
        url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6eAmH1IJFVM-4mT-vV_i5K3LdnlU5FzI5Vg&s",
      ),
      Product(
        name: "Botella Coca Cola",
        description: "Gaseosa con azúcar. 2,25 litros.",
        price: 3100,
        url: "https://acdn-us.mitiendanube.com/stores/001/144/141/products/whatsapp-image-2021-06-11-at-19-36-03-11-88c69a6ccaa75978a716234511927730-1024-1024.webp",
      ),
    ];
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void updateProduct(Product oldProduct, Product updatedProduct) {
    state = [
      for (final p in state)
        if (p == oldProduct) updatedProduct else p,
    ];
  }

  void deleteProduct(Product product) {
    state = state.where((p) => p != product).toList();
  }
}


final productsProvider = NotifierProvider<ProductsNotifier, List<Product>>(ProductsNotifier.new);