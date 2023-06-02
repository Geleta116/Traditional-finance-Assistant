"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.EqubModule = void 0;
const common_1 = require("@nestjs/common");
const equb_service_1 = require("./equb.service");
const equb_controller_1 = require("./equb.controller");
const typeorm_1 = require("@nestjs/typeorm");
const members_entity_1 = require("../typeorm/entities/members.entity");
const equb_entity_1 = require("../typeorm/entities/equb.entity");
const user_entity_1 = require("../typeorm/entities/user.entity");
const notification_entity_1 = require("../typeorm/entities/notification.entity");
const blackList_entity_1 = require("../typeorm/entities/blackList.entity");
const user_module_1 = require("../user/user.module");
const auth_module_1 = require("../auth/auth.module");
const equb_chatroom_entity_1 = require("../typeorm/entities/equb.chatroom.entity");
let EqubModule = class EqubModule {
};
EqubModule = __decorate([
    (0, common_1.Module)({
        providers: [equb_service_1.EqubService],
        controllers: [equb_controller_1.EqubController],
        imports: [typeorm_1.TypeOrmModule.forFeature([equb_entity_1.Equb, members_entity_1.EqubMembers, user_entity_1.User, notification_entity_1.EqubNotification, blackList_entity_1.BlackList, equb_chatroom_entity_1.Equbchatroom]), user_module_1.UserModule, auth_module_1.AuthModule]
    })
], EqubModule);
exports.EqubModule = EqubModule;
//# sourceMappingURL=equb.module.js.map