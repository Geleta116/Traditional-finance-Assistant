import { AuthService } from './../auth/auth.service';
import { Injectable, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/typeorm/entities/user.entity';
import { CreateUserParams } from 'src/utils/types';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';



@Injectable()
export class UserService {
    constructor(
        @InjectRepository(User) private userRepository: Repository<User>,
    ) {}

    async signUp(user:CreateUserParams){

        const saltRounds = 10;
        const salt = await bcrypt.genSalt(saltRounds);
        const hashedPassword = await bcrypt.hash(user.password, salt);


        const userdata = {
            ...user, 
            password:hashedPassword
        }
        const newUser = this.userRepository.create(userdata)
        await this.userRepository.save(newUser)
        return newUser
        
    }

    async getUserInfo(username) {
        return await this.userRepository.findOneBy({username:username})
    }



}
