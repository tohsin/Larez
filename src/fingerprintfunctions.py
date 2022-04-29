#to cache in finger print
mem = {}

import time
import board
import busio
from digitalio import DigitalInOut, Direction
import adafruit_fingerprint
import serial
led = DigitalInOut(board.D13)
led.direction = Direction.OUTPUT

    #incase the finger print doesnt load
uart = serial.Serial("/dev/ttyUSB0", baudrate=57600, timeout=1)
finger = adafruit_fingerprint.Adafruit_Fingerprint(uart)

def auth(template):
    #print("Waiting for finger print...")
    timer = 3
    while finger.get_image() != adafruit_fingerprint.OK:
        time.sleep(1)
        timer -= 1
        if timer == 0: yield None
    yield True
    yield "Templating..."
    if finger.image_2_tz(1) != adafruit_fingerprint.OK:
        yield False

    yield "Loading file template..."

    data = template
    finger.send_fpdata(list(data), "char", 2)

    i = finger.compare_templates()
    if i == adafruit_fingerprint.OK:
        yield "Fingerprint match template in file."
        time.sleep(1)
        yield "Found"
        return
    if i == adafruit_fingerprint.NOMATCH:
        yield "Templates do not match!"
    else:
        yield "Other error!"
    yield False



def enroll_finger(reg_no):
    """Take a 2 finger images and template it, then store in 'location'"""
    for fingerimg in range(1, 3):
        if fingerimg == 1:
            yield "Place finger on sensor..."
        else:
            yield "Place same finger again..."

        while True:
            i = finger.get_image()
            if i == adafruit_fingerprint.OK:
                yield "Image taken"
                break
            if i == adafruit_fingerprint.NOFINGER:
                print(".", end="", flush=True)
            elif i == adafruit_fingerprint.IMAGEFAIL:
                yield "Imaging error"
                yield False
                return
            else:
                yield "Other error"
                yield False
                return

        yield "Templating..."

        i = finger.image_2_tz(fingerimg)
        if i == adafruit_fingerprint.OK:

            yield "Templated"
        else:
            if i == adafruit_fingerprint.IMAGEMESS:
                yield "Image too messy"
            elif i == adafruit_fingerprint.FEATUREFAIL:
                yield "Could not identify features"
            elif i == adafruit_fingerprint.INVALIDIMAGE:
                yield "Image invalid"
            else:
                yield "Other error"
            return False

        if fingerimg == 1:
            yield "Remove finger"
            time.sleep(1)
            while i != adafruit_fingerprint.NOFINGER:
                i = finger.get_image()

    mem[reg_no] = finger.get_fpdata('char',1)
    mem2[finger.get_fpdata('char',1)] = reg_no

    print(mem)    
    yield mem2

    return True

def get_num():
    """Use input() to get a valid number from 1 to 127. Retry till success!"""
    i = 0
    while (i > 127) or (i < 1):
        try:
            i = int(input("Enter ID # from 1-127: "))
        except ValueError:
            pass
    return i

if __name__ == '__main__':
    #recurrent code
    while True:
        if not finger or not uart:
            print("Error loading the finger print scanner")
        if finger.read_templates() != adafruit_fingerprint.OK:
            raise RuntimeError("Failed to read templates")
        print("e) enroll print")
        print("a) autheticat finger")
        c = input("> ")
        if c == "e":
            print('Please enter your reg no')
            reg_no = input("> ")
            enroll_finger(reg_no)

        if c== "a":
            print('Please enter your reg no')
            reg_no = input("> ")
            if reg_no in mem:
                template = mem[reg_no]
                auth(template)
            else:
                print("That reg no doesnt exist")

