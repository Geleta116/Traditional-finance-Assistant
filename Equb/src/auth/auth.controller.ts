import { Body, Controller, HttpCode, HttpStatus, Post, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';
import { AccessTokenGuard } from './guards/auth.guard';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService){}
    
    @HttpCode(HttpStatus.OK)
    @Post('login')
    logIn(@Body() userdto:UserDTO){
        return this.authService.logIn(userdto.username, userdto.password)
    }
}
