import { Body, Controller, Delete, Get, HttpCode, HttpStatus, Param, Post, Req, UseGuards } from '@nestjs/common';
import { EqubService } from './equb.service';
import { AccessTokenGuard } from '../auth/guards/auth.guard';
import { EqubDTO } from '../DTO/equbDTO/equb.dto';
import { Request } from 'express';
import { EnrollDTO } from '../DTO/enrollDTO/enrollDTO.dto';


@Controller('equb')
export class EqubController {
    constructor(private readonly equbService: EqubService){}
    
    @UseGuards(AccessTokenGuard)
    @Post('create/')
    @HttpCode(HttpStatus.OK) 
    createEqub(@Body() equbdto: EqubDTO, @Req() req:Request){  // create new Equb
        const usr = req.user['username']
        return this.equbService.createEqub(equbdto, usr)
    }

    @UseGuards(AccessTokenGuard)
    @Get()
    getCreatedEqubs(@Req() req:Request){ // get all list of equbs created by current / logged in user
        const usr = req.user['username']
        return this.equbService.getCreatedEqubs(usr)
    }


    @UseGuards(AccessTokenGuard)
    @Get('enrolled/')
    getEnrolledEqub(@Req() req:Request){ // get all list of equbs joined / enrolled equbs
        const usr = req.user['username']
        return this.equbService.getJoinedEqubs(usr)
    }


    @UseGuards(AccessTokenGuard)
    @Post('join/')
    joinEqub(@Body() enrolldto:EnrollDTO,@Req() req:Request){  // join an equb by its code
        const usr = req.user['username']
        return this.equbService.joinEqub(enrolldto.code, usr)
    }

    @Get('members/:id')
    getMembersOfEqub(@Param() id: number){  // get all members of an equb
        return this.equbService.getMembersOfEqub(id)
    }

    @Post('activate/:id')
    activate(@Param() id:number){
        return this.equbService.activateEqub(id)
    }

    @UseGuards(AccessTokenGuard)
    @Post('pay/:id')
    makePayment(@Param() id:number, @Req() req:Request){
        const usr = req.user['username']
        return this.equbService.payEqub(usr, id)
    }
    @Delete('/:id')
    deleteEqub(@Param() id:number){
        return this.equbService.deleteEqub(id)
    }

    @Get('notification')
    getNotification(@Req() req:Request){
        const usr = req.user['username']
        return this.equbService.getNotification(usr)
    }
}
