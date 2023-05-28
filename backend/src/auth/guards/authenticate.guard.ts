import { Injectable, ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';


@Injectable()
export class Authenticate {
  constructor(private readonly authService: AuthService) {}

  async canActivate(context: ExecutionContext): Promise<any> {

    const request = context.switchToHttp().getRequest();
    const response = context.switchToHttp().getResponse();

    const token = request.headers['authorization'].split(' ')[1] 

    const isTokenValid = await this.authService.validateToken(token)
    // const refreshToken = request.cookies['refreshToken'];
    // const isRefreshTokenValid = await this.authService.validateToken(refreshToken)


    if (! isTokenValid){
         response.status(401).send('Please log in to access this resource')
          return false
    }
    else{
      request.user = await this.authService.currentUser(isTokenValid.username)
      return true
    }
  }
}