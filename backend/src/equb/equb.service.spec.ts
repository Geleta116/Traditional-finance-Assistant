import { Test, TestingModule } from '@nestjs/testing';
import { EqubService } from './equb.service';

describe('EqubService', () => {
  let service: EqubService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [EqubService],
    }).compile();

    service = module.get<EqubService>(EqubService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
