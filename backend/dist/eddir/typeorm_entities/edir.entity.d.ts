import { Edirchatroom } from './edir_chatroom.entity';
import { Edirmembers } from './edir_members.entity';
export declare class Edir {
    id: number;
    name: string;
    amount: number;
    balance: number;
    active: boolean;
    creator: string;
    code: string;
    countdown: number;
    duration: number;
    durationControl: number;
    members: Edirmembers[];
    chatroom: Edirchatroom[];
}
