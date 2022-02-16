from PyQt5.QtWidgets import *
from PyQt5 import QtCore, QtGui
from PyQt5.QtGui import *
from PyQt5.QtCore import * 
import sys
  
class App(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setGeometry(0, 30, 500, 500)
        self.init_ui()
        self.show()

    def init_ui(self):
        self.central_widget = QStackedWidget()

        self.setCentralWidget(self.central_widget)

        self.report_screen = ReportWindow(self)
        self.company_screen = CompanyWindow(self)

        self.central_widget.addWidget(self.report_screen)
        self.central_widget.addWidget(self.company_screen)

        self.central_widget.setCurrentWidget(self.report_screen)

        self.report_screen.clicked.connect(lambda: 
        self.central_widget.setCurrentWidget(self.company_screen))
        self.company_screen.clicked.connect(lambda: 
        self.central_widget.setCurrentWidget(self.report_screen))
        
class Report(object):
    clicked = pyqtSignal()

    def detail_report(self):
        self.layout = QHBoxLayout()
        self.button = QPushButton('test1')
        self.layout.addWidget(self.button)
        self.setLayout(self.layout)
        self.button.clicked.connect(self.clicked.emit)


class ReportWindow(QWidget, Report):
    def __init__(self, parent=None):
        super(ReportWindow, self).__init__(parent)
        self.detail_report()
class Company(object):
    clicked = pyqtSignal()

    def list_companies(self):
        self.layout = QHBoxLayout()
        self.button = QPushButton('test2')
        self.layout.addWidget(self.button)
        self.setLayout(self.layout)
        self.button.clicked.connect(self.clicked.emit)


class CompanyWindow(QWidget, Company):
    clicked = pyqtSignal()
    def __init__(self, parent=None):
        super(CompanyWindow, self).__init__(parent)
        self.list_companies()


if __name__ == '__main__':
    import sys

    app = QApplication(sys.argv)
    w = App()
    w.show()
    sys.exit(app.exec_())