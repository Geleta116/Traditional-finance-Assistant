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
Object.defineProperty(exports, "__esModule", { value: true });
exports.Equb = void 0;
const typeorm_1 = require("typeorm");
const members_entity_1 = require("./members.entity");
const equb_chatroom_entity_1 = require("./equb.chatroom.entity");
const blackList_entity_1 = require("./blackList.entity");
let Equb = class Equb {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Equb.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Equb.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Equb.prototype, "amount", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Equb.prototype, "creator", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: '' }),
    __metadata("design:type", String)
], Equb.prototype, "code", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Equb.prototype, "duration", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Equb.prototype, "countdown", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 5 }),
    __metadata("design:type", Number)
], Equb.prototype, "minMembers", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Equb.prototype, "description", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], Equb.prototype, "durationControl", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], Equb.prototype, "active", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => blackList_entity_1.BlackList, (member) => member.id, { onDelete: 'CASCADE' }),
    __metadata("design:type", Array)
], Equb.prototype, "blacklists", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => members_entity_1.EqubMembers, (member) => member.id, { onDelete: 'CASCADE' }),
    __metadata("design:type", Array)
], Equb.prototype, "members", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => equb_chatroom_entity_1.Equbchatroom, (chatroom) => chatroom.id, { onDelete: 'CASCADE' }),
    __metadata("design:type", Array)
], Equb.prototype, "chatroom", void 0);
Equb = __decorate([
    (0, typeorm_1.Entity)()
], Equb);
exports.Equb = Equb;
//# sourceMappingURL=equb.entity.js.map