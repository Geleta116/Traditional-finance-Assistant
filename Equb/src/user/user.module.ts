import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Equb } from '../typeorm/entities/equb.entity';
import { Members } from '../typeorm/entities/members.entity';
import { User } from '../typeorm/entities/user.entity';
import { BlackList } from '../typeorm/entities/blackList.entity';
import { AuthModule } from '../auth/auth.module';

@Module({
  providers: [UserService],
  exports:  [UserService],
  controllers: [UserController],
  imports:[AuthModule,JwtModule, TypeOrmModule.forFeature([Equb,Members,User,BlackList])]
})
export class UserModule {}
