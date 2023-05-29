import {Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Equb } from '../typeorm/equb entities/equb.entity';
import { EqubMembers } from '../typeorm/equb entities/members.entity';
import { User } from '../typeorm/user entities/user.entity';
import { Edir } from '../typeorm/edir entities/edir.entity';
import { Edirmembers } from '../typeorm/edir entities/edir_members.entity';



@Module({
  providers: [AuthService],
  controllers: [AuthController],
  exports : [AuthService],
  imports: [JwtModule.register({}),TypeOrmModule.forFeature([Equb,EqubMembers,User, Edir, Edirmembers])]
})
export class AuthModule {}
