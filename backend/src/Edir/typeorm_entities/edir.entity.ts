import { Edirchatroom } from './edir_chatroom.entity'
import { Edirmembers } from './edir_members.entity'
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm'

@Entity()
export class Edir {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    name: string

    @Column()
    amount: number

    @Column({default : 0})
    balance: number

    @Column({default : false})
    active : boolean

    @Column()
    creator: string


    @Column({default : ''})
    code: string

    @Column()
    countdown: number

    @Column()
    duration: number

    

    @Column()
    description: string

    @Column({default : 0})
    durationControl: number

   


    @OneToMany(() => Edirmembers, (member) => member.id,{onDelete : 'CASCADE'})
    members: Edirmembers[]

    @OneToMany(() => Edirchatroom, (chatroom) => chatroom.id,{onDelete : 'CASCADE'})
    chatroom: Edirchatroom[]
    // @Column()
    // chatroomid: number

    // @OneToMany(() => Edirchatroom, (chat) => chat.id,{onDelete : 'CASCADE'})
    // chat: Edirchatroom[]
    
}





