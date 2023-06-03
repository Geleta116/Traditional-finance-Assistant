import { Injectable, ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';
import { EqubService } from '../../equb/equb.service';
import { EddirService } from '../../eddir/eddir.service';

@Injectable()
export class EdirAuthorize {
  constructor(
    private readonly authService: AuthService,
    private readonly edirService: EddirService
    ) {}

  async canActivate(context: ExecutionContext): Promise<any> {
    const request = context.switchToHttp().getRequest();
    const response = context.switchToHttp().getResponse();

    const token = request.headers['authorization'].split(' ')[1] 

    const result = await this.authService.validateToken(token)
    const username = result.username // get the user ID from the request
    const id = request.params.id;
    const edirName = request.params['edirName']
    const edir = await this.edirService.getDataAboutEdir(edirName)
    // const result = await this.authService.validateToken(refreshToken)


    if (edir.creator == username) {
        return true
    } else {
        response.status(403).send('only creators are allowed to access this route')
        return false
    }
  }
}