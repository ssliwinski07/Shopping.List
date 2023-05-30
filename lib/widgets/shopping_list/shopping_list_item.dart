import 'package:flutter/material.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/models/shopping_item_model.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';

class ShoppingListItem extends StatefulWidget {
  const ShoppingListItem({
    super.key,
    this.shoppingItem,
    this.store,
  });

  final ShoppingItemModel? shoppingItem;
  final ShoppingItemsStore? store;

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _isChecked = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red,
          child: ListTile(
            trailing: IconButton(
              onPressed: () async {
                setState(() {
                  Future.delayed(const Duration(milliseconds: 400)).then((_) {
                    _isTapped = !_isTapped;
                    widget.store?.removeFromList(widget.shoppingItem!);
                  });
                });
              },
              icon: const Icon(Icons.delete_forever),
              color: Colors.white,
            ),
          ),
        ),
        AnimatedContainer(
          color: Colors.white,
          width: _isTapped ? 330 : MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 400),
          child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    _isChecked = !_isChecked;
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isChecked ? AppColors.green : null,
                    border: Border.all(
                      width: 1,
                      color: AppColors.green,
                    ),
                  ),
                  child: _isChecked
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : const SizedBox(),
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  setState(() {});
                  _isTapped = !_isTapped;
                },
                child: Text(
                  widget.shoppingItem!.name!,
                  style: TextStyle(
                    color: _isChecked ? Colors.grey : Colors.black,
                    decoration: _isChecked ? TextDecoration.lineThrough : null,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
