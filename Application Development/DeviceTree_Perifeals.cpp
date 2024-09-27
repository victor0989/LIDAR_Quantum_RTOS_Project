Write your devicetree
The devicetree file boards/<vendor>/plank/plank.dts or boards/<vendor>/plank/plank_<qualifiers>.dts describes your board hardware in the Devicetree Source (DTS) format (as usual, change plank to your board’s name). If you’re new to devicetree, see Introduction to devicetree.

In general, plank.dts should look like this:

/dts-v1/;
#include <your_soc_vendor/your_soc.dtsi>

/ {
        model = "A human readable name";
        compatible = "yourcompany,plank";

        chosen {
                zephyr,console = &your_uart_console;
                zephyr,sram = &your_memory_node;
                /* other chosen settings  for your hardware */
        };

        /*
         * Your board-specific hardware: buttons, LEDs, sensors, etc.
         */

        leds {
                compatible = "gpio-leds";
                led0: led_0 {
                        gpios = < /* GPIO your LED is hooked up to */ >;
                        label = "LED 0";
                };
                /* ... other LEDs ... */
        };

        buttons {
                compatible = "gpio-keys";
                /* ... your button definitions ... */
        };

        /* These aliases are provided for compatibility with samples */
        aliases {
                led0 = &led0; /* now you support the blinky sample! */
                /* other aliases go here */
        };
};

&some_peripheral_you_want_to_enable { /* like a GPIO or SPI controller */
        status = "okay";
};

&another_peripheral_you_want {
        status = "okay";
};

Only one .dts file will be used, and the most specific file which exists will be used.

This means that if both plank.dts and plank_soc1_foo.dts exist, then when building for plank / plank/soc1, then plank.dts is used. When building for plank//foo / plank/soc1/foo the plank_soc1_foo.dts is used.

This allows board maintainers to write a base devicetree file for the board or write specific devicetree files for a given board’s SoC or variant.


