import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm'
// import { Equb } from './equb.entity'

@Entity()

export class EqubNotification {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    username: string

    @Column()
    notification: string
}
