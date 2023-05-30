import 'dart:async';

import 'package:traditional_financial_asistant/infrastructure/join/join.Dto.dart';

import '../../domain/join/join.dart';
import '../../domain/join/joinRepositoryInterface.dart';
import '../../local_storage/local_storage.dart';
import '../ekub/ekub.Dto.dart';
import 'join_data_provider.dart';

class JoinRepository implements JoinRepositoryInterface {
  final JoinDataProvider dataProvider;
  JoinRepository(this.dataProvider);
  DbHelper helper = DbHelper();

  @override
  Future<void> joined(Join join) async {
    print("reached joinREpo");

    String accessToken = await helper.getAccessToken();

    EkubDto ekubDto = await dataProvider.joined(join.toDto(), accessToken);
    print("ekubDto");
    await helper.insertEkub([ekubDto.toEntity()]);
  }
}
