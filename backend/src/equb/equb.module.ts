import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { EqubService } from './equb.service';
import { EqubController } from './equb.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserModule } from '../user/user.module';
import { AuthModule } from '../auth/auth.module';
import { Equb } from '../typeorm/equb entities/equb.entity';
import { EqubMembers } from '../typeorm/equb entities/members.entity';
import { User } from '../typeorm/user entities/user.entity';
import { EqubNotification } from '../typeorm/equb entities/notification.entity';
import { BlackList } from '../typeorm/equb entities/blackList.entity';
import { Equbchatroom } from '../typeorm/equb entities/equb.chatroom.entity';

@Module({
  providers: [EqubService],
  controllers: [EqubController],
  imports: [TypeOrmModule.forFeature([Equb,EqubMembers,User, EqubNotification,BlackList, Equbchatroom]), UserModule, AuthModule]
})

export class EqubModule {}
