# Step 1: Use a lightweight Node.js image to build the React app
FROM node:18-alpine AS builder

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Step 4: Copy the rest of the app files and build the project
COPY . .
RUN npm run build

# Step 5: Use Nginx to serve the built React app
FROM nginx:alpine

# Step 6: Copy the build output from the previous step to Nginx's serving directory
COPY --from=builder /app/build /usr/share/nginx/html

# Step 7: Expose port 80 to access the app
EXPOSE 80

# Step 8: Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
