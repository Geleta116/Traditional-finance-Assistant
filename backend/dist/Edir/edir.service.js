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
Object.defineProperty(exports, "__esModule", { value: true });
exports.EdirService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const edir_entity_1 = require("./typeorm_entities/edir.entity");
const edir_members_entity_1 = require("./typeorm_entities/edir_members.entity");
const edir_notification_entity_1 = require("./typeorm_entities/edir_notification.entity");
const nestjs_schedule_1 = require("nestjs-schedule");
const user_entity_1 = require("../typeorm/entities/user.entity");
const edir_chatroom_entity_1 = require("./typeorm_entities/edir_chatroom.entity");
let EdirService = class EdirService {
    constructor(edirRepository, edirMembersRepository, userRepository, notificationRepository, edirchatroomRepository) {
        this.edirRepository = edirRepository;
        this.edirMembersRepository = edirMembersRepository;
        this.userRepository = userRepository;
        this.notificationRepository = notificationRepository;
        this.edirchatroomRepository = edirchatroomRepository;
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
    async createEdir(edirdata, creator) {
        const code = await this.generateRandomString(8);
        const name = edirdata.name.toLowerCase();
        const newEdirData = Object.assign(Object.assign({}, edirdata), { name: name, creator: creator, code: code });
        const edir = await this.edirRepository.create(newEdirData);
        try {
            await this.edirRepository.save(edir);
        }
        catch (err) {
            console.log(err);
        }
        await this.joinEdir(name, code, creator);
        return edir;
    }
    async joinEdir(edirName, code, username) {
        const edir = await this.edirRepository.findOne({ where: { code: code, name: edirName } });
        if (!edir) {
            throw new Error('Equb not found');
        }
        const data = {
            username: username,
            edir: edir
        };
        const member = await this.edirMembersRepository.create(data);
        return await this.edirMembersRepository.save(member);
    }
    async deleteEdir(edirId) {
        const edir = await this.edirRepository.findOne({ where: { id: edirId } });
        if (edir) {
            return await this.edirRepository.delete({ id: edirId });
        }
        throw new Error("Edir doesn't exist");
    }
    async updateEdir(edirId, edirdata) {
        const edir = await this.edirRepository.findOneBy(edirId);
        if (edir) {
            return await this.edirRepository.update({ id: edirId }, edirdata);
        }
        throw new Error("Edir doesn't exist");
    }
    async deleteMember(username, edirId) {
        const edir = await this.edirRepository.findOne({ where: { id: edirId } });
        if (edir) {
            return await this.edirMembersRepository.delete({ edir, username });
        }
        else {
            return "Edir doesn't exist";
        }
    }
    async getAllEdirs(username) {
        const listOfEdirs = [];
        const created_edirs = await this.edirRepository.find({ where: { creator: username } });
        for (let edir of created_edirs) {
            listOfEdirs.push({ edir: edir, creator: true, no_members: (await this.getMembersOfEdir(edir.id)).length });
        }
        const joined_edirs = await this.edirMembersRepository.find({
            where: { username: username },
            relations: ['edir']
        });
        for (let data of joined_edirs) {
            if (!created_edirs.includes(data.edir)) {
                listOfEdirs.push({ edir: data.edir, creator: false, no_members: (await this.getMembersOfEdir(data.edir.id)).length });
            }
        }
        return listOfEdirs;
    }
    async getDataAboutEdir(edirId) {
        return await this.edirRepository.findOne({ where: { id: edirId } });
    }
    async getMembersOfEdir(edirId) {
        const members = await this.edirMembersRepository.find({
            where: { edir: edirId },
        });
        return members;
    }
    async getSingleMemberOfEdir(edirId, username) {
        const member = await this.edirMembersRepository.findOne({
            where: { edir: edirId, username: username }
        });
        return member;
    }
    async payEdir(username, edirId) {
        const user = await this.userRepository.findOneBy({ username });
        const edir = await this.edirRepository.findOne({ where: { id: edirId } });
        const penality = await (await this.getSingleMemberOfEdir(edirId, username)).penality;
        const payment_money = user.balance - edir.amount - penality;
        user.balance -= payment_money;
        edir.balance += payment_money;
        await this.userRepository.save(user);
        await this.edirRepository.save(edir);
        await this.edirMembersRepository.update({ edir: edirId, username: username }, { paid: true });
    }
    async notification(message, edirId) {
        const members = await this.getMembersOfEdir(edirId);
        for (let member of members) {
            const notification_data = {
                username: member.username,
                notification: message
            };
            const notification = this.notificationRepository.create(notification_data);
            await this.notificationRepository.save(notification);
        }
    }
    async notifyUnpaidUsers(edirId) {
        const unpaidMembers = await this.edirMembersRepository.find({ where: { edir: edirId, paid: false } });
        const edir = await this.getDataAboutEdir(edirId);
        for (let member of unpaidMembers) {
            const data = {
                username: member.username,
                notification: `payment is for ${edir.name} is required required`
            };
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification);
        }
    }
    async getNotification(username) {
        return this.notificationRepository.findBy({ username: username });
    }
    async deleteNotification(id) {
        return this.notificationRepository.delete({ id: id });
    }
    async getPenalizedUsers(edirId) {
        const unpaidMembers = await this.edirMembersRepository.find({ where: { edir: edirId, paid: false } });
        const edir = await this.edirRepository.findOneBy({ id: edirId });
        for (let member of unpaidMembers) {
            member.penality += (edir.amount * 0.1);
            await this.edirMembersRepository.save(member);
            const data = {
                username: member.username,
                notification: `You are penalized , for not paying ${edir.name}`
            };
            const notification = await this.notificationRepository.create(data);
            await this.notificationRepository.save(notification);
        }
    }
    async sendMessage(username, message, edirId) {
        const edir = await this.edirRepository.findOneBy({ id: edirId });
        const chat_data = {
            sentdate: Date.now(),
            username: username,
            message: message,
            edir: edir
        };
        const chat = await this.edirchatroomRepository.create(chat_data);
        return await this.edirchatroomRepository.save(chat);
    }
    async getChat(edirId) {
        return await this.edirchatroomRepository.find({
            where: { edir: edirId },
            order: { sentdate: 'DESC' },
        });
    }
    async dailyFunction() {
        const not_acive_edirs = await this.edirRepository.find({ where: { active: false } });
        for (let edir of not_acive_edirs) {
            const no_members = (await this.getMembersOfEdir(edir.id)).length;
            if (edir.countdown == 0) {
                if (no_members >= 5) {
                    edir.active = true;
                    await this.edirRepository.save(edir);
                }
                else {
                    await this.deleteEdir(edir.id);
                }
            }
            else {
                edir.countdown -= 1;
                await this.edirRepository.save(edir);
            }
        }
        const active_edir = await this.edirRepository.find({ where: { active: true } });
        for (let edir of active_edir) {
            const edirdata = await this.edirRepository.findOne({ where: { id: edir.id } });
            edirdata.durationControl += 1;
            await this.edirRepository.save(edirdata);
            if (edirdata.durationControl == edirdata.duration) {
                edirdata.durationControl = 0;
                await this.edirRepository.save(edirdata);
            }
            else if (edirdata.durationControl < 3) {
                await this.notifyUnpaidUsers(edirdata.id);
            }
            else if (edirdata.durationControl < 3) {
                await this.getPenalizedUsers(edirdata.id);
            }
        }
    }
};
__decorate([
    (0, nestjs_schedule_1.Cron)('* * * * * *'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], EdirService.prototype, "dailyFunction", null);
EdirService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(edir_entity_1.Edir)),
    __param(1, (0, typeorm_1.InjectRepository)(edir_members_entity_1.Edirmembers)),
    __param(2, (0, typeorm_1.InjectRepository)(user_entity_1.User)),
    __param(3, (0, typeorm_1.InjectRepository)(edir_notification_entity_1.EdirNotifications)),
    __param(4, (0, typeorm_1.InjectRepository)(edir_chatroom_entity_1.Edirchatroom)),
    __metadata("design:paramtypes", [typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository,
        typeorm_2.Repository])
], EdirService);
exports.EdirService = EdirService;
//# sourceMappingURL=edir.service.js.map