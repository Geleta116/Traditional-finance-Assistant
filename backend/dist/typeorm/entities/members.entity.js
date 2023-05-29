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
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
exports.EqubMembers = void 0;
const typeorm_1 = require("typeorm");
const equb_entity_1 = require("./equb.entity");
let EqubMembers = class EqubMembers {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], EqubMembers.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], EqubMembers.prototype, "username", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], EqubMembers.prototype, "won", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], EqubMembers.prototype, "currentWinner", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], EqubMembers.prototype, "paid", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => equb_entity_1.Equb, (equb) => equb.members, { onDelete: 'CASCADE' }),
    __metadata("design:type", typeof (_a = typeof equb_entity_1.Equb !== "undefined" && equb_entity_1.Equb) === "function" ? _a : Object)
], EqubMembers.prototype, "equb", void 0);
EqubMembers = __decorate([
    (0, typeorm_1.Entity)()
], EqubMembers);
exports.EqubMembers = EqubMembers;
//# sourceMappingURL=members.entity.js.map