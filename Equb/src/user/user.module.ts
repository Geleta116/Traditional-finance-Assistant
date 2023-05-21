import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
// import { Enrolled } from '../typeorm/entities/enrolled.entity';
import { Equb } from '../typeorm/entities/equb.entity';
import { Members } from '../typeorm/entities/members.entity';
import { User } from '../typeorm/entities/user.entity';

@Module({
  providers: [UserService],
  controllers: [UserController],
  imports:[JwtModule, TypeOrmModule.forFeature([Equb,Members,User])]
  // imports: [JwtModule.register({}),],
})
export class UserModule {}
