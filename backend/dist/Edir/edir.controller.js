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
exports.EdirController = void 0;
const common_1 = require("@nestjs/common");
const edir_service_1 = require("./edir.service");
const edir_dto_1 = require("../DTO/EdirDTO/creatEdirDTO/edir.dto");
const join_dto_1 = require("../DTO/EdirDTO/joinDTO/join.dto");
const deleteMember_dto_1 = require("../DTO/EdirDTO/deleteMember/deleteMember.dto");
const chat_dto_1 = require("../DTO/EdirDTO/chatDTO/chat.dto");
let EdirController = class EdirController {
    constructor(edirService) {
        this.edirService = edirService;
    }
    async createEdir(data, req) {
        const creator = req.user['username'];
        return this.edirService.createEdir(data, creator);
    }
    async joinEdir(dto, req) {
        const username = req.user['username'];
        return this.edirService.joinEdir(dto.name, dto.code, username);
    }
    async DeleteEdir(id) {
        return this.edirService.deleteEdir(id);
    }
    async updateEdir(id, dto) {
        return this.edirService.updateEdir(id, dto);
    }
    async deleteMember(id, dto) {
        return this.edirService.deleteMember(id, dto.username);
    }
    async getAllEdirs(req) {
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
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [edir_dto_1.EdirDTO, Object]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "createEdir", null);
__decorate([
    (0, common_1.Post)('join/'),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [join_dto_1.JoinEdirDTO, Object]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "joinEdir", null);
__decorate([
    (0, common_1.Post)('deleteedir/:id'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "DeleteEdir", null);
__decorate([
    (0, common_1.Post)('update/:id'),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, edir_dto_1.EdirDTO]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "updateEdir", null);
__decorate([
    (0, common_1.Delete)("deletemember/:id"),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, deleteMember_dto_1.DeleteEdirMemberDTO]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "deleteMember", null);
__decorate([
    (0, common_1.Get)('alledirs'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "getAllEdirs", null);
__decorate([
    (0, common_1.Post)('payedir/:id'),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Number]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "payEdir", null);
__decorate([
    (0, common_1.Get)('members/:id'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "getMembers", null);
__decorate([
    (0, common_1.Get)('notification'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "getNotification", null);
__decorate([
    (0, common_1.Delete)('notification/:id'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "deleteNotification", null);
__decorate([
    (0, common_1.Post)('sendmessage/:id'),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, chat_dto_1.EdirChatDTO, Object]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "sendMessage", null);
__decorate([
    (0, common_1.Get)('getmessage/:'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EdirController.prototype, "getMessage", null);
EdirController = __decorate([
    (0, common_1.Controller)('edir'),
    __metadata("design:paramtypes", [edir_service_1.EdirService])
], EdirController);
exports.EdirController = EdirController;
//# sourceMappingURL=edir.controller.js.map