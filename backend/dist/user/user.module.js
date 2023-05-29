"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserModule = void 0;
const common_1 = require("@nestjs/common");
const user_service_1 = require("./user.service");
const user_controller_1 = require("./user.controller");
const jwt_1 = require("@nestjs/jwt");
const typeorm_1 = require("@nestjs/typeorm");
const equb_entity_1 = require("../typeorm/entities/equb.entity");
const members_entity_1 = require("../typeorm/entities/members.entity");
const user_entity_1 = require("../typeorm/entities/user.entity");
const blackList_entity_1 = require("../typeorm/entities/blackList.entity");
const auth_module_1 = require("../auth/auth.module");
const edir_entity_1 = require("../eddir/typeorm_entities/edir.entity");
const edir_members_entity_1 = require("../eddir/typeorm_entities/edir_members.entity");
let UserModule = class UserModule {
};
UserModule = __decorate([
    (0, common_1.Module)({
        providers: [user_service_1.UserService],
        exports: [user_service_1.UserService],
        controllers: [user_controller_1.UserController],
        imports: [auth_module_1.AuthModule, jwt_1.JwtModule, typeorm_1.TypeOrmModule.forFeature([equb_entity_1.Equb, members_entity_1.EqubMembers, user_entity_1.User, blackList_entity_1.BlackList, edir_entity_1.Edir, edir_members_entity_1.Edirmembers])]
    })
], UserModule);
exports.UserModule = UserModule;
//# sourceMappingURL=user.module.js.map