import 'package:flutter/material.dart';

import '../../../../core/model/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const BookListItem({
    super.key,
    required this.book,
    required this.onFavoriteToggle,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final thumbnail =
        book.volumeInfo.imageLinks?.thumbnail ??
        book.volumeInfo.imageLinks?.smallThumbnail;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to book details
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: thumbnail != null
                    ? Image.network(
                        thumbnail,
                        width: 60,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder();
                        },
                      )
                    : _buildPlaceholder(),
              ),
              const SizedBox(width: 12),
              // Book Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.volumeInfo.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (book.volumeInfo.authors.isNotEmpty)
                      Text(
                        book.volumeInfo.authors.join(', '),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (book.volumeInfo.publishedDate != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        book.volumeInfo.publishedDate!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Favorite Button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.amber : null,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.book, size: 32, color: Colors.grey),
    );
  }
}
