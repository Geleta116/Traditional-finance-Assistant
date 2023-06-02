import { JwtService } from '@nestjs/jwt';
import { User } from 'src/typeorm/entities/user.entity';
import { Repository } from 'typeorm';
export declare class AuthService {
    private jwtService;
    private userRepository;
    constructor(jwtService: JwtService, userRepository: Repository<User>);
    getToken(userID: number, username: string): Promise<string>;
    validateToken(token: string): Promise<any>;
    logIn(username: string, pass: string): Promise<any>;
    currentUser(username: any): Promise<User>;
}
