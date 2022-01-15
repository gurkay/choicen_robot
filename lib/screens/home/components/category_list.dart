import 'package:choicen_robot/models/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Function deleteTx;
  CategoryList({
    required this.categories,
    required this.deleteTx,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.85,
      child: categories.isEmpty
          ? Column(
              children: [Text('Kategori ekleyiniz')],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    title: Text('${categories[index].categoryName}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(categories[index].categoryId),
                    ),
                  ),
                );
              },
              itemCount: categories.length,
            ),
    );
  }
}
