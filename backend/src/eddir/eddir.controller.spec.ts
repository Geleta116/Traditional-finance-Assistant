import { Test, TestingModule } from '@nestjs/testing';
import { EddirController } from './eddir.controller';

describe('EddirController', () => {
  let controller: EddirController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [EddirController],
    }).compile();

    controller = module.get<EddirController>(EddirController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
