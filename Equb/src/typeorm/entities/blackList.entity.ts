import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm'
import { Equb } from './equb.entity'

@Entity()

export class BlackList {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    username: string

    @ManyToOne(() => Equb, (equb) => equb.members, {onDelete : 'CASCADE'})
    equb: Equb
}
