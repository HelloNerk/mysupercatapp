import 'package:flutter/material.dart';
import 'package:mysupercatapp/features/favorites/data/local/favorite_dao.dart';
import 'package:mysupercatapp/features/favorites/data/local/favorite_model.dart';

import '../../domain/cat.dart';

class CatDetailPage extends StatefulWidget {
  const CatDetailPage({super.key, required this.cat});
  final Cat cat;

  @override
  State<CatDetailPage>createState()=> _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage>{

  bool _isFavorite = false;

  Future<void> _loadData() async {
    bool favorite = await FavoriteDao().isFavorite(widget.cat.id);
    setState(() {
      _isFavorite = favorite;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 400,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black54, shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                              if (_isFavorite) {
                                FavoriteDao().insertFavorite(FavoriteModel(
                                  id: widget.cat.id,
                                  name: widget.cat.name,
                                  origin: widget.cat.origin,
                                  energyLevel: widget.cat.energyLevel,
                                  description: widget.cat.description,
                                  referenceImageId: widget.cat.referenceImageId,
                                  temperament: widget.cat.temperament,
                                  intelligence: widget.cat.intelligence,
                                ));
                              } else {
                                FavoriteDao().deleteFavorite(widget.cat.id);
                              }
                            },
                            icon: Icon(
                              _isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : Colors.white,
                            ))),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.cat.id,
                    child: Image.network(
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                        "https://cdn2.thecatapi.com/images/${widget.cat.referenceImageId}.jpg"),
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cat.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.cat.description,
                    style: const TextStyle(
                        color: Colors.white70),
                  )
                ],
              ),
            ),
          )),
    );
  }


}