FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copiar archivos de configuración y dependencias
COPY pom.xml .
COPY src ./src

# Compilar la aplicación ignorando las pruebas para acelerar el proceso
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copiar el archivo .jar generado desde la primera etapa
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]