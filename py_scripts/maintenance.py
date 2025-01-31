import os
import subprocess

BREWFILE_PATH = "~/Documents/personal/personal-coding-projects/dotfiles/brew"


def run_command(command, capture_output=False):
    """Helper function to run a shell command and optionally capture the output"""
    result = subprocess.run(
        command, shell=True, text=True, capture_output=capture_output
    )
    # Print error code and stderr when an error occurs
    if result.returncode != 0:
        print(f"Error running command: {command}")
        print(f"Exit code: {result.returncode}")
        print(result.stderr)
    return result


def main():
    starting_directory = os.getcwd()

    # Update all package definitions (formulae) and Homebrew itself
    print("🍺 Updating Homebrew")
    run_command("brew update", capture_output=True)

    # Upgrade installed packages (kegs)
    print("⬆️ Upgrade casks and formulae")
    run_command("brew upgrade", capture_output=True)
    run_command("brew upgrade --cask", capture_output=True)

    # Install pending upgrades from the Mac App Store
    print("⬆️ Upgrade apps from Apple store")
    run_command("mas upgrade", capture_output=True)

    # Brew uninstall formulaes that are no longer dependencies
    print("🗑️ Uninstall formulae that are no longer needed")
    run_command("brew autoremove", capture_output=True)

    # Remove outdated download files from cache, as well as old versions of installed packages
    print("🧹 Clean up formulae and casks")
    run_command("brew cleanup", capture_output=True)

    # Create a Brewfile with descriptions of formulaes
    print(f"🍺 Creating Brewfile at {BREWFILE_PATH}")
    run_command(
        f"brew bundle dump -f --describe --file={BREWFILE_PATH}/Brewfile",
        capture_output=True,
    )

    # Append Brewfile path with the user path
    brewfile_path_user = os.path.expanduser(BREWFILE_PATH)

    # Change current directory to wherever the Brewfile lies
    os.chdir(brewfile_path_user)

    # Check if the Brewfile has changed
    result = run_command("git status -s Brewfile", capture_output=True)

    # If the Brewfile has changed, commit the file and push it to the remote
    if "M Brewfile" in result.stdout:
        print("👾 Push Brewfile to remote repository")
        run_command(f"git add {BREWFILE_PATH}/Brewfile", capture_output=True)
        run_command('git commit -m "update brewfile"', capture_output=True)
        run_command("git push", capture_output=True)

    # Change the current directory back to the directory where this script was ran
    os.chdir(starting_directory)

    # Relink the latest Node LTS version, because Homebrew will install the latest one
    print("🔄 Relinking node@22")
    run_command("brew link --overwrite node@22", capture_output=True)

    # Update the tldr database
    print("🗃️ Update tldr database")
    run_command("tldr --update", capture_output=True)

    # Update to the latest npm version
    print("💚 Updating npm")
    run_command("npm i -g npm@latest", capture_output=True)

    # Update the globally installed npm-check-updates dependency
    print("💚 Updating npm-check-updates")
    run_command("npm i -g npm-check-updates@latest", capture_output=True)


if __name__ == "__main__":
    main()
