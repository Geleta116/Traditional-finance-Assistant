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
exports.UserController = void 0;
const common_1 = require("@nestjs/common");
const user_service_1 = require("./user.service");
const authenticate_guard_1 = require("../auth/guards/authenticate.guard");
const auth_service_1 = require("../auth/auth.service");
const signUp_dto_1 = require("../DTO/userDTO/signUpDTO/signUp.dto");
const changepassword_dto_1 = require("../DTO/userDTO/updateDTO/changepassword.dto");
const deposition_dto_1 = require("../DTO/userDTO/depositDTO/deposition.dto");
let UserController = class UserController {
    constructor(userService, authService) {
        this.userService = userService;
        this.authService = authService;
    }
    async signUp(signupdto, response) {
        return await this.userService.signUp(signupdto);
    }
    async changePassword(changepassworddto, req) {
        const username = req.user['username'];
        return await this.userService.changePassword(username, changepassworddto.oldpassword, changepassworddto.newpassword);
    }
    getUserInfo(username) {
        return this.userService.getUserInfo(username);
    }
    async makeDeposit(depositdto, req) {
        const usernam = req.user["username"];
        return await this.userService.makeDeposit(usernam, depositdto.amount);
    }
};
__decorate([
    (0, common_1.Post)('signup/'),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Res)({ passthrough: true })),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [signUp_dto_1.SignUpDTO, Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "signUp", null);
__decorate([
    (0, common_1.Patch)('changepassowrd/'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [changepassword_dto_1.changePasswordDTO, Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "changePassword", null);
__decorate([
    (0, common_1.Get)('info/:username'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Param)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], UserController.prototype, "getUserInfo", null);
__decorate([
    (0, common_1.Post)('deposit'),
    (0, common_1.UseGuards)(authenticate_guard_1.Authenticate),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [deposition_dto_1.DepositDTO, Object]),
    __metadata("design:returntype", Promise)
], UserController.prototype, "makeDeposit", null);
UserController = __decorate([
    (0, common_1.Controller)('user'),
    __metadata("design:paramtypes", [user_service_1.UserService,
        auth_service_1.AuthService])
], UserController);
exports.UserController = UserController;
//# sourceMappingURL=user.controller.js.map