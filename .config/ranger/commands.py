import os
import subprocess
import shutil
from typing import List, Union, Optional
from ranger.api.commands import Command
from os.path import abspath


class fzf_select(Command):
    """
    Find a file using fzf. Use fd instead of find.
    """

    fd_command = "fd -L"
    multi_select = False
    preview = True

    @property
    def command(self):
        """Command to run to run the find/fzf command"""
        return "{} | fzf {} {}".format(
            self.__class__.fd_command,
            "-m" if self.__class__.multi_select else "+m",
            "--preview='${HOME}/.config/fzf_preview {}'"
            if self.__class__.preview
            else "",
        )

    # helper function to run fzf in with self.command
    # returns file if selected else none
    def run_fzf(self) -> Optional[Union[List, str]]:
        fzf = self.fm.execute_command(self.command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            stdout_decoded = stdout.decode("utf-8").strip()
            if self.__class__.multi_select:
                return list(
                    map(
                        lambda s: os.path.abspath(s).strip(),
                        stdout_decoded.splitlines(),
                    )
                )
            else:
                return os.path.abspath(stdout_decoded)
        else:
            return None

    def execute(self):
        fzf_file = self.run_fzf()
        if fzf_file is not None:
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class fzf_select_hidden(fzf_select):
    """
    same as fzf_select but shows hidden files
    """

    fd_command = "fd -L -H"


class fzf_copy_from(fzf_select):
    """
    Accepts a directory as the first argument
    Prompts a multi-select fzf interface to pick
    files from the passed directory and copies
    them to the current directory.
    """

    # search 2 levels down
    fd_command = "fd -d 2 -L"
    multi_select = True

    def execute(self):
        directory = os.path.join(os.environ["HOME"], "Downloads")
        # get directory from first argument
        if self.arg(1):
            # normalize, convert to directory if user passed file
            filepath = os.path.abspath(os.path.expanduser(self.arg(1)))
            if not os.path.isdir(filepath):
                filepath = os.path.dirname(filepath)
            directory = filepath
        os.chdir(directory)
        fzf_files: Optional[List[str]] = self.run_fzf()
        if fzf_files is not None:
            for f in fzf_files:
                to_path = os.path.join(self.fm.thisdir.path, os.path.basename(f))
                # avoid overwriting a file
                while os.path.exists(to_path):
                    to_path = f"{to_path}_"
                shutil.copyfile(f, to_path)
