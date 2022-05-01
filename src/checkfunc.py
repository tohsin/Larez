import time

def auth(template):
    timer = 5
    run = True
    while run:
        time.sleep(1)
        timer-=1
        if timer == 0:
            yield "Nothing placed. Restarting..."
            yield None; return
            #yield True; run = False
    else:
        time.sleep(3)
        #yield '11'
        yield False
        return

    '''
    real code
    while: timer goes to zero, yield None ; return
        OR: if finger scanned, yield True ; run = False
    else:  ->> yield str or False

    '''
    print('out')
    yield '11'

def enroll_finger(reg_no):
    """Take a 2 finger images and template it, then store in 'location'"""
    for fingerimg in range(1, 3):
        if fingerimg == 1:
            yield "Place finger on sensor..."
            time.sleep(4)
        else:
            yield "Place same finger again..."
            time.sleep(3)
    yield "Remove finger"
    time.sleep(3)
    yield "Templating Successful"
    time.sleep(3)
    yield {reg_no: [1,2,4,5,7,8,9,6,4,3]}



def get_num():
    """Use input() to get a valid number from 1 to 127. Retry till success!"""
    i = 0
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

