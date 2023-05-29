import { AuthService } from './../auth/auth.service';
import { HttpException, HttpStatus, Injectable, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '../typeorm/user entities/user.entity';



@Injectable()
export class UserService {
    constructor(
        @InjectRepository(User) private userRepository: Repository<User>,
    ) {}


    async signUp(userdata){
        // check if the user / username already exists or not

        const prevousUser = await this.userRepository.findOneBy({username : userdata.username})

        if (prevousUser){
            throw new HttpException('User already exists', HttpStatus.BAD_REQUEST)
        }
        else 
        {   
            // hash the password
            const saltRounds = 10;
            const salt = await bcrypt.genSalt(saltRounds);
            const hashedPassword = await bcrypt.hash(userdata.password, salt);

            const newuserdata = {
                ...userdata, 
                password:hashedPassword
            }

            const newUser = this.userRepository.create(newuserdata)
            await this.userRepository.save(newUser)
            return newUser
    }
    }

    async getUserInfo(username) {
        return await this.userRepository.findOneBy({username:username})
    }


    async changePassword(username, oldpassword, newpassword){
        const user = await this.getUserInfo(username)
        if (! (await bcrypt.compare(oldpassword, user.password))){
            throw new HttpException('Wrong password', HttpStatus.BAD_REQUEST)
        }
        else {
            const saltRounds = 10;
            const salt = await bcrypt.genSalt(saltRounds);
            const hashedPassword = await bcrypt.hash(newpassword, salt);
            user.password = hashedPassword
            await this.userRepository.save(user)
            return user
        }
    }

    async makeDeposit(username, amount){
        const user = await this.getUserInfo(username)
        user.balance += amount
        await this.userRepository.save(user)
        return user
    }
}
