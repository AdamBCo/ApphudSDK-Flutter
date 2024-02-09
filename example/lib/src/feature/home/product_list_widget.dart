import 'dart:io';

import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:apphud_example/src/feature/home/sk_product_widget.dart';
import 'package:apphud_example/src/feature/home/sku_details_widget.dart';
import 'package:apphud_example/src/feature/purchase/purchase_bloc.dart';
import 'package:apphud_example/src/feature/purchase/purchase_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListWidget extends StatelessWidget {
  final List<ApphudProduct>? products;

  const ProductListWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((products?.length ?? 0) == 0) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No products to purchase'),
      );
    }
    return _buildProductList(products!, context);
  }

  Widget _buildProductList(List<ApphudProduct> products, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: products.map((p) => _buildProduct(p, context)).toList(),
      ),
    );
  }

  Widget _buildProduct(ApphudProduct product, BuildContext context) {
    Widget content;
    if (Platform.isIOS) {
      content = SkProductWidget(
        skProduct: product.skProduct,
        wrapInCard: false,
        onTap: () => BlocProvider.of<PurchaseBloc>(context).add(
          PurchaseEvent.purchaseProduct(product),
        ),
        onPromote: () => BlocProvider.of<PurchaseBloc>(context).add(
          PurchaseEvent.grantPromotional(product),
        ),
      );
    } else if (Platform.isAndroid) {
      content = ProductDetailsWidget(
        wrapInCard: false,
        productDetails: product.productDetails,
        onTap: () => BlocProvider.of<PurchaseBloc>(context).add(
          PurchaseEvent.purchaseProduct(product),
        ),
        onPromote: () => BlocProvider.of<PurchaseBloc>(context).add(
          PurchaseEvent.grantPromotional(product),
        ),
      );
    } else {
      content = Text('No product for this platform');
    }
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.name ?? 'No name',
              style: Theme.of(context).textTheme.headline6,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
