import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EqubModule } from './equb/equb.module';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { ScheduleModule } from '@nestjs/schedule';
import { EddirModule } from './eddir/eddir.module';
import { User } from './typeorm/user entities/user.entity';
import { Equb } from './typeorm/equb entities/equb.entity';
import { EqubMembers } from './typeorm/equb entities/members.entity';
import { EqubNotification } from './typeorm/equb entities/notification.entity';
import { BlackList } from './typeorm/equb entities/blackList.entity';
import { Equbchatroom } from './typeorm/equb entities/equb.chatroom.entity';
import { Edir } from './typeorm/edir entities/edir.entity';
import { EdirNotifications } from './typeorm/edir entities/edir_notification.entity';
import { Edirmembers } from './typeorm/edir entities/edir_members.entity';
import { Edirchatroom } from './typeorm/edir entities/edir_chatroom.entity';






@Module({
  imports: [TypeOrmModule.forRoot({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "root", // ur mysql username  , eg: root
    password: "s1a2h3i4b5", // ur mysql password, eg : 12345678
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


