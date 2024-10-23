#include <zephyr.h>
#include <sys/printk.h>
#include <device.h>
#include <drivers/gpio.h>

#define BUTTON_PIN 15  // Define el número del pin para el botón
#define GPIO_DEV_NAME "GPIO_0"

static const struct device *gpio_dev;

void setup_gpio(void) {
    gpio_dev = device_get_binding(GPIO_DEV_NAME);
    if (gpio_dev == NULL) {
        printk("Error: No se puede acceder al dispositivo GPIO\n");
        return;
    }

    // Configurar el pin como entrada
    gpio_pin_configure(gpio_dev, BUTTON_PIN, GPIO_INPUT | GPIO_PULL_UP);

    // Habilitar interrupciones en el pin del botón
    gpio_pin_interrupt_configure(gpio_dev, BUTTON_PIN, GPIO_INT_EDGE_TO_ACTIVE);
}

void button_isr(const struct device *dev, struct gpio_callback *cb, uint32_t pins) {
    printk("Interrupción de botón detectada.\n");
    // Aquí iría la lógica para manejar la interrupción
}

static struct gpio_callback button_cb;

void interruptGPIO(void) {
    setup_gpio();

    // Inicializar el callback de interrupción
    gpio_init_callback(&button_cb, button_isr, BIT(BUTTON_PIN));

    // Añadir el callback a la interrupción del GPIO
    gpio_add_callback(gpio_dev, &button_cb);

    printk("Sistema listo. Esperando interrupciones...\n");

    while (1) {
        k_msleep(1000);  // Esperar para evitar el bucle de trabajo intenso
    }
}
