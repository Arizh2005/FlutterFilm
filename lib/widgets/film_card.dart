import 'package:flutter/material.dart';
import '../models/film.dart';

class FilmCard extends StatelessWidget {
  final Film film;
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  final bool isLoading;

  const FilmCard({
    Key? key,
    required this.film,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, // Penting untuk mengurangi white space
        children: [
          // Full Width Image dengan aspect ratio 1:1 untuk 450x450
          AspectRatio(
            aspectRatio: 1, // 1:1 aspect ratio untuk gambar persegi
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Image.network(
                      film.poster,
                      fit: BoxFit.cover, // Pastikan gambar cover penuh
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.broken_image,
                                size: 100, color: Colors.grey),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),

          // Compress the details section
          Padding(
            padding: const EdgeInsets.all(12.0), // Kurangi padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Text(
                  film.genre.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11, // Sedikit lebih kecil
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 6), // Kurangi jarak

                // Product Name
                Text(
                  film.title,
                  style: const TextStyle(
                    fontSize: 18, // Sedikit lebih kecil
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8), // Kurangi jarak

                // Price and Stock Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Text(
                      film.director,
                      style: TextStyle(
                        fontSize: 16, // Sedikit lebih kecil
                        fontWeight: FontWeight.w800,
                        color: Colors.green[700],
                      ),
                    ),

                    // Stock
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4), // Kurangi padding
                      decoration: BoxDecoration(
                        color: film.releaseYear > 10
                            ? Colors.green[50]
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Film Release: ${film.releaseYear}',
                        style: TextStyle(
                          fontSize: 12, // Sedikit lebih kecil
                          fontWeight: FontWeight.w600,
                          color: film.releaseYear > 10
                              ? Colors.green[800]
                              : Colors.red[800],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Kurangi jarak

                // Description
                Text(
                  film.description,
                  style: TextStyle(
                    fontSize: 14, // Sedikit lebih kecil
                    color: Colors.grey[700],
                    height: 1.4, // Kurangi tinggi baris
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12), // Kurangi jarak

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: onEdit,
                      icon:
                          const Icon(Icons.edit, size: 16), // Icon lebih kecil
                      label: const Text('Edit',
                          style: TextStyle(fontSize: 12)), // Teks lebih kecil
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8), // Kurangi padding
                      ),
                    ),
                    const SizedBox(width: 8), // Kurangi jarak
                    ElevatedButton.icon(
                      onPressed: () async => await onDelete(),
                      icon: const Icon(Icons.delete,
                          size: 16), // Icon lebih kecil
                      label: const Text('Delete',
                          style: TextStyle(fontSize: 12)), // Teks lebih kecil
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8), // Kurangi padding
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}