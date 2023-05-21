import { Injectable, UnauthorizedException} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/typeorm/entities/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AuthService {
  constructor(
    private jwtService: JwtService,
    @InjectRepository(User) private userRepository: Repository<User>,
    ) {}

  async logIn(username: string, pass: string): Promise<any> {
    const user = await this.userRepository.findOneBy({username})

    if (user?.password !== pass) {
      throw new UnauthorizedException();
    }
    
    const token = await this.getToken(user.id, username)
    user['refreshtoken'] = token['refresh_token']
    this.userRepository.save(user)
    return token
    
}





async getToken(userID:number, username:string){
  const [access_token, refresh_token] = await Promise.all([
    this.jwtService.signAsync({
        sub: userID,
        username
      },{
        expiresIn: '10m',
        secret: 'at-secret'
      }),

      this.jwtService.signAsync({
        sub: userID,
        username
      },{
        secret: 'rt-secret',
        expiresIn: "1h"
      })
  ])

  return {
    access_token: access_token
    // refresh_token: refresh_token
  }
}
}
