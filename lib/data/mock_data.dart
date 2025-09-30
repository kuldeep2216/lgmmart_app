// lib/data/mock_data.dart
import 'package:lgmmart_app/models/product_model.dart';

// This new list will power your category selection page.
final List<Map<String, dynamic>> mockCategories = [
  {
    'name': 'Fruits & Vegetables',
    'imageUrl':
        'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500',
    'category': ProductCategory.fruitsAndVeg,
  },
  {
    'name': 'Dairy & Breads',
    'imageUrl':
        'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=500',
    'category': ProductCategory.dairyAndBreads,
  },
  {
    'name': 'Cold Drinks & Juices',
    'imageUrl':
        'https://images.unsplash.com/photo-1595854341625-f33ee10dbf94?w=500',
    'category': ProductCategory.drinksAndJuices,
  },
  {
    'name': 'Snacks & Munchies',
    'imageUrl':
        'https://images.unsplash.com/photo-1572536147248-ac59a8abfa4b?w=500',
    'category': ProductCategory.snacksAndMunchies,
  },
];

// Updated product list with categories assigned.
final List<Product> mockProducts = [
  Product(
    id: 'prod_001',
    title: 'Mineral Water (1L)',
    price: 20,
    originalPrice: 22,
    offer: '9% OFF',
    deliveryTime: '30 min delivery',
    imageUrl: 'assets/images/water.jpg',
    category: ProductCategory.drinksAndJuices,
  ),
  Product(
    id: 'prod_002',
    title: 'Baby Orange (500 g)',
    price: 150,
    originalPrice: 191,
    offer: '15% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-900-900,pr-true,f-auto,q-80/inventory/product/c3aa00c2-6d2b-4c50-8005-ef59bcf9fd6a-29995b32-2f3c-4633-b103-801138d27e22.jpeg',
    category: ProductCategory.fruitsAndVeg,
  ),
  Product(
    id: 'prod_003',
    title: 'Fresh Paneer (200 g)',
    price: 95,
    originalPrice: 105,
    offer: '10% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-2400-2400,pr-true,f-auto,q-80/cms/product_variant/daae3363-e28a-474c-a3e3-5f9f3d9d3053.jpeg',
    category: ProductCategory.dairyAndBreads,
  ),
  Product(
    id: 'prod_004',
    title: 'Baby Potato (500 g)',
    price: 45,
    originalPrice: 55,
    offer: '18% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-2400-2400,pr-true,f-auto,q-80/cms/product_variant/4e44890d-d561-4972-b190-45b0324acce8.jpeg',
    category: ProductCategory.fruitsAndVeg,
  ),
  Product(
    id: 'prod_005',
    title: "Lay's Classic Chips",
    price: 20,
    originalPrice: 20,
    offer: '0% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-500-500,pr-true,f-auto,q-80/inventory/product/d0f28328-9730-4228-b78f-352b57e75271-image.jpeg',
    category: ProductCategory.snacksAndMunchies,
  ),
  Product(
    id: 'prod_006',
    title: 'Coca-Cola Can (300ml)',
    price: 40,
    originalPrice: 40,
    offer: '0% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-1-1,pr-true,f-auto,q-80/inventory/product/00e35327-0638-4229-8734-58a55b14e1a0-image.jpeg',
    category: ProductCategory.drinksAndJuices,
  ),
  Product(
    id: 'prod_007',
    title: 'Harvest Gold Bread',
    price: 45,
    originalPrice: 45,
    offer: '0% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-1500-1500,pr-true,f-auto,q-80/inventory/product/91e01a5a-3134-4346-b30f-fb8b789128f7-image.jpeg',
    category: ProductCategory.dairyAndBreads,
  ),
];
