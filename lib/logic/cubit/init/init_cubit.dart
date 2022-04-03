import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_app/data/repositories/init_repository.dart';
import 'package:meta/meta.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitInitial());

  static final repository = InitRepository();

  get client => repository.getClient;
}
