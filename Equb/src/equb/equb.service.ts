import { Members } from 'src/typeorm/entities/members.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/typeorm/entities/user.entity';
import { Repository } from 'typeorm';
import { Equb } from '../typeorm/entities/equb.entity';
import { Notification } from '../typeorm/entities/notification.entity';
import { Cron } from '@nestjs/schedule';
import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class EqubService {

    constructor(
        @InjectRepository(Members) private memebersRepository: Repository<Members>,
        @InjectRepository(Equb) private equbRepository: Repository<Equb>,
        @InjectRepository(User) private userRepository: Repository<User>,
        @InjectRepository(Notification) private notificationRepository: Repository<Notification>,
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
        const code = await this.generateRandomString(6)
        const newEqubData = {
            ...equb,
            creator:usr,
            code:code}
        const newEqub = await this.equbRepository.create(newEqubData)
        await this.equbRepository.save(newEqub)
        
        await this.joinEqub(code,usr)
        return newEqub
    }



    // activate an equb , whenever the members agree to begin, and reached enough number of memebrs
    async activateEqub(equbId){ 
        console.log("equb activated", equbId)
        const equb = await this.equbRepository.findOneBy(equbId) 
        equb.start = true
        await this.equbRepository.save(equb)
        return await this.equbRepository.findOneBy({id:equbId})
    }


    // DELETE AN EQUB
    async deleteEqub(equbId){
        return await this.equbRepository.delete({id: equbId})
    }


    // A USER CAN join an equb by its code
    async joinEqub(code, username){ 
        const equb = await this.equbRepository.findOneBy({code}) 
        if (!equb){
            throw new Error('Equb not found')
        }
        const data = {
            username:username,
            equb:equb
        }
        const member = await this.memebersRepository.create(data)
        return await this.memebersRepository.save(member)
        
    }



    // get list of equbs created by current user
    async getCreatedEqubs(username){ 
        const equbs = await this.equbRepository.find({ where: { creator:username } })
        if (! equbs){
            throw  new Error('equbs not found')
        }
        return equbs
    }


    // get list of equbs the user joined / enrolled in
    async getJoinedEqubs(username){ 
        const equbs = await this.memebersRepository.find({
            where: {username : username},
            relations: ['equb']
        })

        const listOfEqubs = []
        for (let data of equbs){
            listOfEqubs.push(data.equb)
        }
        return listOfEqubs

    }



    // GET SINGLE MEMEBR OF AN EQUB
    async getSingleMemberOfEqub(equbid, username){ 
        const member = await this.memebersRepository.findOne({
            where : {equb: equbid, username: username}
        })

        return member
    }



    // GET ALL MEMBERS OF AN EQUB
    async getMembersOfEqub(equbid){ // get all members of an equb
        const memebers = await this.memebersRepository.find({
            where : {equb :equbid },
        })
        return memebers
    }


    async payEqub(username, equbId){

        await this.memebersRepository.update({equb:equbId, username: username},{paid: true });
    }



    //  function that runs daily
    // 1. check if the winner announcement date is reached or not
    // 2. if the date is reached announce the user , notify for the next month payment
    // 3. else:
    // 4.  update the date controlling 

    @Cron('* * * * * *')
    async  dailyFunction(){ 
        const equbs = await this.equbRepository.find({where : {start : true}}) // get all currently running equbs
        
        for (let equb of equbs){
            const equbdata = await this.equbRepository.findOne({where : {id : equb.id}})
            equbdata.durationControl += 1
            await this.equbRepository.save(equbdata)
            this.notifyUnpaidUsers(equb.id)

            if (equb.durationControl == equb.duration){ // if the winning time announcement is reached
                await this.determineTheWinner(equb.id)

                if (await this.equbRepository.findOneBy({id : equb.id})){ // if there is still left equb
                    let equbData = await this.equbRepository.findOneBy({id : equb.id})
                    equbData.durationControl = 0
                    await this.equbRepository.save(equbData)
                }
            } 


            else if (equb.durationControl <= 3) { // wait till the users make payment for atleast 3 days , if (equb.durationControl <= 3)
                await this.notifyUnpaidUsers(equb.id)
            }

            // else {  // if a user didn't pay , add him to black list
            //     // add the member to black list
            // }
        }
    }


    async notifyUnpaidUsers(equbId){ // make notification for all members, who didn't pay until 3 days
        const unpaidMembers = await this.memebersRepository.find({ where : {equb :equbId,paid:false }})
        
        for (let member of unpaidMembers){
            const data =  {
                username :member.username,
                notification: "payment is required"
            }
            // console.log("payment is required")
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification)
        }
    }



    // determine the winner and announce it
    async determineTheWinner(equbId){ 
        const previously_unwon_members = await this.memebersRepository.find({
            where : {
                equb: equbId,
                won: false
            }
        })

        // RANDOMLY SELECT WINNER 
        let winnerIndex = 0; // if there is only one unwon member
        if (previously_unwon_members.length > 1) {
            winnerIndex = Math.floor(Math.random() * (previously_unwon_members.length));
        };
        
        const winner = previously_unwon_members[winnerIndex].username

        // UPDATE THE WINNER , EXCLUDE FROM FUTURE LOTTERY
        let member = await this.getSingleMemberOfEqub(equbId, winner)
        member.won =  true
        await this.memebersRepository.save(member)

        // NOTIFY THE WINNER
        await this.notification(`${winner} won this equb`, equbId)

        // if there were only one unwon member, make him won and end the equb
        if (previously_unwon_members.length == 1){ 
            await this.notification(`${equbId} this equb is finished , thanks for your involvement`, equbId)
            return await this.deleteEqub(equbId)
        }


        // otherwise continue the process
        const members = await this.getMembersOfEqub(equbId) 
        for (let member of members){
            const memeberData = await this.memebersRepository.findOne({where : {id : member.id}})
            memeberData.paid = false
            await this.memebersRepository.save(memeberData)
        }

        await this.notifyUnpaidUsers(equbId) // notify all members to pay.


    }


    async notification(message:string, equbId){
        const members = await this.getMembersOfEqub(equbId)
        for (let member of members){

            const data =  {
                username :member.username,
                notification: message
            }
            const notification = this.notificationRepository.create(data);
            await this.notificationRepository.save(notification)
            
        }
    }


    // get notification sent for a logged in user
    async getNotification(username){
        return this.notificationRepository.findBy({username: username})
    }

}