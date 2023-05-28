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
exports.EqubAuthorize = void 0;
const common_1 = require("@nestjs/common");
const auth_service_1 = require("../auth.service");
const equb_service_1 = require("../../equb/equb.service");
let EqubAuthorize = class EqubAuthorize {
    constructor(authService, equbService) {
        this.authService = authService;
        this.equbService = equbService;
    }
    async canActivate(context) {
        const request = context.switchToHttp().getRequest();
        const response = context.switchToHttp().getResponse();
        const token = request.headers['authorization'].split(' ')[1];
        const result = await this.authService.validateToken(token);
        const username = result.username;
        const id = request.params.id;
        const equb = await this.equbService.getDataAboutEqub(id);
        if (equb.creator == username) {
            return true;
        }
        else {
            response.status(403).send('only creators are allowed to access this route');
            return false;
        }
    }
};
EqubAuthorize = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [auth_service_1.AuthService,
        equb_service_1.EqubService])
], EqubAuthorize);
exports.EqubAuthorize = EqubAuthorize;
//# sourceMappingURL=EqubAuthorise.guard.js.map