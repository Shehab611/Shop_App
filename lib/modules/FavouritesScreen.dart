// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/shop_cubit.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/models/favourites_model.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouritesDataState,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => favouriteItem(
                    cubit.favourtiesModel!.data.data[index], cubit),
                separatorBuilder: (context, index) => myDivder(),
                itemCount: cubit.favourtiesModel!.data.data.length),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget favouriteItem(Data model, cubit) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    width: 100,
                    height: 100,
                    image: NetworkImage(model.product.image),
                    fit: BoxFit.cover,
                  ),
                  if (model.product.discount > 0)
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(height: 1.3),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.product.price.round().toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.deepOrange),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.product.discount > 0)
                          Text(
                            model.product.oldPrice.round().toString(),
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
                              cubit.changeFavourites(model.product.id);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  (cubit.favourites[model.product.id]!)
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
          ),
        ),
      );
}
