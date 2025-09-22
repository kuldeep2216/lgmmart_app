import 'package:lgmmart_app/models/product_model.dart';

// This list acts as our temporary database for all products.
final List<Product> mockProducts = [
  Product(
    id: 'prod_001',
    title: 'Mineral Water (2L x 12)',
    price: 999,
    originalPrice: 1000,
    offer: '1% OFF',
    deliveryTime: '30 min delivery',
    imageUrl:
        'https://cdn.zeptonow.com/production/tr:w-403,ar-1200-1200,pr-true,f-auto,q-80/cms/product_variant/4c968cc8-69c2-424c-beaf-ab77b3343395.jpeg',
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
  ),
  Product(
      id: 'prod_005',
      title: 'Plix Hair Growth Serum',
      price: 649,
      originalPrice: 799,
      offer: '18% OFF',
      deliveryTime: '45 min delivery',
      imageUrl:
          'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1080-1080,pr-true,f-auto,q-80/cms/product_variant/4040202b-0bd1-48f9-bcbb-eb2e6c3d6cb3/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg'),
];
