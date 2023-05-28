import { ExecutionContext } from '@nestjs/common';
import { AuthService } from '../auth.service';
export declare class Authenticate {
    private readonly authService;
    constructor(authService: AuthService);
    canActivate(context: ExecutionContext): Promise<any>;
}
