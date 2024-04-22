ARG TAG=20.11.1-alpine

###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:$TAG As development

# Create app directory
WORKDIR /app

# Create a non-root user with an explicit UID and add permission to access the /app folder
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nestjs
RUN chown -R nestjs:nodejs /app
RUN chmod 755 /app

# Copy application dependency manifests to the container image.
# Copying this first prevents re-running yarn install on every code change.
COPY --chown=nestjs:nodejs package.json package-lock.json ./
# COPY --chown=nestjs:nodejs package.json yarn.lock ./

RUN npm install --frozen-lockfile
# RUN yarn install --frozen-lockfile

# Bundle app source
COPY --chown=nestjs:nodejs . .

USER nestjs

###################
# BUILD FOR PRODUCTION
###################

FROM node:$TAG As build

WORKDIR /app

# Create a non-root user with an explicit UID and add permission to access the /app folder
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nestjs
RUN chown -R nestjs:nodejs /app
RUN chmod 755 /app

COPY --chown=nestjs:nodejs package.json package-lock.json ./
# COPY --chown=nestjs:nodejs package.json yarn.lock ./

# In order to run `yarn run build` we need access to the Nest CLI which is a dev dependency. 
#In the previous development stage we ran `yarn` which installed all dependencies, so we can copy over the node_modules directory from the development image
COPY --chown=nestjs:nodejs --from=development /app/node_modules ./node_modules

COPY --chown=nestjs:nodejs . .

# Run the build command which creates the production bundle
RUN npm run build
# RUN yarn build

# Set NODE_ENV environment variable
ENV NODE_ENV production

# Running `yarn` removes the existing node_modules directory and passing in --production ensures that only the production dependencies are installed. This ensures that the node_modules directory is as optimized as possible
RUN npm ci --ignore-scripts
# RUN yarn install --production

USER nestjs

###################
# PRODUCTION
###################

FROM node:$TAG As production

# Create a non-root user with an explicit UID and add permission to access the /app folder
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nestjs

# Copy the bundled code from the build stage to the production image
COPY --chown=nestjs:nodejs --from=build /app/node_modules ./node_modules
COPY --chown=nestjs:nodejs --from=build /app/dist ./dist

EXPOSE 3000

# Start the server using the production build
CMD [ "node", "dist/main.js" ]
