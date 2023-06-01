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
import { DepositDTO } from '../DTO/userDTO/depositDTO/deposition.dto';

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
    
        
    
        @Get('info/')
        @UseGuards(Authenticate)
        getUserInfo(@Req() req:Request){
            
            const username = req.user["username"]
            console.log(username)
            return this.userService.getUserInfo(username);
        }


        @Post('deposit')
        @UseGuards(Authenticate)
        async makeDeposit(@Body() depositdto: DepositDTO, @Req() req:Request){
            const usernam = req.user["username"]
            console.log(usernam)
            let deposite = await this.userService.makeDeposit(usernam, depositdto.amount)
            console.log(deposite);
            return deposite;
        }
 

    // @Get('info/:username')
    // @UseGuards(Authenticate)
    // getUserInfo(@Param() username: string){
    //     return this.userService.getUserInfo(username);
    // }
}
