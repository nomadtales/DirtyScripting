# See https://learn.adafruit.com/circuitpython-essentials/circuitpython-hid-keyboard-and-mouse

import time
import board
import digitalio
import usb_hid
from adafruit_hid.keyboard import Keyboard
from adafruit_hid.keyboard_layout_us import KeyboardLayoutUS
from adafruit_hid.keycode import Keycode

# The pins we'll use, each will have an internal pullup
keypress_pins = [board.GP14, board.GP15]

# Our array of key objects
key_pin_array = []

# The Keycode sent for each button, will be paired with a control key
keys_pressed = [Keycode.E, Keycode.SPACEBAR]

# The keyboard object!
time.sleep(1)  # Sleep for a bit to avoid a race condition on some systems
keyboard = Keyboard(usb_hid.devices)
keyboard_layout = KeyboardLayoutUS(keyboard)  # We're in the US :)

# Make all pin objects inputs
for pin in keypress_pins:
    key_pin = digitalio.DigitalInOut(pin)
    key_pin.direction = digitalio.Direction.INPUT
    key_pin.pull = digitalio.Pull.DOWN
    key_pin_array.append(key_pin)

print("Waiting for key pin...")

while True:
    # Check each pin
    for key_pin in key_pin_array:
        if key_pin.value:  
            i = key_pin_array.index(key_pin)
            print("Key pin #%d pressed." % i)
            while not key_pin.value:
                pass  # Wait for it to be ungrounded!
            # "Type" the Keycode or string
            key = keys_pressed[i]  # Get the corresponding Keycode or string
            keyboard.press(key)  # "Press"...
            keyboard.release_all()  # ..."Release"!
            
    time.sleep(0.1)
