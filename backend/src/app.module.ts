import { EqubNotification } from './typeorm/entities/notification.entity';
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Equb } from './typeorm/entities/equb.entity';
import { EqubMembers } from './typeorm/entities/members.entity';
import { EqubModule } from './equb/equb.module';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { User } from './typeorm/entities/user.entity';
import { ScheduleModule } from '@nestjs/schedule';
import { BlackList } from './typeorm/entities/blackList.entity';
import { Edir } from './eddir/typeorm_entities/edir.entity';
import { EdirNotifications } from './eddir/typeorm_entities/edir_notification.entity';
import { Edirmembers } from './eddir/typeorm_entities/edir_members.entity';
import { Edirchatroom } from './eddir/typeorm_entities/edir_chatroom.entity';
import { Equbchatroom } from './typeorm/entities/equb.chatroom.entity';
import { EddirModule } from './eddir/eddir.module';






@Module({
  imports: [TypeOrmModule.forRoot({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "root", // ur mysql username  , eg: root
    password: "nahom", // ur mysql password, eg : 12345678
    database: "mobile_backend",
    entities: [
      User,
      Equb, EqubMembers,EqubNotification,BlackList,Equbchatroom,
      Edir, EdirNotifications, Edirmembers,Edirchatroom
    ],
    synchronize: true
  }), EqubModule, AuthModule, UserModule, ScheduleModule.forRoot(), EddirModule],
  
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}


