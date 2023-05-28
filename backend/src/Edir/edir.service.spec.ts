import { Test, TestingModule } from '@nestjs/testing';
import { EdirService } from './edir.service';

describe('EdirService', () => {
  let service: EdirService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [EdirService],
    }).compile();

    service = module.get<EdirService>(EdirService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
