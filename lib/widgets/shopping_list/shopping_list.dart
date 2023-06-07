import 'package:flutter/material.dart';

import 'package:shopping_reminder/helpers/enums.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/res/colors/app_colors.dart';
import 'package:shopping_reminder/widgets/items_manipulation_widget/items_manipulation_widget.dart';
import 'package:shopping_reminder/widgets/alert_info_widget/info_alert_widget.dart';
import 'package:shopping_reminder/widgets/buttons/action_buttons/sr_button.dart';
import 'package:shopping_reminder/widgets/no_content_info_widget/no_content_widget.dart';
import 'package:shopping_reminder/widgets/shopping_list/shopping_list_item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Provider.of<ShoppingItemsStore>(context, listen: false)
                        .shoppingItems ==
                    null ||
                Provider.of<ShoppingItemsStore>(context, listen: false)
                    .shoppingItems!
                    .isEmpty
            ? NoContentInfoWidget(
                isAddingButtonVisible: true,
                onTap: () {
                  _showAddingItemDialog(context: context);
                })
            : SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    Observer(
                      builder: (_) => ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: Provider.of<ShoppingItemsStore>(context,
                                listen: false)
                            .shoppingItems!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = Provider.of<ShoppingItemsStore>(context,
                                  listen: false)
                              .shoppingItems?[index];
                          return ShoppingListItem(
                            shoppingItem: item,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 130.0,
                      right: 40.0,
                      child: SRButton(
                        width: 60,
                        height: 60,
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          _showAddingItemDialog(
                              shouldHideDialog: false, context: context);
                        },
                        color: AppColors.green,
                        buttonTitle: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40.0,
                      right: 40.0,
                      child: SRButton(
                        width: 60,
                        height: 60,
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => _showInfoAlertWidget(context),
                        color: AppColors.green,
                        buttonTitle: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  _showAddingItemDialog(
      {bool? shouldHideDialog = true, BuildContext? context}) {
    showDialog(
      context: context!,
      builder: (context) => ItemsManipulationWidget(
        shouldHideDialog: shouldHideDialog,
        itemManipulationType: ItemManipulationType.add,
        onTap: (text) {
          Provider.of<ShoppingItemsStore>(context, listen: false)
              .addToList(text);
        },
      ),
    );
  }

  _showInfoAlertWidget(BuildContext? context) {
    showDialog(
      context: context!,
      builder: (context) => InfoAlertWidget(
        onTap: () {
          Provider.of<ShoppingItemsStore>(context, listen: false)
              .deleteAllItems();
        },
        infoTitle: AppLocalizations.of(context).areYouSure,
        leftInfoButtonTitle: AppLocalizations.of(context).confirm,
        rightInfoButtonTitle: AppLocalizations.of(context).cancel,
      ),
    );
  }
}
