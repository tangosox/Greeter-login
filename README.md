# Greeter-login
Login via ssh to gui login with uinput and ydotool
You will need uinput kernel module active and your user added to input group.
Also need ydotool installed.

The script currently checks to see if you plasma login manager is running on seat0 before starting
ydotoold. Then it inputs backspace for 1.5 seconds to clear the field, asks you for your password 
before passing that silently to the password field and pressing enter.

The purpose of this is to log in remotely to your gui session for sunshine access after restarting or logging out of 
your machine.
