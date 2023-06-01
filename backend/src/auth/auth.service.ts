import { HttpException, HttpStatus, Injectable, UnauthorizedException} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '../typeorm/user entities/user.entity';

@Injectable()
export class AuthService {
  constructor(
    private jwtService: JwtService,
    @InjectRepository(User) private userRepository: Repository<User>,
    ) {}

    async getToken(userID:number, username:string){
      const token = await Promise.all([
        this.jwtService.signAsync({
            sub: userID,
            username
          },{
            expiresIn: '2hr',
            secret: 'at-secret'
          }),
    
          // this.jwtService.signAsync({
          //   sub: userID,
          //   username
          // },{
          //   secret: 'at-secret',
          //   expiresIn: '24hr'
          // })
      ])
    
      // return [access_token, refresh_token]
      return token[0]
    }



    async validateToken(token: string): Promise<any> {
      try {
        const payload = await this.jwtService.verify(token, {
          secret: 'at-secret', // Replace with your own secret key
        });
        return payload
      } 
      catch (error) {
        return null
      }
    }



    

    

  async logIn(username: string, pass: string): Promise<any> {
    const user = await this.userRepository.findOneBy({username})
    
    if (! user){
      throw new HttpException('User not found', HttpStatus.UNAUTHORIZED)
    }
    
    if (! (await bcrypt.compare(pass, user.password))){
      throw new HttpException('Password is not correct', HttpStatus.UNAUTHORIZED)
    }

    const token = await this.getToken(user.id, username,)
    
    return {"token" : token, "user":user}
  }

  async currentUser(username){
    return this.userRepository.findOneBy({username})
  }
}
