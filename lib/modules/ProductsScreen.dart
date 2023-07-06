// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/shop_cubit.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/models/catigories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavouritesState) {
          if (!state.model.status) {
            showToast(message: state.model.msg, state: ToastState.error);
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);

        return ConditionalBuilder(
            condition:
                cubit.productsModel != null && cubit.categoriesModel != null,
            builder: (context) => productsBuilder(
                cubit.productsModel, cubit.categoriesModel, cubit),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,
          ShopCubit cubit) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model!.data.banners
                    .map((e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 175,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1)),
            const SizedBox(
              height: 3,
            ),
            Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) =>
                        buildCatigoryIteam(categoriesModel!.data.data[index])),
                    separatorBuilder: ((context, index) => const SizedBox(
                          width: 10,
                        )),
                    itemCount: categoriesModel!.data.data.length)),
            GridView.count(
              childAspectRatio: 1 / 1.8,
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildProductItem(model.data.products[index], cubit)),
            )
          ],
        ),
      );

  Widget buildProductItem(ProductModel model, ShopCubit cubit) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red[300],
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'Disscount',
                    style: TextStyle(fontSize: 9, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      model.price.round().toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.deepOrange),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldprice.round().toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          cubit.changeFavourites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: (cubit.favourites[model.id]!)
                              ? Colors.deepOrange
                              : Colors.grey,
                          child: const Icon(Icons.favorite_border,
                              size: 14, color: Colors.white),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      );
  Widget buildCatigoryIteam(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
              image: NetworkImage(model.image),
              height: 100,
              width: 100,
              fit: BoxFit.cover),
          Container(
              width: 100,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                model.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      );
}
