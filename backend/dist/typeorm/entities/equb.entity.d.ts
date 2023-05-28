import { EqubMembers } from './members.entity';
import { Equbchatroom } from './equb.chatroom.entity';
import { BlackList } from './blackList.entity';
export declare class Equb {
    id: number;
    name: string;
    amount: number;
    creator: string;
    code: string;
    duration: number;
    countdown: number;
    minMembers: number;
    description: string;
    durationControl: number;
    active: boolean;
    blacklists: BlackList[];
    members: EqubMembers[];
    chatroom: Equbchatroom[];
}
