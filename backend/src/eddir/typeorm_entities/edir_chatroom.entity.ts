import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm'
import { Edir } from './edir.entity'

@Entity()
export class Edirchatroom {
    
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    username: string;

    @Column()
    sentdate : Date

    @ManyToOne(() => Edir, (edir) => edir.chatroom, {onDelete : 'CASCADE'})
    edir: Edir;

}
