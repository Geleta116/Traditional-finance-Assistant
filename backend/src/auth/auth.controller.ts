import { Body, Controller, HttpCode, HttpStatus, Post, Res, UseGuards , Req, Get,} from '@nestjs/common';
import { AuthService } from './auth.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';
import {Response,Request} from 'express'
import { Authenticate } from './guards/authenticate.guard';
import { logInDTO } from '../DTO/userDTO/logInDTO/logIn.dto';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService){
    }
    


    // "name": "employee equb", "code": "IZDZTGML",


    // @HttpCode(HttpStatus.OK)
    @Post('login')
    async logIn(@Body() userdto:logInDTO ){
        
        const res_value = await this.authService.logIn(userdto.username, userdto.password)
        return res_value;

        // response.cookie('accessToken', access_token, { httpOnly: true });
        // response.cookie('refreshToken', refresh_token, { httpOnly: true })
    }

}
