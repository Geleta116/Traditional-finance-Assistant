import { Notification } from './typeorm/entities/notification.entity';
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Equb } from './typeorm/entities/equb.entity';
import { Members } from './typeorm/entities/members.entity';
import { EqubModule } from './equb/equb.module';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { User } from './typeorm/entities/user.entity';
import { ScheduleModule } from '@nestjs/schedule';
import { BlackList } from './typeorm/entities/blackList.entity';






@Module({
  imports: [TypeOrmModule.forRoot({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "root", // ur mysql username  , eg: root
    password: "12345678", // ur mysql password, eg : 12345678
    database: "mobile_backend",
    entities: [Equb, Members, User, Notification,BlackList],
    synchronize: true
  }), EqubModule, AuthModule, UserModule, ScheduleModule.forRoot()],
  
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}


