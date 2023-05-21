import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm'
import { Members } from './members.entity'

@Entity()

export class Equb {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    name: string

    @Column()
    amount: number


    @Column()
    creator: string


    @Column({default : ''})
    code: string

    @Column()
    duration: number

    @Column()
    countdown: number

    @Column({default: 5})
    minMembers: number


    @Column()
    description: string

    @Column({default : 0})
    durationControl: number

    @Column({default : false})
    active : boolean


    @OneToMany(() => Members, (member) => member.id,{onDelete : 'CASCADE'})
    members: Members[]
    
}
