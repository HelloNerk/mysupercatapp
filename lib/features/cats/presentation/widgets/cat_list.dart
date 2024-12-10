import 'package:flutter/material.dart';
import 'package:mysupercatapp/features/cats/domain/cat.dart';
import 'package:mysupercatapp/features/cats/presentation/pages/cat_detail_page.dart';
import 'package:mysupercatapp/features/cats/presentation/widgets/cat_list_item.dart';

class CatList extends StatelessWidget{
  const CatList({super.key,required this.items});
  final List<Cat>items;

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context,index)=>GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => CatDetailPage(cat: items[index]),));
        },
        child: CatListItem(item: items[index])
      ),
    );
  }
}