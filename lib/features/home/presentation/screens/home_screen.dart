import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/searched_books_bloc.dart';
import '../widgets/book_list_item.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _lastSearchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _lastSearchQuery = query;
    });

    context.read<SearchedBooksBloc>().add(SearchBooksEvent(query));
  }

  void _handleFavoriteToggle(String bookId) {
    // TODO: Implement favorite toggle logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Search'), elevation: 2),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onSearch: _handleSearch,
          ),
          Expanded(
            child: BlocBuilder<SearchedBooksBloc, SearchedBooksState>(
              builder: (context, state) {
                // Initial State
                if (state is SearchedBooksInitial) {
                  return const EmptyStateWidget(
                    message: 'Search for a book to get started.',
                    icon: Icons.menu_book,
                  );
                }

                // Loading State
                if (state is SearchedBooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error State
                if (state is SearchedBooksFailure) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: () {
                      if (_lastSearchQuery.isNotEmpty) {
                        _handleSearch(_lastSearchQuery);
                      }
                    },
                  );
                }

                // Success State
                if (state is SearchedBooksSuccess) {
                  final books = state.books;

                  // Empty State - No results
                  if (books == null || books.isEmpty) {
                    return EmptyStateWidget(
                      message: 'No books found for "$_lastSearchQuery".',
                      icon: Icons.search_off,
                    );
                  }

                  // Data State - Display books
                  return ListView.builder(
                    itemCount: books.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookListItem(
                        book: book,
                        onFavoriteToggle: () => _handleFavoriteToggle(book.id),
                        isFavorite:
                            false, // TODO: Check if book is in favorites
                      );
                    },
                  );
                }

                // Fallback
                return const EmptyStateWidget(
                  message: 'Search for a book to get started.',
                  icon: Icons.menu_book,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
