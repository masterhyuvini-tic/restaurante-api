const express = require('express');
const router = express.Router();

const { obtenerMesas, obtenerMesaPorId, crearMesa, actualizarMesa, eliminarMesa } = require('../controllers/mesa.controller');
const { verificarToken, verificarRol } = require('../middlewares/auth.middleware');

// Públicas
router.get('/', obtenerMesas);
router.get('/:id', obtenerMesaPorId);

// Solo admin
router.post('/', verificarToken, verificarRol('admin'), crearMesa);
router.put('/:id', verificarToken, verificarRol('admin'), actualizarMesa);
router.patch('/:id', verificarToken, verificarRol('admin'), eliminarMesa);

module.exports = router;