import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm'
import { Equb } from './equb.entity';

@Entity()
export class Equbchatroom {
    
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    username: string;

    @Column()
    sentdate : Date

    @ManyToOne(() => Equb, (equb) => equb.chatroom, {onDelete : 'CASCADE'})
    equb: Equb;

}
