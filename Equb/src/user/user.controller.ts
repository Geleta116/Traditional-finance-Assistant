import { Body, Controller, Post } from '@nestjs/common';
import { UserService } from './user.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';

@Controller('user')
export class UserController {
    constructor(private readonly userService:UserService) {}

    @Post('signup/')
    signUp(@Body() userdto:UserDTO){
        return this.userService.signUp(userdto);
    }
}
