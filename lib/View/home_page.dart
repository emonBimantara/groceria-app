import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:groceria/Components/custom_card.dart';
import 'package:groceria/Components/custom_category_bar.dart';
import 'package:groceria/Components/custom_search_bar.dart';
import 'package:groceria/Model/product_model.dart';
import 'package:groceria/Services/groceria_service.dart';
import 'package:groceria/View/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  late Future<List<String>> categoryList;
  String selectedCategory = "All";

  late Stream<List<ProductModel>> productsList;

  @override
  void initState() {
    searchController = TextEditingController();
    categoryList = GroceriaService().getCategories();
    productsList = GroceriaService().getProducts(selectedCategory);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to',
                        style: TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  'Jakarta, Indonesia',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.keyboard_arrow_down, size: 18),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed("/cart");
                            },
                            child: Image.asset('assets/cart.png', height: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomSearchBar(
                        hintText: 'Search fresh products or brands',
                        controller: searchController,
                        prefixIconPath: 'assets/search.png',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Image.asset('assets/caraousel.png', width: double.infinity),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 5,
                  ),
                  child: Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: FutureBuilder(
                    key: const ValueKey('categoryFuture'),
                    future: categoryList,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return SizedBox();

                      List<String> category = ["All", ...snapshot.data!];

                      return CustomCategoryBar(
                        categories: category,
                        selectedCategory: selectedCategory,
                        onCategorySelected: (name) => setState(() {
                          selectedCategory = name;
                          productsList = GroceriaService().getProducts(name);
                        }),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(child: Divider()),
                StreamBuilder<List<ProductModel>>(
                  stream: productsList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final products = snapshot.data ?? [];
                    if (products.isEmpty) {
                      return Center(child: Text("No Product Available"));
                    }

                    return GridView.builder(
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => DetailPage(), arguments: product);
                          },
                          child: CustomCard(
                            title: product.title,
                            imageUrl: product.imageUrls.isNotEmpty ? product.imageUrls[0] : 'https://placeholder.com/150',
                            price: product.price,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
