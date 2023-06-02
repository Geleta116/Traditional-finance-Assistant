import { Request } from 'express';
import { Body, Controller, Delete, Get, Param, Post, Req, UseGuards } from '@nestjs/common';
import { EdirDTO } from '../DTO/EdirDTO/creatEdirDTO/edir.dto';
import { JoinEdirDTO } from '../DTO/EdirDTO/joinDTO/join.dto';
import { DeleteEdirMemberDTO } from '../DTO/EdirDTO/deleteMember/deleteMember.dto';
import { EdirChatDTO } from '../DTO/EdirDTO/chatDTO/chat.dto';
import { EddirService } from './eddir.service';
import { Authenticate } from '../auth/guards/authenticate.guard';
import { EdirAuthorize } from '../auth/guards/EdirAuthorization.guard';
import { EdirNotificationDTO } from '../DTO/EdirDTO/notificationDTO/notification.dto';

@Controller('edir')
export class EddirController {
    constructor(private readonly edirService: EddirService) {}

    @Post('create/')
    @UseGuards(Authenticate)
    async createEdir(@Body() data: EdirDTO, @Req() req:Request){
        console.log(data)
        console.log("hello")
        const creator = req.user['username']
        return this.edirService.createEdir(data, creator)
    }

    @Post('join/')   
    @UseGuards(Authenticate)    
    async joinEdir(@Body() dto: JoinEdirDTO, @Req() req:Request){
        const username = req.user['username']
        return this.edirService.joinEdir(dto.name, dto.code ,username)
    }

    @Post('delete/:id')
    @UseGuards(Authenticate, EdirAuthorize)
    async deleteEdir(@Param() id: number){
        return this.edirService.deleteEdir(id)
    }


    @Post('leave/:id')
    @UseGuards(Authenticate)
    async leaveEdir(@Param() id: number, @Req() req:Request){
        const username = req.user['username']
        return this.edirService.leaveEdir(id,username)
    }


    @Post('update/:id')
    @UseGuards(Authenticate, EdirAuthorize)
    async updateEdir(@Param() id:number, @Body() dto: EdirDTO){
        return this.edirService.updateEdir(id,dto)
    }



    @Delete("deletemember/:id")
    @UseGuards(Authenticate, EdirAuthorize)
    async deleteMember(@Param() id:number, @Body() dto: DeleteEdirMemberDTO){
        return this.edirService.deleteMember(id, dto.username)
    }


    @Get('all')
    @UseGuards(Authenticate)
    async getAllEdirs(@Req() req: Request){
        console.log("hello")
        const username = req.user["username"]
        return this.edirService.getAllEdirs(username)
    }


    @Post('pay/:edirName')
    @UseGuards(Authenticate)
    async payEdir(@Req() req: Request, @Param() edirName:String){
        console.log('edir pay')
        console.log(edirName) 
        console.log("hello")   
        const username = req.user["username"]
        return this.edirService.payEdir(username, edirName["edirName"])
    }


    @Get('members/:id')
    @UseGuards(Authenticate)
    async getMembers(@Param() id:number){
        return this.edirService.getMembersOfEdir(id)
    }


    @Get('notification')
    @UseGuards(Authenticate)
    async getNotification(@Req() req: Request){
        const username = req.user["username"]
        return this.edirService.getNotification(username)
    }

    @Post('notify/:id')
    @UseGuards(Authenticate)
    async notifyDeath(@Body() notificationdto:EdirNotificationDTO, @Param() id:number){
        return this.edirService.notification(notificationdto.notification, id)
    }




    @Delete('notification/:id')
    @UseGuards(Authenticate)
    async deleteNotification(@Param() id:number){
        return this.edirService.deleteNotification(id)
    }

    @Post('sendmessage/:id')
    @UseGuards(Authenticate)
    async sendMessage(@Param() id:number, @Body() edirChatDTO: EdirChatDTO, @Req() req: Request){
        const username = req.user["username"]
        return this.edirService.sendMessage(username, edirChatDTO.message,id)
    }

    @Get('getmessage/:')
    @UseGuards(Authenticate)
    async getMessage(@Param() id:number){
        return this.edirService.getChat(id)
    }
}
