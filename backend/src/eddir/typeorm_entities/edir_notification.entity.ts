import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm'

@Entity()

export class EdirNotifications {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    username: string

    @Column()
    notification: string
}
