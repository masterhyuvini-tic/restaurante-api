const { PrismaClient } = require('../generated/prisma');
const prisma = new PrismaClient();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const registrar = async (req, res) => {
  try {
    const { nombre, correo, password } = req.body;

    // Encriptamos la contraseña antes de guardarla
    const passwordEncriptada = await bcrypt.hash(password, 10);

    // Guardamos el usuario en la base de datos con Prisma
    const nuevoUsuario = await prisma.usuarios.create({
      data: {
        nombre,
        correo,
        password: passwordEncriptada,
        rol: 'cliente' // todo registro por la API es cliente
      }
    });

    // Nunca devolvemos la contraseña en la respuesta
    res.status(201).json({
      id: nuevoUsuario.id,
      nombre: nuevoUsuario.nombre,
      correo: nuevoUsuario.correo,
      rol: nuevoUsuario.rol
    });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const login = async (req, res) => {
  try {
    const { correo, password } = req.body;

    const usuario = await prisma.usuarios.findUnique({ where: { correo } });
    if (!usuario) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    const passwordValida = await bcrypt.compare(password, usuario.password);
    if (!passwordValida) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    const token = jwt.sign(
      { id: usuario.id, correo: usuario.correo, rol: usuario.rol },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN }
    );

    res.status(200).json({ token, usuario: { id: usuario.id, nombre: usuario.nombre, rol: usuario.rol } });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { registrar, login };