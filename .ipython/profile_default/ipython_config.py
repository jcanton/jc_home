c = get_config()

c.TerminalIPythonApp.display_banner = True

c.InteractiveShellApp.extensions = ['autoreload']

c.InteractiveShellApp.exec_lines = [
    '%autoreload 2',
    'import numpy as np',
    'import matplotlib.pyplot as plt',
    'np.set_printoptions(precision=4,suppress=False,linewidth=300)'
]
