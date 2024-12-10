import 'package:flutter/material.dart';

import '../../../favorites/data/local/favorite_dao.dart';
import '../../../favorites/data/local/favorite_model.dart';
import '../../domain/cat.dart';

class CatListItem extends StatefulWidget {
  const CatListItem({super.key, required this.item});

  final Cat item;

  @override
  State<CatListItem> createState() => _CatListItemState();
}

class _CatListItemState extends State<CatListItem> {

  bool _isFavorite = false;

  Future<void> _validate() async {
    bool favorite = await FavoriteDao().isFavorite(widget.item.id);
    setState(() {
      _isFavorite = favorite;
    });
  }

  @override
  void initState() {
    _validate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Hero animation
            Stack(
              children: [
                Hero(
                  tag: widget.item.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://cdn2.thecatapi.com/images/${widget.item.referenceImageId}.jpg",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 50)),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                // Name overlay
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black54,
                    ),
                    child: Text(
                      widget.item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Information section
            Text(
              widget.item.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.public, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  widget.item.origin,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.item.description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Energy Level slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Energy Level:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${widget.item.energyLevel}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Slider(
              value: widget.item.energyLevel.toDouble(),
              onChanged: null,
              max: 5,
              min: 0,
              divisions: 5,
              label: 'Energy Level: ${widget.item.energyLevel}',
              activeColor: Colors.orange,
              inactiveColor: Colors.orange.shade200,
            ),
            const SizedBox(height: 12),
            // Reference image info
            Row(
              children: [
                const Icon(Icons.image, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Reference Image: ${widget.item.referenceImageId}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            IconButton.outlined(
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                  if (_isFavorite) {
                    FavoriteDao().insertFavorite(FavoriteModel(
                      id: widget.item.id,
                      name: widget.item.name,
                      origin: widget.item.origin,
                      energyLevel: widget.item.energyLevel,
                      description: widget.item.description,
                      referenceImageId: widget.item.referenceImageId,
                      temperament: widget.item.temperament,
                      intelligence: widget.item.intelligence,
                    ));
                  } else {
                    FavoriteDao().deleteFavorite(widget.item.id);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: _isFavorite ? Colors.red : Colors.grey,
                )
            )
          ],
        ),
      ),
    );
  }
}