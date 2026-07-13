const { PrismaClient } = require('../generated/prisma');
const prisma = new PrismaClient();

const crearReservacion = async (req, res) => {
  try {
    const { fecha, hora, personas, mesa_id } = req.body;
    const usuario_id = req.usuario.id;

    const nuevaReservacion = await prisma.reservaciones.create({
      data: {
        fecha: new Date(fecha),
        hora: new Date(`1970-01-01T${hora}`),
        personas,
        mesa_id,
        usuario_id
      }
    });
    res.status(201).json(nuevaReservacion);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const obtenerMisReservaciones = async (req, res) => {
  try {
    const usuario_id = req.usuario.id;
    const reservaciones = await prisma.reservaciones.findMany({
      where: { usuario_id }
    });
    res.status(200).json(reservaciones);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const obtenerTodasReservaciones = async (req, res) => {
  try {
    const reservaciones = await prisma.reservaciones.findMany();
    res.status(200).json(reservaciones);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const actualizarReservacion = async (req, res) => {
  try {
    const { id } = req.params;
    const { fecha, hora, personas, estado } = req.body;

    const reservacion = await prisma.reservaciones.findUnique({ where: { id: parseInt(id) } });
    if (!reservacion) return res.status(404).json({ error: 'Reservación no encontrada' });

    if (req.usuario.rol === 'cliente' && reservacion.usuario_id !== req.usuario.id) {
      return res.status(403).json({ error: 'No puedes editar esta reservación' });
    }

    const data = {};
    if (fecha) data.fecha = new Date(fecha);
    if (hora) data.hora = new Date(`1970-01-01T${hora}`);
    if (personas) data.personas = personas;
    if (estado) data.estado = estado;

    const reservacionActualizada = await prisma.reservaciones.update({
      where: { id: parseInt(id) },
      data
    });
    res.status(200).json(reservacionActualizada);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const cancelarReservacion = async (req, res) => {
  try {
    const { id } = req.params;
    const reservacion = await prisma.reservaciones.findUnique({ where: { id: parseInt(id) } });
    if (!reservacion) return res.status(404).json({ error: 'Reservación no encontrada' });

    if (req.usuario.rol === 'cliente' && reservacion.usuario_id !== req.usuario.id) {
      return res.status(403).json({ error: 'No puedes cancelar esta reservación' });
    }

    const cancelada = await prisma.reservaciones.update({
      where: { id: parseInt(id) },
      data: { estado: 'cancelada' }
    });
    res.status(200).json({ mensaje: 'Reservación cancelada', reservacion: cancelada });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  crearReservacion,
  obtenerMisReservaciones,
  obtenerTodasReservaciones,
  actualizarReservacion,
  cancelarReservacion
};