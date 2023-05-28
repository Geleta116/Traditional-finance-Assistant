<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo_text.svg" width="320" alt="Nest Logo" /></a>
</p>

# Nestjs Schedule

<p align="center">
    <a href="https://www.npmjs.com/~nestjs-schedule" target="_blank"><img src="https://img.shields.io/npm/v/nestjs-schedule.svg" alt="NPM Version"/></a>
    <a href="https://www.npmjs.com/~nestjs-schedule" target="_blank"><img src="https://img.shields.io/npm/l/nestjs-schedule.svg" alt="Package License"/></a>
    <a href="https://www.npmjs.com/~nestjs-schedule" target="_blank"><img src="https://img.shields.io/npm/dm/nestjs-schedule.svg" alt="NPM Downloads"/></a>
</p>

## Description

Distributed Schedule module for [Nest.js](https://github.com/nestjs/nest) based on the node-schedule package.

## Installation

```bash
$ npm i --save nestjs-schedule
```

## Usage

```typescript
import { Module } from '@nestjs/common';
import { ScheduleModule } from 'nestjs-schedule';

@Module({
    imports: [ScheduleModule.forRoot({
        // Optional: Import external dependent modules if you need
        imports: [MyLockerModule]
        // Optional: Inject your global custom lock
        useClass: MyScheduleLocker
    })],
})
export class AppModule {}
```

```typescript
import { Injectable, Logger } from '@nestjs/common';
import { Cron, Timeout, Interval } from 'nestjs-schedule';

@Injectable()
export class TasksService {
    private readonly logger = new Logger(TasksService.name);

    @Cron('45 * * * * *')
    handleCron() {
        this.logger.debug('Called when the current second is 45');
    }

    @Interval(5000)
    handleInterval() {
        this.logger.debug('Called every 5 seconds');
    }

    @Timeout(5000)
    handleTimeout() {
        this.logger.debug('Called after 5 seconds');
    }
}
```

### Dynamic Schedule Job

```typescript
import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { InjectSchedule, Schedule } from 'nestjs-schedule';

@Injectable()
export class TasksService implements OnModuleInit {
    private readonly logger = new Logger(TasksService.name);

    constructor(@InjectSchedule() private readonly schedule: Schedule) {}

    execute() {
        this.logger.debug('execute dynamic job');
    }

    onModuleInit() {
        this.schedule.createIntervalJob(this.execute.bind(this), 3000, {
            name: 'test_job',
        });
        this.schedule.deleteIntervalJob('test_job');
    }
}
```

### Distributed Support

1. Implements Locker interface

```typescript
import { Locker } from 'nestjs-schedule';
import { Injectable } from '@nestjs/common';

@Injectable()
export class ScheduleLocker implements Locker {

    release(jobName: string): any {}

    async tryLock(jobName: string): Promise<boolean> {
        // use redis lock or other methods
        return true;
    }
}
```

2. Use your locker

```typescript
import { Injectable, Logger } from '@nestjs/common';
import { Cron, UseLocker } from '@nestjs-schedule';
import { ScheduleLocker } from './schedule-locker';

@Injectable()
export class TasksService {
    private readonly logger = new Logger(TasksService.name);

    @Cron('45 * * * * *')
    // remove it if you want to use the lock which injected forRoot
    @UseLocker(ScheduleLocker)
    handleCron() {
        this.logger.debug('Called when the current second is 45');
    }
}
```

## API

### class ScheduleModule

#### static forRoot\(\): DynamicModule

Import schedule module.

### class Schedule

#### createTimeoutJob\(methodRef: Function, timeout: number, options?: TimeoutOptions\)

Dynamic create a timeout job.

| field     | type         | required | description          |
| --------- | ------------ | -------- | -------------------- |
| methodRef | Function     | true     | job method           |
| timeout   | number       | true     | milliseconds         |
| options   |              | false    | see decorators       |
| locker    | Locker/false | false    | custom lock instance |

> If the locker is configured as false, the default lock will be ignored
#### createIntervalJob\(methodRef: Function, timeout: number, options?: IntervalOptions\)

Dynamic create a interval job.

| field     | type         | required | description          |
| --------- | ------------ | -------- | -------------------- |
| methodRef | Function     | true     | job method           |
| interval  | number       | true     | milliseconds         |
| options   |              | false    | see decorators       |
| locker    | Locker/false | false    | custom lock instance |

#### createCronJob\(rule: string | number | Date | CronObject | CronObjLiteral, methodRef, options?: CronOptions\)

Dynamic create a cron job.

| field     | type                                         | required | description          |
| --------- | -------------------------------------------- | -------- | -------------------- |
| rule      | Date string number CronObject CronObjLiteral | true     | the cron rule        |
| methodRef | Function                                     | true     | job method           |
| options   |                                              | false    | see decorators       |
| locker    | Locker/false                                 | false    | custom lock instance |

#### deleteTimeoutJob\(name: string\)

Delete a timeout job

#### deleteIntervalJob\(name: string\)

Delete a interval job

#### deleteCronJob\(name: string\)

Delete a cron job

#### getTimeoutJobs\(\): TimeoutJobOptions[]

Get all timeout jobs

#### getIntervalJobs\(\): IntervalJobOptions[]

Get all interval jobs

#### getCronJobs\(\): CronJobOptions[]

Get all cron jobs

## Decorators

### Cron(rule: string | number | Date | CronObject | CronObjLiteral, options?: CronOptions): MethodDecorator

Schedule a cron job.

| field           | type                                         | required | description                                  |
| --------------- | -------------------------------------------- | -------- | -------------------------------------------- |
| rule            | Date string number CronObject CronObjLiteral | true     | The cron rule                                |
| rule.dayOfWeek  | number                                       | true     | Timezone                                     |
| options.name    | string                                       | false    | The unique job key.**Distributed lock need it**                           |
| options.retries | number                                       | false    | the max retry count, default is -1 not retry |
| options.retry   | number                                       | false    | the retry interval, default is 5000          |

[CronObject CronObjLiteral](https://github.com/yanqic/nest-schedule/blob/main/lib/interfaces/cron-options.interface.ts)

### Interval(timeout: number): MethodDecorator

### Interval(name: string, timeout: number): MethodDecorator

### Interval(name: string, timeout: number, options?: IntervalOptions): MethodDecorator

Schedule a interval job.

| field             | type    | required | description                                  |
| ----------------- | ------- | -------- | -------------------------------------------- |
| timeout           | number  | true     | milliseconds                                 |
| options.retries   | number  | false    | the max retry count, default is -1 not retry |
| options.retry     | number  | false    | the retry interval, default is 5000          |
| options.immediate | boolean | false    | executing job immediately                    |

### Timeout(timeout: number): MethodDecorator

### Timeout(name: string, timeout: number): MethodDecorator

### Timeout(name: string, timeout: number, options?: TimeoutOptions): MethodDecorator

Schedule a timeout job.

| field             | type    | required | description                                  |
| ----------------- | ------- | -------- | -------------------------------------------- |
| timeout           | number  | true     | milliseconds                                 |
| options.retries   | number  | false    | the max retry count, default is -1 not retry |
| options.retry     | number  | false    | the retry interval, default is 5000          |
| options.immediate | boolean | false    | executing job immediately                    |

### InjectSchedule(): PropertyDecorator

Inject Schedule instance

### UseLocker(locker: Locker | Function): MethodDecorator

Set a distributed locker for job.

## Stay in touch

-   Author - [yanqic](https://github.com/yanqic)

## License

NestCloud is [MIT licensed](LICENSE).
