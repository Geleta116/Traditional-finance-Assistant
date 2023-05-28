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
exports.EddirController = void 0;
const common_1 = require("@nestjs/common");
const edir_dto_1 = require("../DTO/EdirDTO/creatEdirDTO/edir.dto");
const join_dto_1 = require("../DTO/EdirDTO/joinDTO/join.dto");
const deleteMember_dto_1 = require("../DTO/EdirDTO/deleteMember/deleteMember.dto");
const chat_dto_1 = require("../DTO/EdirDTO/chatDTO/chat.dto");
const eddir_service_1 = require("./eddir.service");
const authenticate_guard_1 = require("../auth/guards/authenticate.guard");
const EdirAuthorization_guard_1 = require("../auth/guards/EdirAuthorization.guard");
const notification_dto_1 = require("../DTO/EdirDTO/notificationDTO/notification.dto");
let EddirController = class EddirController {
    constructor(edirService) {
        this.edirService = edirService;
    }
    async createEdir(data, req) {
        console.log(data);
        console.log("hello");
        const creator = req.user['username'];
        return this.edirService.createEdir(data, creator);
    }
    async joinEdir(dto, req) {
        const username = req.user['username'];
        return this.edirService.joinEdir(dto.name, dto.code, username);
    }
    async deleteEdir(id) {
        return this.edirService.deleteEdir(id);
    }
    async leaveEdir(id, req) {
        const username = req.user['username'];
        return this.edirService.leaveEdir(id, username);
    }
    async updateEdir(id, dto) {
        return this.edirService.updateEdir(id, dto);
    }
    async deleteMember(id, dto) {
        return this.edirService.deleteMember(id, dto.username);
    }
    async getAllEdirs(req) {
        console.log("hello");
        const username = req.user["username"];
        return this.edirService.getAllEdirs(username);
    }
    async payEdir(req, id) {
        const username = req.user["username"];
        return this.edirService.payEdir(username, id);
    }
    async getMembers(id) {
        return this.edirService.getMembersOfEdir(id);
    }
    async getNotification(req) {
        const username = req.user["username"];
        return this.edirService.getNotification(username);
    }
    async notifyDeath(notificationdto, id) {
        return this.edirService.notification(notificationdto.notification, id);
    }
    async deleteNotification(id) {
        return this.edirService.deleteNotification(id);
    }
    async sendMessage(id, edirChatDTO, req) {
        const username = req.user["username"];
        return this.edirService.sendMessage(username, edirChatDTO.message, id);
    }
    async getMessage(id) {
        return this.edirService.getChat(id);
    }
};
__decorate([
    (0, common_1.Post)('create/'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [edir_dto_1.EdirDTO, Object]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "createEdir", null);
__decorate([
    (0, common_1.Post)('join/'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [join_dto_1.JoinEdirDTO, Object]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "joinEdir", null);
__decorate([
    (0, common_1.Post)('delete/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate, EdirAuthorization_guard_1.EdirAuthorize),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "deleteEdir", null);
__decorate([
    (0, common_1.Post)('leave/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "leaveEdir", null);
__decorate([
    (0, common_1.Post)('update/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate, EdirAuthorization_guard_1.EdirAuthorize),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, edir_dto_1.EdirDTO]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "updateEdir", null);
__decorate([
    (0, common_1.Delete)("deletemember/:id"),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate, EdirAuthorization_guard_1.EdirAuthorize),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, deleteMember_dto_1.DeleteEdirMemberDTO]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "deleteMember", null);
__decorate([
    (0, common_1.Get)('all'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "getAllEdirs", null);
__decorate([
    (0, common_1.Post)('pay/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Number]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "payEdir", null);
__decorate([
    (0, common_1.Get)('members/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "getMembers", null);
__decorate([
    (0, common_1.Get)('notification'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "getNotification", null);
__decorate([
    (0, common_1.Post)('notify/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [notification_dto_1.EdirNotificationDTO, Number]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "notifyDeath", null);
__decorate([
    (0, common_1.Delete)('notification/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "deleteNotification", null);
__decorate([
    (0, common_1.Post)('sendmessage/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, chat_dto_1.EdirChatDTO, Object]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "sendMessage", null);
__decorate([
    (0, common_1.Get)('getmessage/:'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EddirController.prototype, "getMessage", null);
EddirController = __decorate([
    (0, common_1.Controller)('edir'),
    __metadata("design:paramtypes", [eddir_service_1.EddirService])
], EddirController);
exports.EddirController = EddirController;
//# sourceMappingURL=eddir.controller.js.map