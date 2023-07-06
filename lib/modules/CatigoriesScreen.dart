//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/shop_cubit.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/models/catigories_model.dart';

class CatigoriesScreen extends StatelessWidget {
  const CatigoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return ListView.separated(
            itemBuilder: ((context, index) => buildCatItem(cubit.categoriesModel!.data.data[index])),
            separatorBuilder: (context, index) => myDivder(),
            itemCount: cubit.categoriesModel!.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),const SizedBox(width: 10,),
          Text(
            model.name,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      );
}
