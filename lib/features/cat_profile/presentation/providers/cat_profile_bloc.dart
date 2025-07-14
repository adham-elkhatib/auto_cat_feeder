import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/params/Cat/cat_params.dart';
import '../../domain/entities/cat_entity.dart';
import '../../domain/usecases/create_cat_profile.dart';
import '../../domain/usecases/get_cat_profile.dart';
import '../../domain/usecases/update_cat_profile.dart';

part 'cat_profile_event.dart';
part 'cat_profile_state.dart';

class CatProfileBloc extends Bloc<CatProfileEvent, CatProfileState> {
  final CreateCatProfile createCatProfileUseCase;
  final GetCatProfile getCatProfileUseCase;
  final UpdateCatProfile updateCatProfileUseCase;
  final AuthService authService;

  CatProfileBloc(
      {required this.createCatProfileUseCase,
      required this.getCatProfileUseCase,
      required this.updateCatProfileUseCase,
      required this.authService})
      : super(CatProfileInitial()) {
    on<SubmitProfileEvent>(_onCreateProfileEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<LoadProfileEvent>(_onLoadProfileEvent);
  }

  Future<void> _onLoadProfileEvent(
      LoadProfileEvent event, Emitter<CatProfileState> emit) async {
    emit(CatProfileLoading());
    try {
      final result = await getCatProfileUseCase(uid: event.catId);
      result.fold(
        (failure) => emit(CatProfileFailure(message: failure.toString())),
        (catProfile) => emit(CatProfileLoaded(catProfile: catProfile)),
      );
    } catch (e) {
      emit(CatProfileFailure(message: e.toString()));
    }
  }

  Future<void> _onCreateProfileEvent(
      SubmitProfileEvent event, Emitter<CatProfileState> emit) async {
    emit(CatProfileLoading());
    try {
      final result = await createCatProfileUseCase(params: event.params);

      result.fold(
        (failure) => emit(CatProfileFailure(message: failure.toString())),
        (createdCat) => emit(CatProfileSuccess(
          cat: createdCat,
          message: "Cat Profile created successfully",
        )),
      );
    } catch (e) {
      emit(CatProfileFailure(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<CatProfileState> emit) async {
    emit(CatProfileLoading());
    try {
      final result = await updateCatProfileUseCase(params: event.params);
      result.fold(
        (failure) => emit(CatProfileFailure(message: failure.toString())),
        (updatedCat) => emit(CatProfileSuccess(
          cat: updatedCat,
          message: "Cat Profile updated successfully",
        )),
      );
    } catch (e) {
      emit(CatProfileFailure(message: e.toString()));
    }
  }
}
