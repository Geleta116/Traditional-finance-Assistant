import { Injectable, ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';


@Injectable()
export class Authenticate {
  constructor(private readonly authService: AuthService) {}

  async canActivate(context: ExecutionContext): Promise<any> {

    const request = context.switchToHttp().getRequest();
    const response = context.switchToHttp().getResponse();

    const accessToken = request.cookies['accessToken'];
    const isAccessTokenValid = await this.authService.validateToken(accessToken)
    const refreshToken = request.cookies['refreshToken'];
    const isRefreshTokenValid = await this.authService.validateToken(refreshToken)


    if (! isAccessTokenValid){
        if (isRefreshTokenValid){
          const [new_accesstoken, _ ]= await this.authService.getToken(isRefreshTokenValid.id, isRefreshTokenValid.username)
          response.cookie('accessToken', new_accesstoken, { httpOnly: true });
          request.user = await this.authService.currentUser(isRefreshTokenValid.username)
          return true;
        }
        else{
            response.status(401).send('Please log in to access this resource')
            return false
        }
    }
    else{
      request.user = await this.authService.currentUser(isAccessTokenValid.username)
      return true
    }
  }
}