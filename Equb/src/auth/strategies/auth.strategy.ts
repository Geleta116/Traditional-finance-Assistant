import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy} from 'passport-jwt';


type JwtPayload = {
    sub: string;
    username: string;
  };

@Injectable()
export class AtStrategy extends PassportStrategy(Strategy, 'jwt') {
  constructor() {
    const token =  ExtractJwt.fromAuthHeaderAsBearerToken()

    super({
      jwtFromRequest: token,
      secretOrKey: "at-secret",

    });
  }

  validate(payload: JwtPayload) {
    return payload
  }

}

