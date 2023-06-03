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
exports.EdirAuthorize = void 0;
const common_1 = require("@nestjs/common");
const auth_service_1 = require("../auth.service");
const eddir_service_1 = require("../../eddir/eddir.service");
let EdirAuthorize = class EdirAuthorize {
    constructor(authService, edirService) {
        this.authService = authService;
        this.edirService = edirService;
    }
    async canActivate(context) {
        const request = context.switchToHttp().getRequest();
        const response = context.switchToHttp().getResponse();
        const token = request.headers['authorization'].split(' ')[1];
        const result = await this.authService.validateToken(token);
        const username = result.username;
        const id = request.params.id;
        const edirName = request.params['edirName'];
        const edir = await this.edirService.getDataAboutEdir(edirName);
        if (edir.creator == username) {
            return true;
        }
        else {
            response.status(403).send('only creators are allowed to access this route');
            return false;
        }
    }
};
EdirAuthorize = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [auth_service_1.AuthService,
        eddir_service_1.EddirService])
], EdirAuthorize);
exports.EdirAuthorize = EdirAuthorize;
//# sourceMappingURL=EdirAuthorization.guard.js.map