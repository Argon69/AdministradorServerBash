#!/bin/bash

# Función para mostrar el menú principal
show_main_menu() {
    dialog --backtitle "Sistema de Monitoreo de Servidores" \
           --title "Menú Principal" \
           --cancel-label "Salir" \
           --menu "Seleccione una opción:" 12 50 5 \
           1 "Ver estado de los servidores" \
           2 "Configurar alertas" \
           3 "Gestionar servicios" \
           4 "Registro de actividades" \
           5 "Salir" \
           2> /tmp/choice.txt

    # Capturamos el código de salida
    choice=$?
    # Obtenemos la opción seleccionada
    menu_choice=$(cat /tmp/choice.txt)

    # Borramos el archivo temporal
    rm -f /tmp/choice.txt

    # Manejamos las opciones seleccionadas
    case $choice in
        0)  # Opción seleccionada correctamente
            case $menu_choice in
                1)  show_server_status ;;
                2)  configure_alerts ;;
                3)  manage_services ;;
                4)  show_activity_log ;;
                5)  exit ;;
            esac ;;
        1)  # Se presionó "Cancelar" o "Esc"
            exit ;;
        255) # Se presionó "Cancelar" o "Esc"
            exit ;;
    esac
}

# Función para mostrar el estado de los servidores (solo un ejemplo, reemplazar con tu propia lógica)
show_server_status() {

    # Direcciones IP de los servidores (reemplaza con tus propias direcciones)
    server1="usuario@servidor1"
    server2="usuario@servidor2"
    
    # Ejecutamos comandos remotos para obtener el estado de los servidores
    status_server1=$(ssh "$server1" "uptime")
    status_server2=$(ssh "$server2" "uptime")

    # Mostramos el estado de los servidores en una ventana de diálogo
    dialog --title "Estado de los Servidores" \
           --msgbox "Servidor 1:\n\n$status_server1\n\nServidor 2:\n\n$status_server2" 20 60

    show_main_menu
}

# Función para configurar alertas (solo un ejemplo, reemplazar con tu propia lógica)
configure_alerts() {

    # Direcciones IP de los servidores (reemplaza con tus propias direcciones)
    server1="usuario@servidor1"
    server2="usuario@servidor2"
    
    # Solicitamos al usuario que ingrese el umbral de carga de CPU
    dialog --inputbox "Ingrese el umbral de carga de CPU (%):" 8 40 2> /tmp/cpu_threshold.txt
    cpu_threshold=$(cat /tmp/cpu_threshold.txt)
    rm -f /tmp/cpu_threshold.txt

    # Configuramos la alerta en cada servidor
    ssh "$server1" "echo '*/5 * * * * if [ \$(uptime | awk -F\"load average:\" '{print \$2}' | awk '{print \$1*100}' | cut -d. -f1) -ge $cpu_threshold ]; then echo \"La carga de CPU es alta en el servidor 1\"; fi' | crontab -"
    ssh "$server2" "echo '*/5 * * * * if [ \$(uptime | awk -F\"load average:\" '{print \$2}' | awk '{print \$1*100}' | cut -d. -f1) -ge $cpu_threshold ]; then echo \"La carga de CPU es alta en el servidor 2\"; fi' | crontab -"

    # Mostramos un mensaje de confirmación
    dialog --title "Configuración de Alertas" \
           --msgbox "Se configuraron las alertas de carga de CPU en los servidores.\n\nUmbral: $cpu_threshold%" 10 40


    show_main_menu
}

# Función para gestionar servicios (solo un ejemplo, reemplazar con tu propia lógica)
manage_services() {
    # Direcciones IP de los servidores (reemplaza con tus propias direcciones)
    server1="usuario@servidor1"
    server2="usuario@servidor2"
    
    # Mostramos al usuario una lista de servicios disponibles en los servidores
    dialog --menu "Seleccione un servicio para gestionar:" 15 50 5 \
        1 "nginx" \
        2 "apache2" \
        3 "mysql" \
        4 "mongodb" \
        5 "Salir" 2> /tmp/service_choice.txt

    # Capturamos el código de salida
    choice=$?
    # Obtenemos el servicio seleccionado
    service_choice=$(cat /tmp/service_choice.txt)
    # Borramos el archivo temporal
    rm -f /tmp/service_choice.txt

    # Manejamos las opciones seleccionadas
    case $choice in
        0)  # Opción seleccionada correctamente
            case $service_choice in
                1)  manage_service "nginx" ;;
                2)  manage_service "apache2" ;;
                3)  manage_service "mysql" ;;
                4)  manage_service "mongodb" ;;
                5)  show_main_menu ;;
            esac ;;
        1)  # Se presionó "Cancelar" o "Esc"
            show_main_menu ;;
        255) # Se presionó "Cancelar" o "Esc"
            show_main_menu ;;
    esac
}

# Función para gestionar un servicio específico en un servidor
manage_service() {

 # Direcciones IP de los servidores (reemplaza con tus propias direcciones)
    server1="usuario@servidor1"
    server2="usuario@servidor2"
    
    # Mostramos un menú para que el usuario seleccione el servicio a gestionar
    dialog --menu "Seleccione el servicio a gestionar:" 12 40 5 \
           1 "nginx" \
           2 "apache2" \
           3 "mysql" \
           4 "postgresql" \
           5 "Volver al menú principal" 2>/tmp/service_choice.txt
    choice=$(cat /tmp/service_choice.txt)
    rm -f /tmp/service_choice.txt

    # Ejecutamos el comando correspondiente en función de la selección del usuario
    case $choice in
        1)  service="nginx" ;;
        2)  service="apache2" ;;
        3)  service="mysql" ;;
        4)  service="postgresql" ;;
        5)  show_main_menu ;;
    esac

    # Mostramos un menú para que el usuario seleccione la acción a realizar
    dialog --menu "Seleccione la acción a realizar para $service:" 12 40 5 \
           1 "Iniciar" \
           2 "Detener" \
           3 "Reiniciar" \
           4 "Volver al menú principal" 2>/tmp/action_choice.txt
    choice=$(cat /tmp/action_choice.txt)
    rm -f /tmp/action_choice.txt

    # Ejecutamos la acción correspondiente en función de la selección del usuario
    case $choice in
        1)  ssh "$server1" "sudo service $service start" ;;
        2)  ssh "$server1" "sudo service $service stop" ;;
        3)  ssh "$server1" "sudo service $service restart" ;;
        4)  show_main_menu ;;
    esac

    # Mostramos un mensaje de confirmación
    dialog --title "Gestión de Servicios" \
           --msgbox "Se realizó la acción $choice para el servicio $service en el servidor." 10 40

    # Regresamos al menú principal
    show_main_menu
}

# Función para mostrar el registro de actividades (solo un ejemplo, reemplazar con tu propia lógica)
show_activity_log() {
   # Direcciones IP de los servidores (reemplaza con tus propias direcciones)
    server1="usuario@servidor1"
    server2="usuario@servidor2"
    
    # Mostramos el registro de actividades en cada servidor
    activity_server1=$(ssh "$server1" "cat /var/log/actividades.log")
    activity_server2=$(ssh "$server2" "cat /var/log/actividades.log")

    # Mostramos el registro de actividades en una ventana de diálogo
    dialog --title "Registro de Actividades" \
           --textbox <(echo -e "Registro de actividades en el servidor 1:\n\n$activity_server1\n\nRegistro de actividades en el servidor 2:\n\n$activity_server2") 20 80

    # Regresamos al menú principal
    show_main_menu
}

# Mostramos el menú principal
show_main_menu
