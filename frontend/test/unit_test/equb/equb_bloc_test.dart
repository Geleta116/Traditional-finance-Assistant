import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:traditional_financial_asistant/application/ekub/ekub_bloc.dart';
import 'package:traditional_financial_asistant/application/ekub/ekub_event.dart';
import 'package:traditional_financial_asistant/application/ekub/ekub_state.dart';
import 'package:traditional_financial_asistant/domain/ekub/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/EkubTitle.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekubRepositoryInterface.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/validNumber.dart';
import 'package:traditional_financial_asistant/domain/ekub/Description.dart' as des;
import 'package:traditional_financial_asistant/presentation/equb/screens/EqubLandingPage.dart';
import 'equb_bloc_test.mocks.dart';

@GenerateMocks([EkubRepositoryInterface]) 
  void main() {
  late EkubBloc ekubBloc;
  late MockEkubRepositoryInterface mockEkubRepository;

  final ekub = Ekub(
    description: des.Description('Test Description'),
    name: EkubTitle("Test Name"),
    amount: ValidNumber("1000"),
    minMembers: ValidNumber("5"),
    countdown: ValidNumber("3"),
    duration: ValidNumber("6"),
  );

  final ekubModel = EkubModel(
    description: "Test Description",
    name: "Test Name",
    amount: "1000",
    minMembers: "5",
    countdown: "3",
    duration: "6",
  );
  final ekubModels = [ekubModel];
  final ekubs = [ekub];

  setUp(() {
    mockEkubRepository = MockEkubRepositoryInterface();
    ekubBloc = EkubBloc(ekubRepository: mockEkubRepository);
  });
  tearDown(() => null);

   blocTest<EkubBloc, EkubState>(
      'emits [EkubOperationSuccess] when EkubLoad event is added and fetchAllEnrolled succeeds',
      build: () {
        when(mockEkubRepository.fetchAllEnrolled()).thenAnswer(
          (_) => Future.value([ekub]),
        );
        return ekubBloc;
      },
      act: (bloc) => bloc.add(EkubLoad()),
      expect: () => [
        EkubLoading(),
        EkubOperationSuccess([ekubModel]),
      ],
    );

    blocTest<EkubBloc, EkubState>(
      'emits [EkubOperationFailure] when EkubLoad event is added and fetchAllEnrolled fails',
      build: () {
        when(mockEkubRepository.fetchAllEnrolled()).thenAnswer(
          (_) => Future.error('Fetch failed'),
        );
        return ekubBloc;
      },
      act: (bloc) => bloc.add(EkubLoad()),
      expect: () => [
        EkubLoading(),
        EkubOperationFailure('Fetch failed'),
      ],
    );


}
