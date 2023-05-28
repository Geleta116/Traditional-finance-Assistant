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
exports.UserService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const user_entity_1 = require("../typeorm/entities/user.entity");
const typeorm_2 = require("typeorm");
const bcrypt = require("bcrypt");
let UserService = class UserService {
    constructor(userRepository) {
        this.userRepository = userRepository;
    }
    async signUp(userdata) {
        const prevousUser = await this.userRepository.findOneBy({ username: userdata.username });
        if (prevousUser) {
            throw new common_1.HttpException('User already exists', common_1.HttpStatus.BAD_REQUEST);
        }
        else {
            const saltRounds = 10;
            const salt = await bcrypt.genSalt(saltRounds);
            const hashedPassword = await bcrypt.hash(userdata.password, salt);
            const newuserdata = Object.assign(Object.assign({}, userdata), { password: hashedPassword });
            const newUser = this.userRepository.create(newuserdata);
            await this.userRepository.save(newUser);
            return newUser;
        }
    }
    async getUserInfo(username) {
        return await this.userRepository.findOneBy({ username: username });
    }
    async changePassword(username, oldpassword, newpassword) {
        const user = await this.getUserInfo(username);
        if (!(await bcrypt.compare(oldpassword, user.password))) {
            throw new common_1.HttpException('Wrong password', common_1.HttpStatus.BAD_REQUEST);
        }
        else {
            const saltRounds = 10;
            const salt = await bcrypt.genSalt(saltRounds);
            const hashedPassword = await bcrypt.hash(newpassword, salt);
            user.password = hashedPassword;
            await this.userRepository.save(user);
            return user;
        }
    }
    async makeDeposit(username, amount) {
        const user = await this.getUserInfo(username);
        user.balance += amount;
        await this.userRepository.save(user);
        return user;
    }
};
UserService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(user_entity_1.User)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], UserService);
exports.UserService = UserService;
//# sourceMappingURL=user.service.js.map