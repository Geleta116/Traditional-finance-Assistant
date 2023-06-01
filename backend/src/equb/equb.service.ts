import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cron } from '@nestjs/schedule';
import { HttpStatus, Injectable, Logger } from '@nestjs/common';
import { UserService } from '../user/user.service'
import { HttpException } from '@nestjs/common';
import { EqubMembers } from '../typeorm/equb entities/members.entity';
import { Equb } from '../typeorm/equb entities/equb.entity';
import { User } from '../typeorm/user entities/user.entity';
import { EqubNotification } from '../typeorm/equb entities/notification.entity';
import { BlackList } from '../typeorm/equb entities/blackList.entity';
import { Equbchatroom } from '../typeorm/equb entities/equb.chatroom.entity';

@Injectable()
export class EqubService {

    constructor(
        @InjectRepository(EqubMembers) private memebersRepository: Repository<EqubMembers>,
        @InjectRepository(Equb) private equbRepository: Repository<Equb>,
        @InjectRepository(User) private userRepository: Repository<User>,
        @InjectRepository(EqubNotification) private notificationRepository: Repository<EqubNotification>,
        @InjectRepository(BlackList) private blacklistRepository: Repository<BlackList>,
        @InjectRepository(Equbchatroom) private equbchatroomRepository: Repository<Equbchatroom>,

        private readonly userService: UserService
    ){}

    private readonly logger = new Logger(EqubService.name);
    // Every day at 6am : @Cron('0 6 * * *')
    // Every second: @Cron('* * * * * *')
    // Every minute: @Cron('0 * * * * *') 
    // @Cron('* * * * * *')

    generateRandomString(length: number) { // generate a random code uses to join EQUB
        let result = '';
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const charactersLength = characters.length;
        for (let i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }


    // CREATE NEW EQUB
    async createEqub(equb, usr): Promise<any> {
        if (await this.checkRedundency(usr, equb.name)){
            throw new HttpException('You are already a member of an equb', HttpStatus.CONFLICT);
        }
        else {
            const code = await this.generateRandomString(8)
            const name = equb.name.toLowerCase();

            const newEqubData = {
                ...equb,
                name: name,
                creator:usr,
                code:code
            }
                
            const newEqub = await this.equbRepository.create(newEqubData)
            await this.equbRepository.save(newEqub)
            await this.joinEqub(equb.name,code,usr)
            return newEqub
        }
        
    }



    // A USER CAN join an equb by its code
    async joinEqub(equbName, code, username){
        if (await this.checkRedundency(username, equbName)){
            throw new HttpException('You are already a member of an equb', HttpStatus.CONFLICT);
        }
        else {
            const equb = await this.equbRepository.findOne({where : {code:code, name:equbName}}) 
            
            if (!equb){
                // throw new Error()
                throw new HttpException('Equb not found', HttpStatus.CONFLICT);
            }
            if (equb.active){
                throw new HttpException('Equb is already active, It is not permissible to join active equb', HttpStatus.CONFLICT);
                // throw new Error('')
            }

            const isJoinedAlready = await this.memebersRepository.findOneBy({
                username : username,
                equb : equb
            })


            if (isJoinedAlready){
                throw new HttpException('you have already joined the equb', HttpStatus.CONFLICT);
            }


            // Mock money , to avoid insufficient balance during each month payment.
            // const user = await this.userRepository.findOne({where : {username:username}})
            // user.balance += (equb.amount * equb.minMembers * 3)
            // await this.userRepository.save(user)

            const data = {
                username:username,
                equb:equb
            }

            const member = await this.memebersRepository.create(data)
            return await this.memebersRepository.save(member)
        }
    }

    // DELETE AN EQUB
    async deleteEqub(equbId){
        const equb = await this.equbRepository.findOne({where : {id: equbId}})
        if (!equb.active){
            return await this.equbRepository.delete({id: equbId})
        }
        // throw new Error('')
        throw new HttpException('Cannot delete an active equb', HttpStatus.CONFLICT);
    }


    async updateEqub(equbId,equbdata){
        const equb = await this.equbRepository.findOneBy(equbId)
        if (!equb.active){
            return await this.equbRepository.update({id: equbId},equbdata)
        }
        // throw new Error('')
        throw new HttpException('Cannot update an active equb', HttpStatus.CONFLICT);

    }


    async deleteMember(username,equbId){
        const equb = await this.equbRepository.findOne({where: {id:equbId}})

        if (equb?.active == false){
            return await this.memebersRepository.delete({equb, username})
        }
        else {
            // return ""
            throw new HttpException('cannot delete active equbs member', HttpStatus.CONFLICT);

        }
    }


    async getAllEqubs(username:string){

        const listOfEqubs = []
        
        const created_equbs = await this.equbRepository.find({ where: { creator:username } })
        for (let equb of created_equbs){
            listOfEqubs.push({
                equb: equb,
                creator: true,
                no_members : (await this.getMembersOfEqub(equb.id)).length ,
                canPay : await this.canPay(username, equb.id)
            })
        }

        const joined_equbs = await this.memebersRepository.find({
            where: {
                username: username
            },
            relations: ['equb']
        })
        for (let data of joined_equbs){
            if (!created_equbs.includes(data.equb)) {
                listOfEqubs.push({
                    equb : data.equb, 
                    creator : false, 
                    no_members : (await this.getMembersOfEqub(data.equb.id)).length,
                    canPay : await this.canPay(username, data.equb.id)
                
                })
            }
        }


        return listOfEqubs
    }


    async checkRedundency(username, name){
        
        const allequbs = await this.getAllEqubs(username)
        let equbname = name.toLowerCase()
        
        for (let equb of allequbs){
            if (equb.name == equbname){
                return true
            }
        }
        return false
        
    }


    getDataAboutEqub(equbId){
        return this.equbRepository.findOne({where : {id :equbId}})
    }


    // GET ALL MEMBERS OF AN EQUB
    async getMembersOfEqub(equbid){ // get all members of an equb
        const memebers = await this.memebersRepository.find({
            where : {equb :equbid },
        })
        const listofmembers = []

        for (let member of memebers){
            const user = await this.userService.getUserInfo(member.username)
            const data = {
                name : user.fullName,
                username : user.username,
                won : member.won,
            }

            listofmembers.push(data)

        }
        return listofmembers
    }


    // GET SINGLE MEMEBR OF AN EQUB
    async getSingleMemberOfEqub(equbid, username){ 
        const member = await this.memebersRepository.findOne({
            where : {equb: equbid, username: username}
        })

        return member
    }


    async getUnwonMembers(equbId){
        const members = await this.memebersRepository.find({
            where : {equb :equbId, won: false },
        })
        return members
    }

    async getCurrentWinner(equbId){
        const winner = await this.memebersRepository.findOne({
            where : {equb :equbId, won: true, currentWinner: true },
        })

        if (winner){
            const winnersData = await this.userRepository.findOne({
                where : {
                    username : winner.username
                }
            })
    
            return {
                name: winnersData.fullName,
                username : winnersData.username
            }
        }
        throw new HttpException('there is no winner in this month', HttpStatus.CONFLICT);

        
    }




    async payEqub(username, equbId){
        const user = await this.userRepository.findOneBy({username})
        const equb = await this.equbRepository.findOneBy(equbId)

        if (user.balance < equb.amount){
            throw new HttpException('insufficient balance', HttpStatus.CONFLICT);
        }
        else {
            user.balance = user.balance - equb.amount
            await this.userRepository.save(user)
    
            await this.memebersRepository.update({equb:equbId, username: username},{paid: true });

        }
    }

    async canPay(username, equbId){
        const underBlacklist = await this.blacklistRepository.findOne({
            where : {
                username : username,
                equb : equbId
            }
        })
        
        const equb = await this.memebersRepository.findOne({
            where : {
                username : username,
                equb : equbId
            }
        })

        if (!equb){
            return true

        }
        const isPaid = equb.paid

        if (underBlacklist || isPaid){
            return false
        }
        return true
    }


    async addToBlackList(equbId){
        const unpaidMembers = await this.memebersRepository.find({ where : {equb :equbId,paid:false }})
        const equb = await this.equbRepository.findOneBy(equbId)

        for (let member of unpaidMembers){
            const blacklist = await this.blacklistRepository.create({
                username: member.username,
                equb : equb
            })
            await this.blacklistRepository.save(blacklist)
            
        }
    }

    async blackListMembers(equbid){
        return this.blacklistRepository.find({where : {equb :equbid }})
    }



    // determine the winner and announce it
    async determineTheWinner(equbId){ 
        const equb = await this.equbRepository.findOne({where : {id : equbId}})
        const members = await this.getMembersOfEqub(equbId) 


        const previously_unwon_members = await this.memebersRepository.find({
            where : {
                equb: equbId,
                won: false
            }
        })

        // RANDOMLY SELECT WINNER 
        let winnerIndex; // if there is only one unwon member
        if (previously_unwon_members.length > 1) {
            winnerIndex = Math.floor(Math.random() * (previously_unwon_members.length));
        }
        else {
            winnerIndex = 0
            }
        
        const winner = previously_unwon_members[winnerIndex].username

        // UPDATE THE WINNER , EXCLUDE FROM FUTURE LOTTERY
        let currentWinner = await this.getSingleMemberOfEqub(equbId, winner)
        currentWinner.won =  true
        await this.memebersRepository.save(currentWinner)

        // UPDATE THE WINNERS BALANCE
        const user = await this.userRepository.findOneBy({username: winner})
        user.balance = user.balance + (equb.amount * members.length)
        await this.userRepository.save(user)


        // NOTIFY THE WINNER
        const winnerName = (await this.userRepository.findOneBy({username: winner})).fullName
        // const winnerName = (await this.userService.getUserInfo(winner)).fullName
        await this.notification(`${winnerName} won this equb`, equbId)

        const previous_winner = await this.memebersRepository.findOne({
            where : {
                equb: equbId,
                won: true,
                currentWinner: true
            }
        })
        if (previous_winner) {
            previous_winner.currentWinner = false
            await this.memebersRepository.save(previous_winner)
        }
        currentWinner.currentWinner = true
        await this.memebersRepository.save(currentWinner)




        // if there were only one unwon member, make him won and end the equb
        if (previously_unwon_members.length == 1){ 
            await this.notification(`${equb.name} is finished , thanks for your involvement`, equbId)
            equb.active = false
            await this.equbRepository.save(equb)
            return await this.deleteEqub(equbId)
        }

        // if there were more than one unwon member, make the winner won and continue the equb 
        for (let member of members){
            const memeberData = await this.memebersRepository.findOne({where : {id : member.id}})
            memeberData.paid = false
            await this.memebersRepository.save(memeberData)
        }

        // await this.notifyUnpaidUsers(equbId) // notify all members to pay.


    }


    async notification(message:string, equbId){
        const members = await this.getMembersOfEqub(equbId)
        for (let member of members){
            const notification_data =  {
                username :member.username,
                notification: message
            }
            const notification = this.notificationRepository.create(notification_data);
            await this.notificationRepository.save(notification)
            
        }
    }

    async notifyUnpaidUsers(equbId){ // make notification for all members, who didn't pay until 3 days
        const unpaidMembers = await this.memebersRepository.find({ where : {equb :equbId,paid:false }})
        const equb = await this.getDataAboutEqub(equbId)

        for (let member of unpaidMembers){
            const data =  {
                username :member.username,
                notification: `payment is required for ${equb.name}`
            }
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification)
        }
    }

    // get notification sent for a logged in user
    async getNotification(username){
        return this.notificationRepository.findBy({username: username})
    }

    async deleteNotification(id){
        return await this.notificationRepository.delete(id)
    }


    async sendMessage(username,message, equbId){
        const equb = await this.equbRepository.findOneBy({id:equbId})

        const chat_data = {
            sentdate : Date.now() ,
            username : username,
            message : message,
            equb : equb
        }
        const chat = await this.equbchatroomRepository.create(chat_data);
        return await this.equbchatroomRepository.save(chat)
    }

    async getChat(equbId){
        return await this.equbchatroomRepository.find({
            where : {equb : equbId},
            order: { sentdate: 'DESC' },
        })
    }

    



    //  function that runs daily
    // 1. check if the winner announcement date is reached or not
    // 2. if the date is reached announce the user , notify for the next month payment
    // 3. else:
    // 4.  update the date controlling 

    // @Cron('* * * * * *')
    async  dailyFunction(){ 
        // check to begin running an equb
        const not_beginned_equbs = await this.equbRepository.find({where : {active : false}})

        for (let equb of not_beginned_equbs){
            const no_members = await (await this.getMembersOfEqub(equb.id)).length

            if (equb.countdown == 0){
                if (no_members >= equb.minMembers){
                    equb.active = true
                    await this.equbRepository.save(equb)
                }
                else{
                    await this.deleteEqub(equb.id)
                }
            }

            else {
                equb.countdown -= 1
                await this.equbRepository.save(equb)
            }
            
        }


        const active_equbs = await this.equbRepository.find({where : {active : true}}) // get all currently running equbs
        
        for (let equb of active_equbs){
            const equbdata = await this.equbRepository.findOne({where : {id : equb.id}})

            equbdata.durationControl += 1
            await this.equbRepository.save(equbdata)

            if (equb.durationControl == equb.duration){ // if the winning time announcement is reached
                await this.determineTheWinner(equb.id)

                // if the equb is not over yet,reset the duration control
                if (await this.equbRepository.findOneBy({id : equb.id})){
                    let equbData = await this.equbRepository.findOneBy({id : equb.id})
                    equbData.durationControl = 0
                    await this.equbRepository.save(equbData)
                }
            } 


            else if (equb.durationControl < 3) { // wait till the users make payment for atleast 3 days , if (equb.durationControl <= 3)
                await this.notifyUnpaidUsers(equb.id)
            }

            else {  // if a user didn't pay , add him to black list
                await this.addToBlackList(equb.id)
            }
        }
    }
    
}