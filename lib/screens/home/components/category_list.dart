import '../../../models/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Function navigateButton;
  CategoryList(
    this.categories,
    this.navigateButton,
  );

  static const menuItems = <String>[
    'Secenekler',
    'Nitelikler',
    'Hesapla',
    'Sil',
  ];

  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

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
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    title: Text('${categories[index].categoryName}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String newValue) {
                        navigateButton(
                          ctx,
                          newValue,
                          categories[index],
                          categories[index].categoryId,
                        );
                      },
                      itemBuilder: (BuildContext context) => _popUpMenuItems,
                    ),
                  ),
                );
              },
              itemCount: categories.length,
            ),
    );
  }
}
