import { EqubService } from './equb.service';
import { Request } from 'express';
import { EqubDTO } from '../DTO/Equb_DTO/createEqubDTO/equb.dto';
import { EnrollDTO } from '../DTO/Equb_DTO/enrollDTO/enrollDTO.dto';
import { DeleteDTO } from '../DTO/Equb_DTO/deleteMemberDTO/deleteDTO.dto';
import { EqubChatDTO } from '../DTO/Equb_DTO/chatDTO/chatdto.dto';
export declare class EqubController {
    private readonly equbService;
    constructor(equbService: EqubService);
    createEqub(equbdto: EqubDTO, req: Request): Promise<any>;
    joinEqub(enrolldto: EnrollDTO, req: Request): Promise<import("../typeorm/entities/members.entity").EqubMembers>;
    getAllEnrolledEqubs(req: Request): Promise<any[]>;
    getMembersOfEqub(id: number): Promise<import("../typeorm/entities/members.entity").EqubMembers[]>;
    getCurrentwinner(id: number): Promise<{
        name: string;
        username: string;
    }>;
    makePayment(id: number, req: Request): Promise<void>;
    getNotification(req: Request): Promise<import("../typeorm/entities/notification.entity").EqubNotification[]>;
    deleteNotification(id: number): Promise<import("typeorm").DeleteResult>;
    getMembersInBlackList(id: number, req: Request): Promise<import("../typeorm/entities/blackList.entity").BlackList[]>;
    updateEqub(id: number, equbdto: EqubDTO, req: Request): Promise<import("typeorm").UpdateResult>;
    deleteMember(deletedto: DeleteDTO): Promise<import("typeorm").DeleteResult | "cannot delete active equbs member">;
    sendMessage(id: number, equbChatDTO: EqubChatDTO, req: Request): Promise<import("../typeorm/entities/equb.chatroom.entity").Equbchatroom>;
    getMessage(id: number): Promise<import("../typeorm/entities/equb.chatroom.entity").Equbchatroom[]>;
}
