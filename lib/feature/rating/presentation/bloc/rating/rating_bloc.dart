import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/usecases/rating_use_case.dart';

part 'rating_event.dart';

part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingUseCase ratingUseCase;

  RatingBloc({
    required this.ratingUseCase,
  }) : super(
            //example of services
            RatingState(allServices: [
          Item(
              id: '64ac2f6e8c071bfd4fe2c760',
              text: 'Item 1',
              ratingGivenByMe: 2),
          Item(
              id: '64ac12d58c071bfd4fe2c4ac',
              text: 'Item 2',
              ratingGivenByMe: 2),
          Item(
              id: '64a7dd871254eb3164e6a49a',
              text: 'Item 3',
              ratingGivenByMe: 5),
        ])) {
    on<RatingEvent>((event, emit) async {
      if (event is RatingEventButton) {
        List<Item> servicesCopy = state.allServices;
        final serviceToUpdateIndex =
            servicesCopy.indexWhere((service) => service.id == event.serviceId);
        servicesCopy[serviceToUpdateIndex].ratingGivenByMe = event.rating;

        final ratingOrFailure =
            await ratingUseCase.call(event.serviceId, event.rating);
        ratingOrFailure.fold(
            (l) => emit(state.copyWith(
                  error: mapFailureToMessage(l),
                  isLoading: false,
                )),
            (r) => emit(state.copyWith(
                isLoading: false, error: "", allServices: servicesCopy)));
      }
    });
  }
}
