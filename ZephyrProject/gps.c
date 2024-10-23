#include <zephyr.h>
#include <device.h>
#include <drivers/serial.h>
#include <stdio.h>

#define GPS_DEVICE_LABEL "GPS_0"  // Asegúrate de que este nombre coincide con tu configuración

// Estructura para almacenar datos de GPS
struct gps_data {
    float latitude;
    float longitude;
};

// Inicializa el dispositivo GPS
const struct device *gps_init(void)
{
    const struct device *gps_device = device_get_binding(GPS_DEVICE_LABEL);
    if (!gps_device) {
        printf("GPS device not found!\n");
        return NULL;
    }
    return gps_device;
}

// Función para leer datos de GPS
int read_gps_data(const struct device *gps_device, struct gps_data *data)
{
    uint8_t buffer[64]; // Buffer para almacenar la cadena de datos
    int ret = serial_read(gps_device, buffer, sizeof(buffer));
    
    if (ret < 0) {
        printf("Failed to read from GPS device\n");
        return ret;
    }
    
    // Aquí, se debe analizar el buffer para extraer latitud y longitud.
    // Esto es un ejemplo simple; necesitarás un análisis adecuado para el formato NMEA o el que uses.
    sscanf((const char *)buffer, "$GNGNS,%f,%f", &data->latitude, &data->longitude); // Cambia según el formato real
    
    return 0;
}

// Función principal
void main(void)
{
    const struct device *gps_device = gps_init();
    if (!gps_device) {
        return;
    }

    struct gps_data data;

    while (1) {
        if (read_gps_data(gps_device, &data) == 0) {
            printf("Latitude: %f, Longitude: %f\n", data.latitude, data.longitude);
        }
        k_sleep(K_SECONDS(1)); // Espera un segundo entre lecturas
    }
}
