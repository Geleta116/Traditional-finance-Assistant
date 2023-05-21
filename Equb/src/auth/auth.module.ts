import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { AtStrategy } from './strategies/auth.strategy';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Members } from 'src/typeorm/entities/members.entity';
import { User } from 'src/typeorm/entities/user.entity';
// import { Enrolled } from '../typeorm/entities/enrolled.entity';
import { Equb } from '../typeorm/entities/equb.entity';

@Module({
  imports: [JwtModule.register({}),TypeOrmModule.forFeature([Equb,Members,User])],
  // imports: [JwtModule.register({})],
  providers: [AuthService,AtStrategy],
  controllers: [AuthController]
})
export class AuthModule {}
