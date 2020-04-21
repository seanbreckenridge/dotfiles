import os
import subprocess
from ranger.api.commands import Command


class fzf_select(Command):
    """
    Find a file using fzf. Use fd instead of find.
    """

    fd_command = "fd -L"

    @property
    def command(self):
        """Command to run to run the find/fzf command"""
        return "{} | fzf +m".format(self.__class__.fd_command)

    def execute(self):
        fzf = self.fm.execute_command(self.command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode("utf-8").rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class fzf_select_hidden(fzf_select):
    """
    same as fzf_select but shows hidden files
    """

    fd_command = "fd -L -H"
