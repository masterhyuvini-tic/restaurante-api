const express = require('express');
const router = express.Router();

// Importamos la función 'registrar' desde el controller
const { registrar, login } = require('../controllers/auth.controller');

// Cuando llegue una petición POST a '/registrar', se ejecuta la función 'registrar'
router.post('/registrar', registrar);
router.post('/login', login);

module.exports = router;