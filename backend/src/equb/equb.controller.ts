import { Body, Controller, Delete, Get, Param, Patch, Post, Req, UseGuards } from '@nestjs/common';
import { EqubService } from './equb.service';
import { Request } from 'express';
import { Authenticate } from '../auth/guards/authenticate.guard';
import { Authorize } from '../auth/guards/authorise.guard';
import { EqubDTO } from '../DTO/Equb_DTO/createEqubDTO/equb.dto';
import { EnrollDTO } from '../DTO/Equb_DTO/enrollDTO/enrollDTO.dto';
import { DeleteDTO } from '../DTO/Equb_DTO/deleteMemberDTO/deleteDTO.dto';
import { EqubChatDTO } from '../DTO/Equb_DTO/chatDTO/chatdto.dto';


// "name": "employee equb",
//     "amount": 1000,
//     "creator": "abebe",
//     "code": "EKOYOPOT",

@Controller('equb')
export class EqubController {
    constructor(private readonly equbService: EqubService){}

    @Post('create/')
    @UseGuards(Authenticate)
    createEqub(@Body() equbdto: EqubDTO, @Req() req:Request){  // create new Equb
        const usr = req.user['username']
        return this.equbService.createEqub(equbdto, usr)
    }

    @Post('join/')
    @UseGuards(Authenticate)
    joinEqub(@Body() enrolldto:EnrollDTO,@Req() req:Request){  // join an equb by its code
        const usr = req.user['username']
        const equbName = enrolldto.name.toLowerCase()
        const code = enrolldto.code.toUpperCase()
        return this.equbService.joinEqub(equbName, code, usr)
    }


    @Get('all/')
    @UseGuards(Authenticate)
    getAllEnrolledEqubs(@Req() req:Request){
        const usr = req.user['username']
        return this.equbService.getAllEqubs(usr)
    }



    @Get('members/:id')
    @UseGuards(Authenticate)
    getMembersOfEqub(@Param() id: number){  // get all members of an equb
        return this.equbService.getMembersOfEqub(id)
    }

    @Get('currentwinner/:id')
    @UseGuards(Authenticate)
    getCurrentwinner(@Param() id:number){
        return this.equbService.getCurrentWinner(id)
    }

    @Get('pay/:id')
    @UseGuards(Authenticate)
    makePayment(@Param() id:number, @Req() req:Request){
        const usr = req.user['username']
        return this.equbService.payEqub(usr, id)
    }


    @Get('notification')
    @UseGuards(Authenticate)
    getNotification(@Req() req:Request){
        const usr = req.user['username']
        return this.equbService.getNotification(usr)
    }

    @Delete('deleteNotification/:id')
    @UseGuards(Authenticate)
    deleteNotification(@Param() id:number){
        return this.equbService.deleteNotification(id)
    }

    
    @Get('blacklist/:id')
    @UseGuards(Authenticate, Authorize)
    getMembersInBlackList(@Param() id: number, @Req() req:Request){
        return this.equbService.blackListMembers(id)
    }

    @Patch('update/:id')
    @UseGuards(Authenticate, Authorize)
    updateEqub(@Param() id: number, @Body() equbdto: EqubDTO, @Req() req:Request){
        return this.equbService.updateEqub(id, equbdto)
    }

    @Delete('deleteMember')
    @UseGuards(Authenticate, Authorize)
    deleteMember(@Body() deletedto: DeleteDTO){
        return this.equbService.deleteMember(deletedto.username, deletedto.equbId)
    }

    @Post('sendmessage/:id')
    async sendMessage(@Param() id:number, @Body() equbChatDTO: EqubChatDTO, @Req() req: Request){
        const username = req.user["username"]
        return this.equbService.sendMessage(username, equbChatDTO.message,id)
    }

    @Get('getmessage/:')
    async getMessage(@Param() id:number){
        return this.equbService.getChat(id)
    }
}
