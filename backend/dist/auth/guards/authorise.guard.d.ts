import { ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';
import { EqubService } from '../../equb/equb.service';
export declare class Authorize {
    private readonly authService;
    private readonly equbService;
    constructor(authService: AuthService, equbService: EqubService);
    canActivate(context: ExecutionContext): Promise<any>;
}
