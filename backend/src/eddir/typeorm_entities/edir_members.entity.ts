import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm'
import { Edir } from './edir.entity'

@Entity()
export class Edirmembers {
    
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    username: string;

    @Column({default:false})
    paid: boolean;

    @Column({default: 0})
    penality: number;

    @Column()
    date: Date;

    @ManyToOne(() => Edir, (edir) => edir.members, {onDelete : 'CASCADE'})
    edir: Edir;

}
