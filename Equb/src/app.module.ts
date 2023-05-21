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



@Module({
  imports: [TypeOrmModule.forRoot({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "", // ur mysql username  , eg: root
    password: "", // ur mysql password, eg : 12345678
    database: "mobile_backend",
    entities: [Equb, Members, User, Notification],
    synchronize: true
  }), EqubModule, AuthModule, UserModule, ScheduleModule.forRoot()],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
