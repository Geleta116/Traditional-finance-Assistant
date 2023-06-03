import { Request } from 'express';
import { EdirDTO } from '../DTO/EdirDTO/creatEdirDTO/edir.dto';
import { JoinEdirDTO } from '../DTO/EdirDTO/joinDTO/join.dto';
import { DeleteEdirMemberDTO } from '../DTO/EdirDTO/deleteMember/deleteMember.dto';
import { EdirChatDTO } from '../DTO/EdirDTO/chatDTO/chat.dto';
import { EddirService } from './eddir.service';
import { EdirNotificationDTO } from '../DTO/EdirDTO/notificationDTO/notification.dto';
export declare class EddirController {
    private readonly edirService;
    constructor(edirService: EddirService);
    createEdir(data: EdirDTO, req: Request): Promise<import("./typeorm_entities/edir.entity").Edir[]>;
    joinEdir(dto: JoinEdirDTO, req: Request): Promise<import("./typeorm_entities/edir_members.entity").Edirmembers>;
    deleteEdir(edirName: String): Promise<import("typeorm").DeleteResult>;
    leaveEdir(id: number, req: Request): Promise<import("typeorm").DeleteResult>;
    updateEdir(id: number, dto: EdirDTO): Promise<import("typeorm").UpdateResult>;
    deleteMember(id: number, dto: DeleteEdirMemberDTO): Promise<import("typeorm").DeleteResult | "Edir doesn't exist">;
    getAllEdirs(req: Request): Promise<any[]>;
    payEdir(req: Request, edirName: String): Promise<void>;
    getMembers(id: number): Promise<import("./typeorm_entities/edir_members.entity").Edirmembers[]>;
    getNotification(req: Request): Promise<import("./typeorm_entities/edir_notification.entity").EdirNotifications[]>;
    notifyDeath(notificationdto: EdirNotificationDTO, id: number): Promise<void>;
    deleteNotification(id: number): Promise<import("typeorm").DeleteResult>;
    sendMessage(id: number, edirChatDTO: EdirChatDTO, req: Request): Promise<import("./typeorm_entities/edir_chatroom.entity").Edirchatroom>;
    getMessage(id: number): Promise<import("./typeorm_entities/edir_chatroom.entity").Edirchatroom[]>;
}
