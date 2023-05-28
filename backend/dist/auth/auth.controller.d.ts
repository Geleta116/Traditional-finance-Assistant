import { AuthService } from './auth.service';
import { logInDTO } from '../DTO/userDTO/logInDTO/logIn.dto';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    logIn(userdto: logInDTO): Promise<{
        token: any;
    }>;
}
