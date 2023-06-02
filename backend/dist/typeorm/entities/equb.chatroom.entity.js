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
exports.Equbchatroom = void 0;
const typeorm_1 = require("typeorm");
const equb_entity_1 = require("./equb.entity");
let Equbchatroom = class Equbchatroom {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Equbchatroom.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Equbchatroom.prototype, "username", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], Equbchatroom.prototype, "sentdate", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => equb_entity_1.Equb, (equb) => equb.chatroom, { onDelete: 'CASCADE' }),
    __metadata("design:type", equb_entity_1.Equb)
], Equbchatroom.prototype, "equb", void 0);
Equbchatroom = __decorate([
    (0, typeorm_1.Entity)()
], Equbchatroom);
exports.Equbchatroom = Equbchatroom;
//# sourceMappingURL=equb.chatroom.entity.js.map