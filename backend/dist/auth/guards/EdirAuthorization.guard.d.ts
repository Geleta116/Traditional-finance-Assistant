import { ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';
import { EddirService } from '../../eddir/eddir.service';
export declare class EdirAuthorize {
    private readonly authService;
    private readonly edirService;
    constructor(authService: AuthService, edirService: EddirService);
    canActivate(context: ExecutionContext): Promise<any>;
}
