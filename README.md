# Sistema de Monitoreo y Gestión de Servidores en Bash

Este proyecto es un sistema de monitoreo y gestión de servidores desarrollado en Bash. Proporciona una interfaz gráfica de usuario para monitorear el estado de los servidores, configurar alertas, gestionar servicios y ver un registro de actividades.

## Arquitectura

El sistema sigue una arquitectura cliente-servidor, donde:

- El **cliente** es la interfaz gráfica de usuario que se ejecuta en la estación de trabajo del usuario.
- El **servidor** es responsable de recopilar datos de monitoreo de los servidores remotos.

La comunicación entre el cliente y el servidor se realiza a través de conexiones SSH seguras.

## Funcionalidades

- Ver el estado de los servidores, incluyendo la carga de CPU, el uso de memoria, etc.
- Configurar umbrales de alerta para diferentes métricas de rendimiento y recibir notificaciones cuando se superen estos umbrales.
- Iniciar, detener o reiniciar servicios en los servidores remotos.
- Mostrar un registro de las actividades realizadas por los usuarios a través de la herramienta.

## Requisitos del Sistema

- Unix/Linux
- `bash` (Bourne Again Shell)
- `dialog` (para la interfaz gráfica de usuario)
- Acceso SSH a los servidores que se desean monitorear y gestionar

## Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/tu_usuario/sistema-monitoreo-servidores.git
```

2. Ingresa al directorio del proyecto:

```bash
cd sistema-monitoreo-servidores
```

3. Ejecuta el script principal para iniciar la aplicación:

```bash
./AdminBash.sh
```

## Uso

- Al iniciar la aplicación, se mostrará un menú principal con varias opciones.
- Selecciona una opción utilizando las teclas de flecha y Enter.
- Sigue las instrucciones en pantalla para realizar las acciones deseadas, como ver el estado de los servidores o configurar alertas.

## Configuración

- Editar el archivo `AdminBash.sh` para personalizar las direcciones IP de los servidores y cualquier otra configuración necesaria.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas contribuir al proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama para tu función: `git checkout -b nueva-funcionalidad`
3. Realiza tus cambios y haz commit: `git commit -am 'Añade nueva funcionalidad'`
4. Sube los cambios a tu fork: `git push origin nueva-funcionalidad`
5. Envía un pull request para que tus cambios sean revisados.

## Créditos

Este proyecto fue creado por [Nixon Ortiz](https://github.com/Argon69).

## Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).
