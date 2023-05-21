import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm'
// import { Equb } from './equb.entity'

@Entity()

export class Notification {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    username: string

    @Column()
    notification: string

    @Column({default: false})
    seen: boolean
}
