import 'package:flutter/material.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/screens/product_detail_screen.dart';
import 'package:lgmmart_app/screens/search_results_screen.dart';

class ProductSearchDelegate extends SearchDelegate {
  // This method contains the search logic.
  List<Product> _performSearch(String query) {
    if (query.isEmpty) {
      return [];
    }
    // Filter the mockProducts list based on the query.
    // We check if the product title contains the query (case-insensitive).
    return mockProducts
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // --- Overriding required methods from SearchDelegate ---

  // Action buttons on the right of the search bar (e.g., a clear button).
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  // The leading icon on the left of the search bar (e.g., a back button).
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search bar
      },
    );
  }

  // This is called when the user submits the search (e.g., presses Enter).
  // We navigate to the SearchResultsScreen with the filtered list.
  @override
  Widget buildResults(BuildContext context) {
    final List<Product> results = _performSearch(query);
    // Since we already have a results screen, we can reuse it!
    return SearchResultsScreen(query: query, results: results);
  }

  // This builds the suggestions that appear below the search bar as the user types.
  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> suggestions = _performSearch(query);

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final Product suggestion = suggestions[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(suggestion.imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(suggestion.title),
          onTap: () {
            // When a suggestion is tapped, navigate directly to the product detail page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: suggestion),
              ),
            );
          },
        );
      },
    );
  }

  // Optional: Customize the theme of the search bar
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }
}
