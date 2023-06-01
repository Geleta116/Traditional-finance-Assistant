import 'dart:async';

import 'package:traditional_financial_asistant/infrastructure/edir/edir.Dto.dart';
import 'package:traditional_financial_asistant/infrastructure/join/join.Dto.dart';

import '../../domain/join/join.dart';
import '../../domain/join/joinRepositoryInterface.dart';
import '../../local_storage/local_storage.dart';
import '../ekub/ekub.Dto.dart';
import 'join_data_provider.dart';

class JoinEdirRepository implements JoinRepositoryInterface {
  final JoinEdirDataProvider dataProvider;
  JoinEdirRepository(this.dataProvider);
  DbHelper helper = DbHelper();

  @override
  Future<void> joined(Join join) async {
    

    String accessToken = await helper.getAccessToken();

    EdirDto edirDto = await dataProvider.joined(join.toDto(), accessToken);
    print("ekubDto");
    await helper.insertEdir([edirDto.toEntity()]);
  }
}
