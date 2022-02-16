import sys
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QMainWindow

class MainWindow(QMainWindow): 
    def __init__(self):
        super().__init__() 
        self.setWindowTitle("My App")
        button = QPushButton("Press Me!")
          # Set the central widget of the Window.
        self.setCentralWidget(button)
         
app = QApplication(sys.argv)
window = MainWindow()
window.show()
app.exec_()
