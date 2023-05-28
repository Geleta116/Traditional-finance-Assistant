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
exports.EqubController = void 0;
const common_1 = require("@nestjs/common");
const equb_service_1 = require("./equb.service");
const authenticate_guard_1 = require("../auth/guards/authenticate.guard");
const authorise_guard_1 = require("../auth/guards/authorise.guard");
const equb_dto_1 = require("../DTO/Equb_DTO/createEqubDTO/equb.dto");
const enrollDTO_dto_1 = require("../DTO/Equb_DTO/enrollDTO/enrollDTO.dto");
const deleteDTO_dto_1 = require("../DTO/Equb_DTO/deleteMemberDTO/deleteDTO.dto");
const chatdto_dto_1 = require("../DTO/Equb_DTO/chatDTO/chatdto.dto");
let EqubController = class EqubController {
    constructor(equbService) {
        this.equbService = equbService;
    }
    createEqub(equbdto, req) {
        const usr = req.user['username'];
        return this.equbService.createEqub(equbdto, usr);
    }
    joinEqub(enrolldto, req) {
        const usr = req.user['username'];
        const equbName = enrolldto.name.toLowerCase();
        const code = enrolldto.code.toUpperCase();
        return this.equbService.joinEqub(equbName, code, usr);
    }
    getAllEnrolledEqubs(req) {
        const usr = req.user['username'];
        return this.equbService.getAllEqubs(usr);
    }
    getMembersOfEqub(id) {
        return this.equbService.getMembersOfEqub(id);
    }
    getCurrentwinner(id) {
        return this.equbService.getCurrentWinner(id);
    }
    makePayment(id, req) {
        const usr = req.user['username'];
        return this.equbService.payEqub(usr, id);
    }
    getNotification(req) {
        const usr = req.user['username'];
        return this.equbService.getNotification(usr);
    }
    deleteNotification(id) {
        return this.equbService.deleteNotification(id);
    }
    getMembersInBlackList(id, req) {
        return this.equbService.blackListMembers(id);
    }
    updateEqub(id, equbdto, req) {
        return this.equbService.updateEqub(id, equbdto);
    }
    deleteMember(deletedto) {
        return this.equbService.deleteMember(deletedto.username, deletedto.equbId);
    }
    async sendMessage(id, equbChatDTO, req) {
        const username = req.user["username"];
        return this.equbService.sendMessage(username, equbChatDTO.message, id);
    }
    async getMessage(id) {
        return this.equbService.getChat(id);
    }
};
__decorate([
    (0, common_1.Post)('create/'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [equb_dto_1.EqubDTO, Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "createEqub", null);
__decorate([
    (0, common_1.Post)('join/'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [enrollDTO_dto_1.EnrollDTO, Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "joinEqub", null);
__decorate([
    (0, common_1.Get)('all/'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "getAllEnrolledEqubs", null);
__decorate([
    (0, common_1.Get)('members/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "getMembersOfEqub", null);
__decorate([
    (0, common_1.Get)('currentwinner/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "getCurrentwinner", null);
__decorate([
    (0, common_1.Get)('pay/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "makePayment", null);
__decorate([
    (0, common_1.Get)('notification'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "getNotification", null);
__decorate([
    (0, common_1.Delete)('deleteNotification/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "deleteNotification", null);
__decorate([
    (0, common_1.Get)('blacklist/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate, authorise_guard_1.Authorize),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "getMembersInBlackList", null);
__decorate([
    (0, common_1.Patch)('update/:id'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate, authorise_guard_1.Authorize),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, equb_dto_1.EqubDTO, Object]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "updateEqub", null);
__decorate([
    (0, common_1.Delete)('deleteMember'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate, authorise_guard_1.Authorize),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [deleteDTO_dto_1.DeleteDTO]),
    __metadata("design:returntype", void 0)
], EqubController.prototype, "deleteMember", null);
__decorate([
    (0, common_1.Post)('sendmessage/:id'),
    __param(0, (0, common_1.Param)()),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, chatdto_dto_1.EqubChatDTO, Object]),
    __metadata("design:returntype", Promise)
], EqubController.prototype, "sendMessage", null);
__decorate([
    (0, common_1.Get)('getmessage/:'),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", Promise)
], EqubController.prototype, "getMessage", null);
EqubController = __decorate([
    (0, common_1.Controller)('equb'),
    __metadata("design:paramtypes", [equb_service_1.EqubService])
], EqubController);
exports.EqubController = EqubController;
//# sourceMappingURL=equb.controller.js.map