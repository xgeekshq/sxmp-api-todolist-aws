import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { writeFileSync } from 'fs';
import { AppModule } from './app.module';
import { stringify } from 'yaml';
import helmet from 'helmet';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // ATENTION: Helmet and Cors MUST came before any app.use(...)
  app.use(helmet());
  app.enableCors();

  // app.setGlobalPrefix('api');
  // app.enableVersioning({
  //   type: VersioningType.URI,
  //   defaultVersion: '1',
  // });

  app.useGlobalPipes(
    new ValidationPipe({
        transform: true,
        whitelist: true,
    }),
  );

  const config = new DocumentBuilder()
    .setTitle(`IDP Demo API - aws`)
    .setDescription('Multicloud api deployment demo')
    .setVersion('1.0')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);

  writeFileSync('./openapi-spec.yaml', stringify(document));

  SwaggerModule.setup('api', app, document);

  await app.listen(3000);
}
bootstrap();
