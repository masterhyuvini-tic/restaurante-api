const express = require('express');
const app = express();

app.use(express.json());

const authRoutes = require('./routes/auth.routes');
const mesaRoutes = require('./routes/mesa.routes');

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/mesas', mesaRoutes);

module.exports = app;