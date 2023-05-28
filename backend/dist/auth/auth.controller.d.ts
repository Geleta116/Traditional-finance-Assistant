import { AuthService } from './auth.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';
import { Response, Request } from 'express';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    logIn(userdto: UserDTO, req: Request, response: Response): Promise<{
        token: any;
    }>;
}
