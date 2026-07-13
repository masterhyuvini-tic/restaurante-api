const { PrismaClient } = require('../generated/prisma');
const prisma = new PrismaClient();

const obtenerMesas = async (req, res) => {
  try {
    const mesas = await prisma.mesas.findMany();
    res.status(200).json(mesas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const obtenerMesaPorId = async (req, res) => {
  try {
    const { id } = req.params;
    const mesa = await prisma.mesas.findUnique({ where: { id: parseInt(id) } });
    if (!mesa) return res.status(404).json({ error: 'Mesa no encontrada' });
    res.status(200).json(mesa);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const crearMesa = async (req, res) => {
  try {
    const { numero, capacidad } = req.body;
    const nuevaMesa = await prisma.mesas.create({
      data: { numero, capacidad }
    });
    res.status(201).json(nuevaMesa);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const actualizarMesa = async (req, res) => {
  try {
    const { id } = req.params;
    const { numero, capacidad, disponible } = req.body;
    const mesaActualizada = await prisma.mesas.update({
      where: { id: parseInt(id) },
      data: { numero, capacidad, disponible }
    });
    res.status(200).json(mesaActualizada);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const eliminarMesa = async (req, res) => {
  try {
    const { id } = req.params;
    const mesaEliminada = await prisma.mesas.update({
      where: { id: parseInt(id) },
      data: { disponible: false }
    });
    res.status(200).json({ mensaje: 'Mesa deshabilitada', mesa: mesaEliminada });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { obtenerMesas, obtenerMesaPorId, crearMesa, actualizarMesa, eliminarMesa };