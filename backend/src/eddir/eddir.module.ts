import { Module } from '@nestjs/common';
import { EddirController } from './eddir.controller';
import { EddirService } from './eddir.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserModule } from '../User/user.module';
import { User } from '../typeorm/entities/user.entity';
import { AuthModule } from '../auth/auth.module';
import { Edir } from './typeorm_entities/edir.entity';
import { Edirmembers } from './typeorm_entities/edir_members.entity';
import { EdirNotifications } from './typeorm_entities/edir_notification.entity';
import { Edirchatroom } from './typeorm_entities/edir_chatroom.entity';

@Module({
  controllers: [EddirController],
  providers: [EddirService],
  imports: [TypeOrmModule.forFeature([Edir,Edirmembers,User, EdirNotifications,Edirchatroom]), UserModule, AuthModule]

})
export class EddirModule {}
