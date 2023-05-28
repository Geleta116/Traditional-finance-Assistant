import { Test, TestingModule } from '@nestjs/testing';
import { EqubController } from './equb.controller';

describe('EqubController', () => {
  let controller: EqubController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [EqubController],
    }).compile();

    controller = module.get<EqubController>(EqubController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
