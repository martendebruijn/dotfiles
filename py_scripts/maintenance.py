import os
import subprocess

brewfile_path = "~/Documents/personal/personal-coding-projects/dotfiles/brew"


def run_command(command, capture_output=False):
    """Helper function to run a shell command and optionally capture the output"""
    result = subprocess.run(
        command, shell=True, text=True, capture_output=capture_output
    )
    if result.returncode != 0:
        print(f"Error running command: {command}")
        print(result.stderr)
    return result


def main():
    starting_directory = os.getcwd()

    print("🍺 Updating Homebrew")
    run_command("brew update", capture_output=True)

    print("⬆️ Upgrade casks and formulae")
    run_command("brew upgrade", capture_output=True)
    run_command("brew upgrade --cask", capture_output=True)

    print("⬆️ Upgrade apps from Apple store")
    run_command("mas upgrade", capture_output=True)

    print("🗑️ Uninstall formulae that are no longer needed")
    run_command("brew autoremove", capture_output=True)

    print("🧹 Clean up formulae and casks")
    run_command("brew cleanup", capture_output=True)

    print(f"🍺 Creating Brewfile at {brewfile_path}")
    run_command(
        f"brew bundle dump -f --describe --file={brewfile_path}/Brewfile",
        capture_output=True,
    )

    brewfile_path_user = os.path.expanduser(brewfile_path)
    os.chdir(brewfile_path_user)
    result = run_command("git status -s Brewfile", capture_output=True)
    if "M Brewfile" in result.stdout:
        print("👾 Push Brewfile to remote repository")
        run_command(f"git add {brewfile_path}/Brewfile", capture_output=True)
        run_command('git commit -m "update brewfile"', capture_output=True)
        run_command("git push", capture_output=True)
    os.chdir(starting_directory)

    print("🔄 Relinking node@22")
    run_command("brew link --overwrite node@22", capture_output=True)

    print("🗃️ Update tldr database")
    run_command("tldr --update", capture_output=True)

    print("💚 Updating npm")
    run_command("npm i -g npm@latest", capture_output=True)

    print("💚 Updating npm-check-updates")
    run_command("npm i -g npm-check-updates@latest", capture_output=True)


if __name__ == "__main__":
    main()
