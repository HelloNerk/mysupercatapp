import 'package:flutter/material.dart';

import '../../../../core/resource.dart';
import '../../data/remote/cat_service.dart';
import '../../domain/cat.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  CatImage _item = CatImage(id: '', url: '', width: 0, height: 0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Resource<CatImage> result = await CatService().getCatImage();

    if (result is Success) {
      CatImage item = result.data!;
      print('Datos obtenidos: $item'); // Registro de depuración
      setState(() {
        _item = item;
      });
    } else {
      print('Error al obtener datos: ${result.toString()}'); // Registro de depuración
      setState(() {
        _item = CatImage(id: '', url: '', width: 0, height: 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _item.url.isNotEmpty
          ? Image.network(
        _item.url,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
        errorBuilder: (context, error, stackTrace) {
          return const Text('Failed to load image');
        },
      )
          : const CircularProgressIndicator(), // Indicador de carga mientras no hay URL
    );
  }
}
