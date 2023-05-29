import { Repository } from 'typeorm';
import { User } from '../typeorm/user entities/user.entity';
export declare class UserService {
    private userRepository;
    constructor(userRepository: Repository<User>);
    signUp(userdata: any): Promise<User[]>;
    getUserInfo(username: any): Promise<User>;
    changePassword(username: any, oldpassword: any, newpassword: any): Promise<User>;
    makeDeposit(username: any, amount: any): Promise<User>;
}
