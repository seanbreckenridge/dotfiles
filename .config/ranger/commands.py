
import os
import subprocess
from ranger.api.commands import Command


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.
    With a prefix argument select only directories.

    Use fd instead of find

    Modified from: https://github.com/junegunn/fzf
    """

    def find_command(self):
        """To support nicer polymorphism"""
        return "fd -L"

    @property
    def command(self):
        """Command to run to run the find/fzf command"""
        return "{} | fzf +m".format(self.find_command())

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

    def find_command(self):
        return "fd -L -H"
