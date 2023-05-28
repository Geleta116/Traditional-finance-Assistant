import { Request } from 'express';
import { EdirService } from './edir.service';
import { EdirDTO } from '../DTO/EdirDTO/creatEdirDTO/edir.dto';
import { JoinEdirDTO } from '../DTO/EdirDTO/joinDTO/join.dto';
import { DeleteEdirMemberDTO } from '../DTO/EdirDTO/deleteMember/deleteMember.dto';
import { EdirChatDTO } from '../DTO/EdirDTO/chatDTO/chat.dto';
export declare class EdirController {
    private readonly edirService;
    constructor(edirService: EdirService);
    createEdir(data: EdirDTO, req: Request): Promise<import("../eddir/typeorm_entities/edir.entity").Edir[]>;
    joinEdir(dto: JoinEdirDTO, req: Request): Promise<import("../eddir/typeorm_entities/edir_members.entity").Edirmembers>;
    DeleteEdir(id: number): Promise<import("typeorm").DeleteResult>;
    updateEdir(id: number, dto: EdirDTO): Promise<import("typeorm").UpdateResult>;
    deleteMember(id: number, dto: DeleteEdirMemberDTO): Promise<import("typeorm").DeleteResult | "Edir doesn't exist">;
    getAllEdirs(req: Request): Promise<any[]>;
    payEdir(req: Request, id: number): Promise<void>;
    getMembers(id: number): Promise<import("../eddir/typeorm_entities/edir_members.entity").Edirmembers[]>;
    getNotification(req: Request): Promise<import("../eddir/typeorm_entities/edir_notification.entity").EdirNotifications[]>;
    deleteNotification(id: number): Promise<import("typeorm").DeleteResult>;
    sendMessage(id: number, edirChatDTO: EdirChatDTO, req: Request): Promise<import("../eddir/typeorm_entities/edir_chatroom.entity").Edirchatroom>;
    getMessage(id: number): Promise<import("../eddir/typeorm_entities/edir_chatroom.entity").Edirchatroom[]>;
}
