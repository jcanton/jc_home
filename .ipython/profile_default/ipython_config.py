c = get_config()

c.TerminalIPythonApp.display_banner = True

c.InteractiveShellApp.extensions = ['autoreload']

c.InteractiveShellApp.exec_lines = [
    '%autoreload 2',
    'import numpy as np',
    'import matplotlib.pyplot as plt',
    'np.set_printoptions(precision=4,suppress=False,linewidth=300)',
    #'import IPython',
    #'terminal = IPython.get_ipython()',
    #'terminal.pt_app.auto_suggest = None'
]
c.InteractiveShellApp.exec_files = ['functions.py'] 
c.TerminalInteractiveShell.autosuggestions_provider = None
