import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm'
import { EqubMembers } from './members.entity'
import { Equbchatroom } from './equb.chatroom.entity'
import { BlackList } from './blackList.entity'

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

    @OneToMany(() => BlackList, (member) => member.id,{onDelete : 'CASCADE'})
    blacklists: BlackList[]

    @OneToMany(() => EqubMembers, (member) => member.id,{onDelete : 'CASCADE'})
    members: EqubMembers[]
    
    @OneToMany(() => Equbchatroom, (chatroom) => chatroom.id,{onDelete : 'CASCADE'})
    chatroom: Equbchatroom[]

}
