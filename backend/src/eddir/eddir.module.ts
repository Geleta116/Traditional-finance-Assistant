import { Module } from '@nestjs/common';
import { EddirController } from './eddir.controller';
import { EddirService } from './eddir.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserModule } from '../User/user.module';
import { AuthModule } from '../auth/auth.module';
import { Edir } from '../typeorm/edir entities/edir.entity';
import { Edirmembers } from '../typeorm/edir entities/edir_members.entity';
import { User } from '../typeorm/user entities/user.entity';
import { EdirNotifications } from '../typeorm/edir entities/edir_notification.entity';
import { Edirchatroom } from '../typeorm/edir entities/edir_chatroom.entity';

@Module({
  controllers: [EddirController],
  providers: [EddirService],
  imports: [TypeOrmModule.forFeature([Edir,Edirmembers,User, EdirNotifications,Edirchatroom]), UserModule, AuthModule]

})
export class EddirModule {}
