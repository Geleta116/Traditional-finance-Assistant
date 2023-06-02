import { HttpException, HttpStatus, Injectable, Logger} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cron } from 'nestjs-schedule';
import { User } from '../typeorm/entities/user.entity';
import { Edir } from './typeorm_entities/edir.entity';
import { Edirmembers } from './typeorm_entities/edir_members.entity';
import { EdirNotifications } from './typeorm_entities/edir_notification.entity';
import { Edirchatroom } from './typeorm_entities/edir_chatroom.entity';

@Injectable()
export class EddirService {
    constructor(
        @InjectRepository(Edir) private edirRepository: Repository<Edir>,
        @InjectRepository(Edirmembers) private edirMembersRepository: Repository<Edirmembers>,
        @InjectRepository(User) private userRepository: Repository<User>,
        @InjectRepository(EdirNotifications) private notificationRepository: Repository<EdirNotifications>,
        @InjectRepository(Edirchatroom) private edirchatroomRepository: Repository<Edirchatroom>,

    ){}
    


    generateRandomString(length: number) { // generate a random code uses to join EQUB
        let result = '';
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const charactersLength = characters.length;
        for (let i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }

    async createEdir(edirdata, creator){
        const code = await this.generateRandomString(8)
        const name = edirdata.name.toLowerCase();

        const newEdirData = {
            ...edirdata,
            name: name,
            creator:creator,
            code:code
        }
            
        const edir = await this.edirRepository.create(newEdirData)
        await this.edirRepository.save(edir)
        await this.joinEdir(name,code,creator)
        return edir
    }






    // A USER CAN join an equb by its code
    async joinEdir(edirName, code, username){
        const edir = await this.edirRepository.findOne({where : {code:code, name:edirName}}) 
        
        if (!edir){
            throw new Error('Equb not found')
        }


        const data = {
            username:username,
            edir:edir
        }

        const member = await this.edirMembersRepository.create(data)
        return await this.edirMembersRepository.save(member)
        
    }


    async leaveEdir(id, username){
        const member = await this.edirMembersRepository.findOne({
            where : {
                edir : id,
                username : username
            }
        }
        )
        
        return await this.edirMembersRepository.delete({id : member.id})
        
    }


    // DELETE AN EDIR
    async deleteEdir(edirId){
        const edir = await this.edirRepository.findOne({where : {id: edirId}})
        if (edir){
            return await this.edirRepository.delete({id: edirId})
        }
        throw new Error("Edir doesn't exist")
    }


    async updateEdir(edirId,edirdata){
        const edir = await this.edirRepository.findOneBy(edirId)
        if (edir){
            return await this.edirRepository.update({id: edirId},edirdata)
        }
        throw new Error("Edir doesn't exist")
    }

    async deleteMember(username,edirId){
        const edir = await this.edirRepository.findOne({where: {id:edirId}})

        if (edir){
            return await this.edirMembersRepository.delete({edir, username})
        }
        else {
            return "Edir doesn't exist"
        }
    }


    async getAllEdirs(username:string){
        const listOfEdirs = []

        const created_edirs = await this.edirRepository.find({ where: { creator:username } })
        for (let edir of created_edirs){
            listOfEdirs.push({edir: edir, creator: true,no_members : (await this.getMembersOfEdir(edir.id)).length})
        }

        const joined_edirs = await this.edirMembersRepository.find({
            where: {username : username},
            relations: ['edir']
        })
        for (let data of joined_edirs){
            if (!created_edirs.includes(data.edir)) {
                listOfEdirs.push({edir : data.edir, creator : false, no_members : (await this.getMembersOfEdir(data.edir.id)).length})
            }
        }
        return listOfEdirs
    }


    async getDataAboutEdir(edirId){
        return await this.edirRepository.findOne({where : {id :edirId}})
    }


     // GET ALL MEMBERS OF AN Edir
     async getMembersOfEdir(edirId){ // get all members of an edir
        const members = await this.edirMembersRepository.find({
            where : {edir :edirId },
        })
        return members
    }

    // GET SINGLE MEMEBR OF AN Edir
    async getSingleMemberOfEdir(edirId, username){ 
        const member = await this.edirMembersRepository.findOne({
            where : {edir: { id: edirId }, username: username}
        })

        return member
    }


    async payEdir(username, edirName){
        const user = await this.userRepository.findOneBy({username})
        
        const edir = await this.edirRepository.findOne({where : {name :edirName}})
        const edirId = edir.id
        const penality = await (await this.getSingleMemberOfEdir(edirId, username)).penality
        
        if (user.balance + 500 < edir.amount + penality){
            throw new HttpException('Your balance is insufficient', HttpStatus.CONFLICT);
        }
        else{
            const payment_money = user.balance - edir.amount - penality
    
            user.balance -= payment_money
            edir.balance += payment_money
            await this.userRepository.save(user)
            await this.edirRepository.save(edir)
    
    
            await this.edirMembersRepository.update({edir:{id:edirId}, username: username},{paid: true });
        }
    }


    async notification(message:string, edirId){
        const members = await this.getMembersOfEdir(edirId)
        for (let member of members){
            const notification_data =  {
                username :member.username,
                notification: message
            }
            const notification = this.notificationRepository.create(notification_data);
            await this.notificationRepository.save(notification)  
        }
    }

    async notifyUnpaidUsers(edirId){ // make notification for all members, who didn't pay until 3 days
        const unpaidMembers = await this.edirMembersRepository.find({ where : {edir :edirId,paid:false }})
        const edir = await this.getDataAboutEdir(edirId)

        for (let member of unpaidMembers){
            const data =  {
                username :member.username,
                notification: `payment is for ${edir.name} is required required`
            }
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification)
        }
    }


    async getNotification(username){
        return this.notificationRepository.findBy({username: username})
    }

    async deleteNotification(id){
        return this.notificationRepository.delete({id: id})
    }


    async getPenalizedUsers(edirId){
        const unpaidMembers = await this.edirMembersRepository.find({ where : {edir :edirId,paid:false }})
        const edir = await this.edirRepository.findOneBy({id: edirId})

        for (let member of unpaidMembers){
            member.penality += (edir.amount * 0.1) // penality is 10 %

            await this.edirMembersRepository.save(member)


            // notify for penality
            const data =  {
                username :member.username,
                notification: `You are penalized , for not paying ${edir.name}`
            }
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification)
        }
    }


    async sendMessage(username,message, edirId){
        const edir = await this.edirRepository.findOneBy({id:edirId})

        const chat_data = {
            sentdate : Date.now() ,
            username : username,
            message : message,
            edir : edir
        }
        const chat = await this.edirchatroomRepository.create(chat_data);
        return await this.edirchatroomRepository.save(chat)
    }

    async getChat(edirId){
        return await this.edirchatroomRepository.find({
            where : {edir : edirId},
            order: { sentdate: 'DESC' },
        })
    }



    // @Cron('* * * * * *')
    async  dailyFunction(){ 
        // check to begin running an edir
        const not_acive_edirs = await this.edirRepository.find({where : {active : false}})

        for (let edir of not_acive_edirs){
            const no_members = (await this.getMembersOfEdir(edir.id)).length

            if (edir.countdown == 0){
                if (no_members >= 5){
                    edir.active = true
                    await this.edirRepository.save(edir)
                }
                else{
                    await this.deleteEdir(edir.id)
                }
            }

            else {
                edir.countdown -= 1
                await this.edirRepository.save(edir)
            }
            
        }


        const active_edir = await this.edirRepository.find({where : {active : true}}) // get all currently running equbs
        
        for (let edir of active_edir){
            const edirdata = await this.edirRepository.findOne({where : {id : edir.id}})

            edirdata.durationControl += 1
            await this.edirRepository.save(edirdata)

            if (edirdata.durationControl == edirdata.duration){ // if the winning time announcement is reached
                edirdata.durationControl = 0
                await this.edirRepository.save(edirdata)
                
            } 


            else if (edirdata.durationControl < 3) { // wait till the users make payment for atleast 3 days , if (equb.durationControl <= 3)
                await this.notifyUnpaidUsers(edirdata.id)
            }

            else if (edirdata.durationControl < 3) {  // if a user didn't pay , penalize im
                await this.getPenalizedUsers(edirdata.id)
                
            }
        }
    }
}
