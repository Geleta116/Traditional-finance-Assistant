import { Body, Controller, Param, Post,Get, UseGuards ,Res
,Req,
Patch} from '@nestjs/common';
import { UserService } from './user.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';
import { Authenticate } from '../auth/guards/authenticate.guard';
import {Response,Request} from 'express'
import { AuthService } from '../auth/auth.service';
import { SignUpDTO } from '../DTO/userDTO/signUpDTO/signUp.dto';
import { changePasswordDTO } from '../DTO/userDTO/updateDTO/changepassword.dto';

@Controller('user')
export class UserController {
    constructor(
        private readonly userService:UserService,
        private readonly authService: AuthService,
        ) {}



        @Post('signup/')
        async signUp(@Body() signupdto:SignUpDTO, @Res({ passthrough: true }) response: Response){
            return await this.userService.signUp(signupdto);
        }
    
        @Patch('changepassowrd/')
        @UseGuards(Authenticate)
        async changePassword(@Body() changepassworddto : changePasswordDTO, @Req() req:Request){
            const username = req.user['username']
            return await this.userService.changePassword(username,changepassworddto.oldpassword, changepassworddto.newpassword);
        }
    
        
    
        @Get('info/:username')
        @UseGuards(Authenticate)
        getUserInfo(@Param() username: string){
            return this.userService.getUserInfo(username);
        }


 

    // @Get('info/:username')
    // @UseGuards(Authenticate)
    // getUserInfo(@Param() username: string){
    //     return this.userService.getUserInfo(username);
    // }
}
