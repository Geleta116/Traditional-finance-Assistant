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
exports.Edir = void 0;
const edir_chatroom_entity_1 = require("./edir_chatroom.entity");
const edir_members_entity_1 = require("./edir_members.entity");
const typeorm_1 = require("typeorm");
let Edir = class Edir {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Edir.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Edir.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Edir.prototype, "amount", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], Edir.prototype, "balance", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], Edir.prototype, "active", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Edir.prototype, "creator", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: '' }),
    __metadata("design:type", String)
], Edir.prototype, "code", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Edir.prototype, "countdown", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], Edir.prototype, "duration", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], Edir.prototype, "durationControl", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => edir_members_entity_1.Edirmembers, (member) => member.id, { onDelete: 'CASCADE' }),
    __metadata("design:type", Array)
], Edir.prototype, "members", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => edir_chatroom_entity_1.Edirchatroom, (chatroom) => chatroom.id, { onDelete: 'CASCADE' }),
    __metadata("design:type", Array)
], Edir.prototype, "chatroom", void 0);
Edir = __decorate([
    (0, typeorm_1.Entity)()
], Edir);
exports.Edir = Edir;
//# sourceMappingURL=edir.entity.js.map