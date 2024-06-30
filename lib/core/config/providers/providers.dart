import '../../../features/cart/presentation/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


abstract class AppProvider {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ];

  AppProvider._();
}