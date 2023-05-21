import { Module } from '@nestjs/common';
import { EqubService } from './equb.service';
import { EqubController } from './equb.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Members } from 'src/typeorm/entities/members.entity';
import { Equb } from 'src/typeorm/entities/equb.entity';
// import { Enrolled } from 'src/typeorm/entities/enrolled.entity';
import { User } from 'src/typeorm/entities/user.entity';
import { Notification } from '../typeorm/entities/notification.entity';

@Module({
  providers: [EqubService],
  controllers: [EqubController],
  imports: [TypeOrmModule.forFeature([Equb,Members,User, Notification])]
})
export class EqubModule {}
