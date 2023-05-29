import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from '../auth/auth.module';
import { Equb } from '../typeorm/equb entities/equb.entity';
import { EqubMembers } from '../typeorm/equb entities/members.entity';
import { User } from '../typeorm/user entities/user.entity';
import { BlackList } from '../typeorm/equb entities/blackList.entity';
import { Edir } from '../typeorm/edir entities/edir.entity';
import { Edirmembers } from '../typeorm/edir entities/edir_members.entity';

@Module({
  providers: [UserService],
  exports:  [UserService],
  controllers: [UserController],
  imports:[AuthModule,JwtModule, TypeOrmModule.forFeature([Equb,EqubMembers,User,BlackList, Edir, Edirmembers])]
})
export class UserModule {}
