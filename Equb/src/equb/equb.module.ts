import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { EqubService } from './equb.service';
import { EqubController } from './equb.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Members } from 'src/typeorm/entities/members.entity';
import { Equb } from 'src/typeorm/entities/equb.entity';
import { User } from 'src/typeorm/entities/user.entity';
import { Notification } from '../typeorm/entities/notification.entity';
import { BlackList } from '../typeorm/entities/blackList.entity';
import { UserModule } from '../user/user.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  providers: [EqubService],
  controllers: [EqubController],
  imports: [TypeOrmModule.forFeature([Equb,Members,User, Notification,BlackList]), UserModule, AuthModule]
})

export class EqubModule {}
