import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client.dart';
import '../models/transaction.dart';
import '../models/product.dart';
import '../models/order.dart'; // Import the Order model

// State class to hold the list of clients, transactions, products, orders, loading status, and errors
class SearchState {
  final List<Client> clients;
  final List<Transaction> transactions;
  final List<Product> products;
  final List<Order> orders; // Added for orders
  final bool isLoading;
  final String? error;

  SearchState({
    required this.clients,
    required this.transactions,
    required this.products,
    required this.orders, // Added for orders
    this.isLoading = false,
    this.error,
  });
}

// State Provider for search query
final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

// StateNotifier for Search
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier()
      : super(SearchState(
            clients: [],
            transactions: [],
            products: [],
            orders: [])); // Added orders

  void searchClients(List<Client> originalClientList, String query) {
    state = SearchState(
        clients: [],
        transactions: [],
        products: [],
        orders: [],
        isLoading: true); // Added orders

    try {
      final filteredClients = originalClientList.where((client) {
        final clientName = client.name.toLowerCase() ?? '';
        final clientNumber = client.clientNumber.toLowerCase() ?? '';
        return clientName.startsWith(query) || clientNumber.startsWith(query);
      }).toList();

      state = SearchState(
          clients: filteredClients,
          transactions: [],
          products: [],
          orders: []); // Added orders
    } catch (e) {
      state = SearchState(
          clients: [],
          transactions: [],
          products: [],
          orders: [],
          error: e.toString()); // Added orders
    }
  }

  void searchTransactions(
      List<Transaction> originalTransactionList, String query) {
    state = SearchState(
        clients: [],
        transactions: [],
        products: [],
        orders: [],
        isLoading: true); // Added orders

    try {
      final filteredTransactions = originalTransactionList.where((transaction) {
        final transactionNumber =
            transaction.transactionNumber.toLowerCase() ?? '';
        final clientName = transaction.clientId.toLowerCase() ?? '';
        final status = transaction.status.toString().toLowerCase();

        return transactionNumber.startsWith(query) ||
            clientName.startsWith(query) ||
            status.startsWith(query);
      }).toList();

      state = SearchState(
          clients: [],
          transactions: filteredTransactions,
          products: [],
          orders: []); // Added orders
    } catch (e) {
      state = SearchState(
          clients: [],
          transactions: [],
          products: [],
          orders: [],
          error: e.toString()); // Added orders
    }
  }

  void searchProducts(List<Product> originalProductList, String query) {
    state = SearchState(
        clients: [],
        transactions: [],
        products: [],
        orders: [],
        isLoading: true); // Added orders

    try {
      final filteredProducts = originalProductList.where((product) {
        final productName = product.name.toLowerCase() ?? '';
        final productNumber = product.productNumber.toLowerCase() ?? '';

        return productName.startsWith(query) || productNumber.startsWith(query);
      }).toList();

      state = SearchState(
          clients: [],
          transactions: [],
          products: filteredProducts,
          orders: []); // Added orders
    } catch (e) {
      state = SearchState(
          clients: [],
          transactions: [],
          products: [],
          orders: [],
          error: e.toString()); // Added orders
    }
  }

  // Added for orders
  void searchOrders(List<Order> originalOrderList, String query) {
    state = SearchState(
        clients: [],
        transactions: [],
        products: [],
        orders: [],
        isLoading: true); // Added orders

    try {
      final filteredOrders = originalOrderList.where((order) {
        final orderNumber = order.orderNumber.toLowerCase() ?? '';
        final clientId = order.clientId.toLowerCase() ?? '';
        final status = order.status.toString().toLowerCase();

        return orderNumber.startsWith(query) ||
            clientId.startsWith(query) ||
            status.startsWith(query);
      }).toList();

      state = SearchState(
          clients: [],
          transactions: [],
          products: [],
          orders: filteredOrders); // Added orders
    } catch (e) {
      state = SearchState(
          clients: [],
          transactions: [],
          products: [],
          orders: [],
          error: e.toString()); // Added orders
    }
  }
}

// SearchNotifier Provider
final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});

// SearchProvider for Client
final clientSearchProvider =
    Provider.autoDispose.family<void, List<Client>>((ref, originalClientList) {
  final searchQuery = ref.watch(searchQueryProvider);
  final searchNotifier = ref.read(searchNotifierProvider.notifier);

  searchNotifier.searchClients(originalClientList, searchQuery);
});

// SearchProvider for Transaction
final transactionSearchProvider = Provider.autoDispose
    .family<void, List<Transaction>>((ref, originalTransactionList) {
  final searchQuery = ref.watch(searchQueryProvider);
  final searchNotifier = ref.read(searchNotifierProvider.notifier);

  searchNotifier.searchTransactions(originalTransactionList, searchQuery);
});

// SearchProvider for Product
final productSearchProvider =
    Provider.family<void, List<Product>>((ref, originalProductList) {
  final searchQuery = ref.watch(searchQueryProvider);
  final searchNotifier = ref.read(searchNotifierProvider.notifier);

  searchNotifier.searchProducts(originalProductList, searchQuery);
});

// SearchProvider for Order
final orderSearchProvider =
    Provider.autoDispose.family<void, List<Order>>((ref, originalOrderList) {
  final searchQuery = ref.watch(searchQueryProvider);
  final searchNotifier = ref.read(searchNotifierProvider.notifier);

  searchNotifier.searchOrders(originalOrderList, searchQuery);
});
