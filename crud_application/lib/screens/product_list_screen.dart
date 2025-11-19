import 'package:flutter/material.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductController productController = ProductController();
  bool isLoading = false;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    await productController.fetchProduct();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void productDialog({
    String? id,
    String? name,
    String? img,
    int? qty,
    int? uniPrice,
    int? totalPrice,
    required bool isUpdate,
  }) {
    TextEditingController productNameController =
        TextEditingController(text: name);
    TextEditingController productIMGController = TextEditingController(text: img);
    TextEditingController productQTYController =
        TextEditingController(text: qty != null ? qty.toString() : '');
    TextEditingController productUnitPriceController =
        TextEditingController(text: uniPrice != null ? uniPrice.toString() : '');
    TextEditingController productTotalPriceController = TextEditingController(
        text: totalPrice != null ? totalPrice.toString() : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? 'Update Product' : 'Add Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productIMGController,
                decoration: const InputDecoration(labelText: 'Product Image URL'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productQTYController,
                decoration: const InputDecoration(labelText: 'Product Quantity'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productUnitPriceController,
                decoration: const InputDecoration(labelText: 'Product Unit Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productTotalPriceController,
                decoration: const InputDecoration(labelText: 'Product Total Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (productNameController.text.isEmpty ||
                          productQTYController.text.isEmpty ||
                          productUnitPriceController.text.isEmpty ||
                          productTotalPriceController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all required fields')),
                        );
                        return;
                      }

                      bool success = false;
                      if (isUpdate) {
                        success = await productController.updateProduct(
                          id.toString(),
                          productNameController.text,
                          productIMGController.text,
                          int.parse(productQTYController.text),
                          int.parse(productUnitPriceController.text),
                          int.parse(productTotalPriceController.text),
                        );
                      } else {
                        success = await productController.createProduct(
                          productNameController.text,
                          productIMGController.text,
                          int.parse(productQTYController.text),
                          int.parse(productUnitPriceController.text),
                          int.parse(productTotalPriceController.text),
                        );
                      }

                      if (success) {
                        await fetchData();
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isUpdate
                                  ? 'Product updated successfully'
                                  : 'Product created successfully'),
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something went wrong!')),
                          );
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : productController.products.isEmpty
              ? const Center(
                  child: Text(
                    'No products available.\nTap + to add a product.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      var product = productController.products[index];
                      return ProductCard(
                        product: product,
                        onDelete: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: const Text(
                                  'Are you sure you want to delete this product?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            final value = await productController
                                .deleteProduct(product.sId.toString());
                            if (value) {
                              await fetchData();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Product Deleted')),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Something went wrong...!')),
                                );
                              }
                            }
                          }
                        },
                        onEdit: () {
                          productDialog(
                            name: product.productName,
                            img: product.img,
                            id: product.sId,
                            uniPrice: product.unitPrice,
                            totalPrice: product.totalPrice,
                            qty: product.qty,
                            isUpdate: true,
                          );
                        },
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productDialog(isUpdate: false);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
