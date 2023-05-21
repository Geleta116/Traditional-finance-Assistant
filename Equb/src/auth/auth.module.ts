import {Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Members } from 'src/typeorm/entities/members.entity';
import { User } from 'src/typeorm/entities/user.entity';
import { Equb } from '../typeorm/entities/equb.entity';
import { UserModule } from '../user/user.module';

@Module({
  providers: [AuthService],
  controllers: [AuthController],
  exports : [AuthService],
  imports: [JwtModule.register({}),TypeOrmModule.forFeature([Equb,Members,User])]
})
export class AuthModule {}
