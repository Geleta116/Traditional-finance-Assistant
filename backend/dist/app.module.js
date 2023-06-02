"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const notification_entity_1 = require("./typeorm/entities/notification.entity");
const common_1 = require("@nestjs/common");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const typeorm_1 = require("@nestjs/typeorm");
const equb_entity_1 = require("./typeorm/entities/equb.entity");
const members_entity_1 = require("./typeorm/entities/members.entity");
const equb_module_1 = require("./equb/equb.module");
const auth_module_1 = require("./auth/auth.module");
const user_module_1 = require("./user/user.module");
const user_entity_1 = require("./typeorm/entities/user.entity");
const schedule_1 = require("@nestjs/schedule");
const blackList_entity_1 = require("./typeorm/entities/blackList.entity");
const edir_entity_1 = require("./eddir/typeorm_entities/edir.entity");
const edir_notification_entity_1 = require("./eddir/typeorm_entities/edir_notification.entity");
const edir_members_entity_1 = require("./eddir/typeorm_entities/edir_members.entity");
const edir_chatroom_entity_1 = require("./eddir/typeorm_entities/edir_chatroom.entity");
const equb_chatroom_entity_1 = require("./typeorm/entities/equb.chatroom.entity");
const eddir_module_1 = require("./eddir/eddir.module");
let AppModule = class AppModule {
};
AppModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forRoot({
                type: "mysql",
                host: "localhost",
                port: 3306,
                username: "root",
                password: "nahom",
                database: "mobile_backend",
                entities: [
                    user_entity_1.User,
                    equb_entity_1.Equb, members_entity_1.EqubMembers, notification_entity_1.EqubNotification, blackList_entity_1.BlackList, equb_chatroom_entity_1.Equbchatroom,
                    edir_entity_1.Edir, edir_notification_entity_1.EdirNotifications, edir_members_entity_1.Edirmembers, edir_chatroom_entity_1.Edirchatroom
                ],
                synchronize: true
            }), equb_module_1.EqubModule, auth_module_1.AuthModule, user_module_1.UserModule, schedule_1.ScheduleModule.forRoot(), eddir_module_1.EddirModule],
        controllers: [app_controller_1.AppController],
        providers: [app_service_1.AppService],
    })
], AppModule);
exports.AppModule = AppModule;
//# sourceMappingURL=app.module.js.map