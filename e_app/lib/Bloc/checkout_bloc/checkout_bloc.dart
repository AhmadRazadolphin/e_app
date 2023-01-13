import 'package:bloc/bloc.dart';
import 'package:e_app/controller/profile_controller.dart';
import 'package:e_app/repositories/checkout_repository.dart';

import 'checkout_event.dart';
import 'checkout_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final controller = OrderController();

  final CheckOutRepository checkOutRepository;
  OrderBloc({required this.checkOutRepository}) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});

    on<GetDataEvent>((event, emit) async {
      emit(ProductLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        // final data = await checkOutRepository.getData();
        final data = await controller.getUserData1();
        print("data");
        print(data.toString());
        emit(ProductLoadedState(data));
      } catch (e) {
        print("e.toString()11");

        print(e.toString());
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
