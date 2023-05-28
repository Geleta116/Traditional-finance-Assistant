"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var EqubService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.EqubService = void 0;
const members_entity_1 = require("../typeorm/entities/members.entity");
const typeorm_1 = require("@nestjs/typeorm");
const user_entity_1 = require("../typeorm/entities/user.entity");
const typeorm_2 = require("typeorm");
const equb_entity_1 = require("../typeorm/entities/equb.entity");
const notification_entity_1 = require("../typeorm/entities/notification.entity");
const common_1 = require("@nestjs/common");
const blackList_entity_1 = require("../typeorm/entities/blackList.entity");
const user_service_1 = require("../user/user.service");
const equb_chatroom_entity_1 = require("../typeorm/entities/equb.chatroom.entity");
const common_2 = require("@nestjs/common");
let EqubService = EqubService_1 = class EqubService {
    constructor(memebersRepository, equbRepository, userRepository, notificationRepository, blacklistRepository, equbchatroomRepository, userService) {
        this.memebersRepository = memebersRepository;
        this.equbRepository = equbRepository;
        this.userRepository = userRepository;
        this.notificationRepository = notificationRepository;
        this.blacklistRepository = blacklistRepository;
        this.equbchatroomRepository = equbchatroomRepository;
        this.userService = userService;
        this.logger = new common_1.Logger(EqubService_1.name);
    }
    generateRandomString(length) {
        let result = '';
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const charactersLength = characters.length;
        for (let i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }
    async createEqub(equb, usr) {
        if (await this.checkRedundency(usr, equb.name)) {
            throw new common_2.HttpException('You are already a member of an equb', common_1.HttpStatus.CONFLICT);
        }
        else {
            const code = await this.generateRandomString(8);
            const name = equb.name.toLowerCase();
            const newEqubData = Object.assign(Object.assign({}, equb), { name: name, creator: usr, code: code });
            const newEqub = await this.equbRepository.create(newEqubData);
            await this.equbRepository.save(newEqub);
            await this.joinEqub(equb.name, code, usr);
            return newEqub;
        }
    }
    async joinEqub(equbName, code, username) {
        if (await this.checkRedundency(username, equbName)) {
            throw new common_2.HttpException('You are already a member of an equb', common_1.HttpStatus.CONFLICT);
        }
        else {
            const equb = await this.equbRepository.findOne({ where: { code: code, name: equbName } });
            if (!equb) {
                throw new common_2.HttpException('Equb not found', common_1.HttpStatus.CONFLICT);
            }
            if (equb.active) {
                throw new common_2.HttpException('Equb is already active, It is not permissible to join active equb', common_1.HttpStatus.CONFLICT);
            }
            const isJoinedAlready = await this.memebersRepository.findOneBy({
                username: username,
                equb: equb
            });
            if (isJoinedAlready) {
                throw new common_2.HttpException('you have already joined the equb', common_1.HttpStatus.CONFLICT);
            }
            const data = {
                username: username,
                equb: equb
            };
            const member = await this.memebersRepository.create(data);
            return await this.memebersRepository.save(member);
        }
    }
    async deleteEqub(equbId) {
        const equb = await this.equbRepository.findOne({ where: { id: equbId } });
        if (!equb.active) {
            return await this.equbRepository.delete({ id: equbId });
        }
        throw new common_2.HttpException('Cannot delete an active equb', common_1.HttpStatus.CONFLICT);
    }
    async updateEqub(equbId, equbdata) {
        const equb = await this.equbRepository.findOneBy(equbId);
        if (!equb.active) {
            return await this.equbRepository.update({ id: equbId }, equbdata);
        }
        throw new common_2.HttpException('Cannot update an active equb', common_1.HttpStatus.CONFLICT);
    }
    async deleteMember(username, equbId) {
        const equb = await this.equbRepository.findOne({ where: { id: equbId } });
        if ((equb === null || equb === void 0 ? void 0 : equb.active) == false) {
            return await this.memebersRepository.delete({ equb, username });
        }
        else {
            throw new common_2.HttpException('cannot delete active equbs member', common_1.HttpStatus.CONFLICT);
        }
    }
    async getAllEqubs(username) {
        const listOfEqubs = [];
        const created_equbs = await this.equbRepository.find({ where: { creator: username } });
        for (let equb of created_equbs) {
            listOfEqubs.push({
                equb: equb,
                creator: true,
                no_members: (await this.getMembersOfEqub(equb.id)).length,
                canPay: await this.canPay(username, equb.id)
            });
        }
        const joined_equbs = await this.memebersRepository.find({
            where: { username: username },
            relations: ['equb']
        });
        for (let data of joined_equbs) {
            if (!created_equbs.includes(data.equb)) {
                listOfEqubs.push({
                    equb: data.equb,
                    creator: false,
                    no_members: (await this.getMembersOfEqub(data.equb.id)).length,
                    canPay: await this.canPay(username, data.equb.id)
                });
            }
        }
        return listOfEqubs;
    }
    async checkRedundency(username, name) {
        const allequbs = await this.getAllEqubs(username);
        let equbname = name.toLowerCase();
        for (let equb of allequbs) {
            if (equb.name == equbname) {
                return true;
            }
        }
        return false;
    }
    getDataAboutEqub(equbId) {
        return this.equbRepository.findOne({ where: { id: equbId } });
    }
    async getMembersOfEqub(equbid) {
        const memebers = await this.memebersRepository.find({
            where: { equb: equbid },
        });
        return memebers;
    }
    async getSingleMemberOfEqub(equbid, username) {
        const member = await this.memebersRepository.findOne({
            where: { equb: equbid, username: username }
        });
        return member;
    }
    async getUnwonMembers(equbId) {
        const members = await this.memebersRepository.find({
            where: { equb: equbId, won: false },
        });
        return members;
    }
    async getCurrentWinner(equbId) {
        const winner = await this.memebersRepository.findOne({
            where: { equb: equbId, won: true, currentWinner: true },
        });
        if (winner) {
            const winnersData = await this.userRepository.findOne({
                where: {
                    username: winner.username
                }
            });
            return {
                name: winnersData.fullName,
                username: winnersData.username
            };
        }
        throw new common_2.HttpException('there is no winner in this month', common_1.HttpStatus.CONFLICT);
    }
    async payEqub(username, equbId) {
        const user = await this.userRepository.findOneBy({ username });
        const equb = await this.equbRepository.findOneBy(equbId);
        if (user.balance < equb.amount) {
            throw new common_2.HttpException('insufficient balance', common_1.HttpStatus.CONFLICT);
        }
        else {
            user.balance = user.balance - equb.amount;
            await this.userRepository.save(user);
            await this.memebersRepository.update({ equb: equbId, username: username }, { paid: true });
        }
    }
    async canPay(username, equbId) {
        const underBlacklist = await this.blacklistRepository.findOne({
            where: {
                username: username,
                equb: equbId
            }
        });
        const equb = await this.memebersRepository.findOne({
            where: {
                username: username,
                equb: equbId
            }
        });
        const isPaid = equb.paid;
        if (underBlacklist || isPaid) {
            return false;
        }
        return true;
    }
    async addToBlackList(equbId) {
        const unpaidMembers = await this.memebersRepository.find({ where: { equb: equbId, paid: false } });
        const equb = await this.equbRepository.findOneBy(equbId);
        for (let member of unpaidMembers) {
            const blacklist = await this.blacklistRepository.create({
                username: member.username,
                equb: equb
            });
            await this.blacklistRepository.save(blacklist);
        }
    }
    async blackListMembers(equbid) {
        return this.blacklistRepository.find({ where: { equb: equbid } });
    }
    async determineTheWinner(equbId) {
        const equb = await this.equbRepository.findOne({ where: { id: equbId } });
        const members = await this.getMembersOfEqub(equbId);
        const previously_unwon_members = await this.memebersRepository.find({
            where: {
                equb: equbId,
                won: false
            }
        });
        let winnerIndex;
        if (previously_unwon_members.length > 1) {
            winnerIndex = Math.floor(Math.random() * (previously_unwon_members.length));
        }
        else {
            winnerIndex = 0;
        }
        const winner = previously_unwon_members[winnerIndex].username;
        let currentWinner = await this.getSingleMemberOfEqub(equbId, winner);
        currentWinner.won = true;
        await this.memebersRepository.save(currentWinner);
        const user = await this.userRepository.findOneBy({ username: winner });
        user.balance = user.balance + (equb.amount * members.length);
        await this.userRepository.save(user);
        const winnerName = (await this.userRepository.findOneBy({ username: winner })).fullName;
        await this.notification(`${winnerName} won this equb`, equbId);
        const previous_winner = await this.memebersRepository.findOne({
            where: {
                equb: equbId,
                won: true,
                currentWinner: true
            }
        });
        if (previous_winner) {
            previous_winner.currentWinner = false;
            await this.memebersRepository.save(previous_winner);
        }
        currentWinner.currentWinner = true;
        await this.memebersRepository.save(currentWinner);
        if (previously_unwon_members.length == 1) {
            await this.notification(`${equb.name} is finished , thanks for your involvement`, equbId);
            equb.active = false;
            await this.equbRepository.save(equb);
            return await this.deleteEqub(equbId);
        }
        for (let member of members) {
            const memeberData = await this.memebersRepository.findOne({ where: { id: member.id } });
            memeberData.paid = false;
            await this.memebersRepository.save(memeberData);
        }
    }
    async notification(message, equbId) {
        const members = await this.getMembersOfEqub(equbId);
        for (let member of members) {
            const notification_data = {
                username: member.username,
                notification: message
            };
            const notification = this.notificationRepository.create(notification_data);
            await this.notificationRepository.save(notification);
        }
    }
    async notifyUnpaidUsers(equbId) {
        const unpaidMembers = await this.memebersRepository.find({ where: { equb: equbId, paid: false } });
        const equb = await this.getDataAboutEqub(equbId);
        for (let member of unpaidMembers) {
            const data = {
                username: member.username,
                notification: `payment is required for ${equb.name}`
            };
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification);
        }
    }
    async getNotification(username) {
        return this.notificationRepository.findBy({ username: username });
    }
    async deleteNotification(id) {
        return await this.notificationRepository.delete(id);
    }
    async sendMessage(username, message, equbId) {
        const equb = await this.equbRepository.findOneBy({ id: equbId });
        const chat_data = {
            sentdate: Date.now(),
            username: username,
            message: message,
            equb: equb
        };
        const chat = await this.equbchatroomRepository.create(chat_data);
        return await this.equbchatroomRepository.save(chat);
    }
    async getChat(equbId) {
        return await this.equbchatroomRepository.find({
            where: { equb: equbId },
            order: { sentdate: 'DESC' },
        });
    }
    async dailyFunction() {
        const not_beginned_equbs = await this.equbRepository.find({ where: { active: false } });
        for (let equb of not_beginned_equbs) {
            const no_members = await (await this.getMembersOfEqub(equb.id)).length;
            if (equb.countdown == 0) {
                if (no_members >= equb.minMembers) {
                    equb.active = true;
                    await this.equbRepository.save(equb);
                }
                else {
                    await this.deleteEqub(equb.id);
                }
            }
            else {
                equb.countdown -= 1;
                await this.equbRepository.save(equb);
            }
        }
        const active_equbs = await this.equbRepository.find({ where: { active: true } });
        for (let equb of active_equbs) {
            const equbdata = await this.equbRepository.findOne({ where: { id: equb.id } });
            equbdata.durationControl += 1;
            await this.equbRepository.save(equbdata);
            if (equb.durationControl == equb.duration) {
                await this.determineTheWinner(equb.id);
                if (await this.equbRepository.findOneBy({ id: equb.id })) {
                    let equbData = await this.equbRepository.findOneBy({ id: equb.id });
                    equbData.durationControl = 0;
                    await this.equbRepository.save(equbData);
                }
            }
            else if (equb.durationControl < 3) {
                await this.notifyUnpaidUsers(equb.id);
            }
            else {
                await this.addToBlackList(equb.id);
            }
        }
    }
};
EqubService = EqubService_1 = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(members_entity_1.EqubMembers)),
    __param(1, (0, typeorm_1.InjectRepository)(equb_entity_1.Equb)),
    __param(2, (0, typeorm_1.InjectRepository)(user_entity_1.User)),
    __param(3, (0, typeorm_1.InjectRepository)(notification_entity_1.EqubNotification)),
    __param(4, (0, typeorm_1.InjectRepository)(blackList_entity_1.BlackList)),
    __param(5, (0, typeorm_1.InjectRepository)(equb_chatroom_entity_1.Equbchatroom)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        user_service_1.UserService])
], EqubService);
exports.EqubService = EqubService;
//# sourceMappingURL=equb.service.js.map