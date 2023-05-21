import { Body, Controller, HttpCode, HttpStatus, Post, Res, UseGuards , Req, Get,} from '@nestjs/common';
import { AuthService } from './auth.service';
import { UserDTO } from 'src/DTO/userDTO/user.dto';
import {Response,Request} from 'express'
import { Authenticate } from './guards/authenticate.guard';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService){
    }
    
    @HttpCode(HttpStatus.OK)
    @Post('login')
    async logIn(@Body() userdto:UserDTO, @Req() req: Request, @Res({ passthrough: true }) response: Response){
        const [access_token, refresh_token] = await this.authService.logIn(userdto.username, userdto.password)

        response.cookie('accessToken', access_token, { httpOnly: true });
        response.cookie('refreshToken', refresh_token, { httpOnly: true })
    }

    @Get('logout/')
    @UseGuards(Authenticate)
    @HttpCode(HttpStatus.OK)
    async logout( @Res({ passthrough: true }) response: Response){
        response.cookie('accessToken', "", { httpOnly: true });
        response.cookie('refreshToken', "", { httpOnly: true });
    }
}
