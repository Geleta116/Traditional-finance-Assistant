import { JwtService } from '@nestjs/jwt';
import { Repository } from 'typeorm';
import { User } from '../typeorm/user entities/user.entity';
export declare class AuthService {
    private jwtService;
    private userRepository;
    constructor(jwtService: JwtService, userRepository: Repository<User>);
    getToken(userID: number, username: string): Promise<[string]>;
    validateToken(token: string): Promise<any>;
    logIn(username: string, pass: string): Promise<any>;
    currentUser(username: any): Promise<User>;
}
