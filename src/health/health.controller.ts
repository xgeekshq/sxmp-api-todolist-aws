import { Controller, Get } from '@nestjs/common';
import {
  HealthCheckService,
  HealthCheck,
  // DiskHealthIndicator,
} from '@nestjs/terminus';

@Controller('health')
export class HealthController {
  // private readonly disk: DiskHealthIndicator,
  constructor(private health: HealthCheckService) {}

  @Get()
  @HealthCheck()
  check() {
    return this.health.check([]);
  }
}
