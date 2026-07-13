const express = require('express');
const router = express.Router();

const {
  crearReservacion,
  obtenerMisReservaciones,
  obtenerTodasReservaciones,
  actualizarReservacion,
  cancelarReservacion
} = require('../controllers/reservacion.controller');

const { verificarToken, verificarRol } = require('../middlewares/auth.middleware');

router.post('/', verificarToken, verificarRol('cliente'), crearReservacion);
router.get('/mias', verificarToken, verificarRol('cliente'), obtenerMisReservaciones);
router.get('/', verificarToken, verificarRol('admin'), obtenerTodasReservaciones);
router.put('/:id', verificarToken, actualizarReservacion);
router.patch('/:id/cancelar', verificarToken, cancelarReservacion);

module.exports = router;