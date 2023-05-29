export class EdirDTO {
    readonly name: string;
    readonly amount : number;
    readonly duration : number; // number of days to make payment again
    readonly countdown : number;
    readonly description : string;
}