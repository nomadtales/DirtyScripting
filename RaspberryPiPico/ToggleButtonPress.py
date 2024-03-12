# some code for toggle used from here: https://github.com/todbot/circuitpython-tricks#turn-a-momentary-value-into-a-toggle

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

# Variables to store toggle state 
last_touch_val = False  # holds last measurement
toggle_value = False  # holds state of toggle switch

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
        touch_val = key_pin.value
        if touch_val != last_touch_val:
            if touch_val:
                i = key_pin_array.index(key_pin)
                print("Key pin #%d pressed." % i)
                while not key_pin.value:
                    pass  # Wait for it to be ungrounded!
                # "Type" the Keycode or string
                key = keys_pressed[i]  # Get the corresponding Keycode or string
                keyboard.press(key)  # "Press"...
                keyboard.release_all()  # ..."Release"!
                toggle_value = not toggle_value   # flip toggle
            last_touch_val = touch_val
    time.sleep(0.1)