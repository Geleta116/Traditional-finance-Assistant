import { Test, TestingModule } from '@nestjs/testing';
import { EdirController } from './edir.controller';

describe('EdirController', () => {
  let controller: EdirController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [EdirController],
    }).compile();

    controller = module.get<EdirController>(EdirController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
