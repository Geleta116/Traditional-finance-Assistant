"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.EddirModule = void 0;
const common_1 = require("@nestjs/common");
const eddir_controller_1 = require("./eddir.controller");
const eddir_service_1 = require("./eddir.service");
const typeorm_1 = require("@nestjs/typeorm");
const user_module_1 = require("../User/user.module");
const user_entity_1 = require("../typeorm/entities/user.entity");
const auth_module_1 = require("../auth/auth.module");
const edir_entity_1 = require("./typeorm_entities/edir.entity");
const edir_members_entity_1 = require("./typeorm_entities/edir_members.entity");
const edir_notification_entity_1 = require("./typeorm_entities/edir_notification.entity");
const edir_chatroom_entity_1 = require("./typeorm_entities/edir_chatroom.entity");
let EddirModule = class EddirModule {
};
EddirModule = __decorate([
    (0, common_1.Module)({
        controllers: [eddir_controller_1.EddirController],
        providers: [eddir_service_1.EddirService],
        imports: [typeorm_1.TypeOrmModule.forFeature([edir_entity_1.Edir, edir_members_entity_1.Edirmembers, user_entity_1.User, edir_notification_entity_1.EdirNotifications, edir_chatroom_entity_1.Edirchatroom]), user_module_1.UserModule, auth_module_1.AuthModule]
    })
], EddirModule);
exports.EddirModule = EddirModule;
//# sourceMappingURL=eddir.module.js.map