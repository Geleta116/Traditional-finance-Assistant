import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm'
import { Equb } from './equb.entity'

@Entity()

export class Members {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    username: string

    @Column({default:false})
    won: boolean

    @Column({default:false})
    paid: boolean

    @ManyToOne(() => Equb, (equb) => equb.members, {onDelete : 'CASCADE'})
    equb: Equb
}
