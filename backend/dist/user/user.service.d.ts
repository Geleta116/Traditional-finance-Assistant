import { User } from 'src/typeorm/entities/user.entity';
import { Repository } from 'typeorm';
export declare class UserService {
    private userRepository;
    constructor(userRepository: Repository<User>);
    signUp(userdata: any): Promise<User[]>;
    getUserInfo(username: any): Promise<User>;
    changePassword(username: any, oldpassword: any, newpassword: any): Promise<User>;
    makeDeposit(username: any, amount: any): Promise<User>;
}
