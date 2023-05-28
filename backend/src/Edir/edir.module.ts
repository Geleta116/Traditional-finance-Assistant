import { Module } from '@nestjs/common';
import { EdirService } from './edir.service';
import { EdirController } from './edir.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Edir } from './typeorm_entities/edir.entity';
import { Edirmembers } from './typeorm_entities/edir_members.entity';
// import { User } from '../User/typeorm_entitites/user.entity';
import { EdirNotifications } from './typeorm_entities/edir_notification.entity';
import { UserModule } from '../User/user.module';
import { User } from '../typeorm/entities/user.entity';
import { AuthModule } from '../auth/auth.module';
import { Edirchatroom } from './typeorm_entities/edir_chatroom.entity';
// import { AuthModule } from '../user/auth/auth.module';


@Module({
  providers: [EdirService],
  controllers: [EdirController],
  imports: [TypeOrmModule.forFeature([Edir,Edirmembers,User, EdirNotifications,Edirchatroom]), UserModule, AuthModule]

})
export class EdirModule {}



