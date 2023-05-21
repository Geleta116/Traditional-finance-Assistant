import { Body, Controller, Param, Post,Get, UseGuards ,Res
,Req} from '@nestjs/common';
import { UserService } from './user.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';
import { Authenticate } from '../auth/guards/authenticate.guard';
import {Response,Request} from 'express'
import { AuthService } from '../auth/auth.service';

@Controller('user')
export class UserController {
    constructor(
        private readonly userService:UserService,
        private readonly authService: AuthService,
        ) {}

    @Post('signup/')
    async signUp(@Body() userdto:UserDTO, @Res({ passthrough: true }) response: Response){
        const newUser = await this.userService.signUp(userdto);
        const [access_token, refresh_token] = await this.authService.getToken(newUser.id, newUser.username)

        response.cookie('accessToken', access_token, { httpOnly: true });
        response.cookie('refreshToken', refresh_token, { httpOnly: true })
        
    }

 

    @Get('info/:username')
    @UseGuards(Authenticate)
    getUserInfo(@Param() username: string){
        return this.userService.getUserInfo(username);
    }
}
