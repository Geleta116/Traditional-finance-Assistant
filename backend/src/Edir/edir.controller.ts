// import { Controller } from '@nestjs/common';
import { Request } from 'express';
import { Body, Controller, Delete, Get, Param, Post, Req } from '@nestjs/common';
import { EdirService } from './edir.service';
import { EdirDTO } from '../DTO/EdirDTO/creatEdirDTO/edir.dto';
import { JoinEdirDTO } from '../DTO/EdirDTO/joinDTO/join.dto';
import { DeleteEdirMemberDTO } from '../DTO/EdirDTO/deleteMember/deleteMember.dto';
import { EdirChatDTO } from '../DTO/EdirDTO/chatDTO/chat.dto';

@Controller('edir')
export class EdirController {
    constructor(private readonly edirService: EdirService) {}
    
    @Post('create/')
    async createEdir(@Body() data: EdirDTO, @Req() req:Request){
        const creator = req.user['username']
        return this.edirService.createEdir(data, creator)
    }

    @Post('join/')       
    async joinEdir(@Body() dto: JoinEdirDTO, @Req() req:Request){
        const username = req.user['username']
        return this.edirService.joinEdir(dto.name, dto.code ,username)
    }

    @Post('deleteedir/:id')
    async DeleteEdir(@Param() id: number){
        return this.edirService.deleteEdir(id)
    }

    @Post('update/:id')
    async updateEdir(@Param() id:number, @Body() dto: EdirDTO){
        return this.edirService.updateEdir(id,dto)
    }



    @Delete("deletemember/:id")
    async deleteMember(@Param() id:number, @Body() dto: DeleteEdirMemberDTO){
        return this.edirService.deleteMember(id, dto.username)
    }

    @Get('alledirs')
    async getAllEdirs(@Req() req: Request){
        const username = req.user["username"]
        return this.edirService.getAllEdirs(username)
    }


    @Post('payedir/:id')
    async payEdir(@Req() req: Request, @Param() id:number){
        const username = req.user["username"]
        return this.edirService.payEdir(username, id)
    }

    @Get('members/:id')
    async getMembers(@Param() id:number){
        return this.edirService.getMembersOfEdir(id)
    }

    @Get('notification')
    async getNotification(@Req() req: Request){
        const username = req.user["username"]
        return this.edirService.getNotification(username)
    }

    @Delete('notification/:id')
    async deleteNotification(@Param() id:number){
        return this.edirService.deleteNotification(id)
    }

    @Post('sendmessage/:id')
    async sendMessage(@Param() id:number, @Body() edirChatDTO: EdirChatDTO, @Req() req: Request){
        const username = req.user["username"]
        return this.edirService.sendMessage(username, edirChatDTO.message,id)
    }

    @Get('getmessage/:')
    async getMessage(@Param() id:number){
        return this.edirService.getChat(id)
    }
}



