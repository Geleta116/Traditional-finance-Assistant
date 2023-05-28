import { Test, TestingModule } from '@nestjs/testing';
import { EddirService } from './eddir.service';

describe('EddirService', () => {
  let service: EddirService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [EddirService],
    }).compile();

    service = module.get<EddirService>(EddirService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
