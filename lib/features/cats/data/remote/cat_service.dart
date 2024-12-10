import 'dart:convert';
import 'dart:io';

import 'package:mysupercatapp/core/app_constants.dart';
import 'package:mysupercatapp/core/resource.dart';
import 'package:http/http.dart' as http;
import 'package:mysupercatapp/features/cats/data/remote/cat_dto.dart';
import 'package:mysupercatapp/features/cats/domain/cat.dart';

class CatService{
  Future<Resource<CatImage>> getCatImage() async {
    String url = '${AppConstants.baseUrl}${AppConstants.searchEndpoint}';

    try {
      print('Realizando solicitud a la URL: $url'); // Registro de depuración
      http.Response response = await http.get(Uri.parse(url));
      print('Estado de la respuesta: ${response.statusCode}'); // Registro de depuración

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        // Verificar si la lista no está vacía
        if (jsonList.isNotEmpty) {
          final Map<String, dynamic> json = jsonList[0];
          CatImage catImage = CatImageDto.fromJson(json).toCatImage();
          print('Datos obtenidos del API: $catImage'); // Registro de depuración
          return Success(catImage);
        } else {
          print('Respuesta vacía del API'); // Registro de depuración
          return Error('La respuesta está vacía');
        }
      } else {
        print('Error en la respuesta del API: ${response.statusCode} ${response.body}'); // Registro de depuración
        return Error('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Excepción al obtener datos: $error'); // Registro de depuración
      return Error(error.toString());
    }
  }

  Future<Resource<List<Cat>>> getCats() async {
    String url = '${AppConstants.baseUrl}${AppConstants.catsEndpoint}';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> json = jsonDecode(response.body);
        List<Cat> cats = json.map((e) => CatDto.fromJson(e).toCat()).toList();
        print('Datos obtenidos del API: $cats'); // Registro de depuración
        return Success(cats);
      } else {
        print('Error en la respuesta del API: ${response.statusCode} ${response.body}'); // Registro de depuración
        return Error('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Excepción al obtener datos: $error'); // Registro de depuración
      return Error(error.toString());
    }
  }

}