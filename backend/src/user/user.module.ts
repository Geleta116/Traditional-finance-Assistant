import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Equb } from '../typeorm/entities/equb.entity';
import { EqubMembers } from '../typeorm/entities/members.entity';
import { User } from '../typeorm/entities/user.entity';
import { BlackList } from '../typeorm/entities/blackList.entity';
import { AuthModule } from '../auth/auth.module';
import { Edir } from '../eddir/typeorm_entities/edir.entity';
import { Edirmembers } from '../eddir/typeorm_entities/edir_members.entity';

@Module({
  providers: [UserService],
  exports:  [UserService],
  controllers: [UserController],
  imports:[AuthModule,JwtModule, TypeOrmModule.forFeature([Equb,EqubMembers,User,BlackList, Edir, Edirmembers])]
})
export class UserModule {}
