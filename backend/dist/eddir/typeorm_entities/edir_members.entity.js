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
exports.Edirmembers = void 0;
const typeorm_1 = require("typeorm");
const edir_entity_1 = require("./edir.entity");
let Edirmembers = class Edirmembers {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], Edirmembers.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], Edirmembers.prototype, "username", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: false }),
    __metadata("design:type", Boolean)
], Edirmembers.prototype, "paid", void 0);
__decorate([
    (0, typeorm_1.Column)({ default: 0 }),
    __metadata("design:type", Number)
], Edirmembers.prototype, "penality", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Date)
], Edirmembers.prototype, "date", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => edir_entity_1.Edir, (edir) => edir.members, { onDelete: 'CASCADE' }),
    __metadata("design:type", edir_entity_1.Edir)
], Edirmembers.prototype, "edir", void 0);
Edirmembers = __decorate([
    (0, typeorm_1.Entity)()
], Edirmembers);
exports.Edirmembers = Edirmembers;
//# sourceMappingURL=edir_members.entity.js.map