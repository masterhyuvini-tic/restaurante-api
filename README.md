# restaurante-api

API REST para sistema de reservas de restaurante — KODIGO TDDT2, Módulo 6.

## Stack tecnológico

- Node.js + Express
- PostgreSQL
- Prisma ORM v6
- JWT (autenticación)
- bcrypt (hash de contraseñas)

## API en producción

🔗 **URL base:** `https://restaurante-api-production-da44.up.railway.app`

## Instalación local

1. Clonar el repositorio:
```bash
git clone https://github.com/masterhyuvini-tic/restaurante-api.git
cd restaurante-api
```

2. Instalar dependencias:
```bash
npm install
```

3. Copiar el archivo de variables de entorno y completarlo con tus propios valores:
```bash
cp .env.example .env
```

4. Crear la base de datos PostgreSQL local y cargar el schema con seed:
```bash
psql -U postgres -d restaurante_db -f database/schema.sql
```

5. Generar el cliente de Prisma:
```bash
npx prisma generate
```

6. Levantar el servidor:
```bash
npm run dev
```

El servidor corre por defecto en `http://localhost:3000`.

## Variables de entorno (`.env`)

| Variable | Descripción |
|---|---|
| `PORT` | Puerto del servidor |
| `DATABASE_URL` | Cadena de conexión a PostgreSQL |
| `JWT_SECRET` | Clave secreta para firmar tokens JWT |
| `JWT_EXPIRES_IN` | Tiempo de expiración del token (ej. `8h`) |

## Endpoints principales

### Autenticación
| Método | Ruta | Descripción | Acceso |
|---|---|---|---|
| POST | `/api/v1/auth/registrar` | Registra un nuevo usuario (rol `cliente`) | Público |
| POST | `/api/v1/auth/login` | Inicia sesión y devuelve un JWT | Público |

### Mesas
| Método | Ruta | Descripción | Acceso |
|---|---|---|---|
| GET | `/api/v1/mesas` | Lista todas las mesas | Público |
| GET | `/api/v1/mesas/:id` | Obtiene una mesa por ID | Público |
| POST | `/api/v1/mesas` | Crea una nueva mesa | Admin |
| PUT | `/api/v1/mesas/:id` | Actualiza una mesa | Admin |
| PATCH | `/api/v1/mesas/:id` | Soft delete (marca `disponible=false`) | Admin |

### Reservaciones
| Método | Ruta | Descripción | Acceso |
|---|---|---|---|
| POST | `/api/v1/reservaciones` | Crea una reservación | Cliente |
| GET | `/api/v1/reservaciones` | Lista todas las reservaciones | Admin |
| GET | `/api/v1/reservaciones/mias` | Lista las reservaciones propias | Cliente |
| PUT | `/api/v1/reservaciones/:id` | Actualiza una reservación | Cliente/Admin |
| PATCH | `/api/v1/reservaciones/:id` | Cambia el estado de una reservación | Cliente/Admin |

## Autor

Yuvini Pablo — KODIGO TDDT2, Módulo 6 — Instructora: Kenia Paiz