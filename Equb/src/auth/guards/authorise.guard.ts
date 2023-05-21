import { Injectable, ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';
import { EqubService } from '../../equb/equb.service';

@Injectable()
export class Authorize {
  constructor(
    private readonly authService: AuthService,
    private readonly equbService: EqubService
    ) {}

  async canActivate(context: ExecutionContext): Promise<any> {
    const request = context.switchToHttp().getRequest();
    const response = context.switchToHttp().getResponse();

    const refreshToken = request.cookies['refreshToken'];
    const result = await this.authService.validateToken(refreshToken)
    const username = result.username // get the user ID from the request
    const id = request.params.id;
    const equb = await this.equbService.getDataAboutEqub(id)


    if (equb.creator == username) {
        return true
    } else {
        response.status(403).send('only creators are allowed to access this route')
        return false
    }
  }
}