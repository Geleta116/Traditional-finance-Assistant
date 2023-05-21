import { Column, Entity, OneToMany, PrimaryGeneratedColumn} from 'typeorm'


@Entity()

export class User{
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    fullName: string

    @Column()
    username: string

    @Column()
    email: string

    @Column({default : 0})
    balance : number

    @Column()
    password: string
}