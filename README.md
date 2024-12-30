# Config Files Backup Script

This script automates the process of backing up essential configuration files and directories from your home directory to a remote GitHub repository. It uses `rsync` to copy files and directories, ensuring that the structure and permissions are preserved.

---

## Features

- Backs up important files and directories, including shell configurations, SSH keys, Kubernetes configs, and more.
- Supports the use of `rsync` for efficient and reliable file transfers.
- Initializes a Git repository and pushes the backup to a remote repository on GitHub.
- Handles globs for directories (e.g., `.zsh*`, `.config/*`), allowing you to back up multiple related files.
- Allows for easy restoration by cloning the GitHub repository to another machine.

---

## Prerequisites

Before running the script, ensure that the following requirements are met:

- **`rsync` Version**: The script checks that your `rsync` version is greater than 3.0. If it's not, you may need to install or update it using Homebrew.
- **GitHub Repository**: The script pushes the backup to a GitHub repository. You need to create a repository and update the `GITHUB_REPO_URL` variable with the appropriate URL. Make sure this is not a public repository.

---

## Files and Directories Included

By default, the script backs up the following files and directories from your home directory:

- Shell Configuration Files:
  - `.bashrc`
  - `.zshrc`
  - `.zsh*`
- Git Configuration:
  - `.gitconfig`
- SSH Configuration:
  - `.ssh/*`
- AWS Configuration:
  - `.aws/`
- Kubernetes Configurations:
  - `.kube/config`
  - `.kube/grofers-k8s-config`
- Other Config Files:
  - `.config/kafkactl/*`
  - `.config/gh/*`
  - `.config/iterm2/*`
  - `.config/JetBrains`
  - `.config/Code/User/settings.json`
  - `.npmrc`

Feel free to add additional files or directories to the `CONFIG_ITEMS` array in the script to customize what gets backed up.

---

## Installation and Setup

1. **Clone the Repository:**

   Clone the repository to your local machine where the script will be executed:

   ```bash
   git clone https://github.com/rishav394/config-files.git
   cd config-files
   ```

2. **Update `GITHUB_REPO_URL`:**

   Open the script and ensure the `GITHUB_REPO_URL` variable points to the correct repository URL:

   ```bash
   GITHUB_REPO_URL="git@github.com:rishav394/config-files.git"
   ```

3. **Check `rsync` Version:**

   The script uses `rsync` to handle file copying. Ensure that your `rsync` version is greater than 3.0. To check your `rsync` version:

   ```bash
   rsync --version
   ```

   If it's older, you can install it using Homebrew:

   ```bash
   brew install rsync
   ```

4. **Make the Script Executable:**

   Grant execute permissions to the script:

   ```bash
   chmod +x backup.sh
   ```

---

## Running the Script

To run the backup script manually:

```bash
./backup.sh
```

### Scheduled Backups (Optional)

You can schedule this script to run automatically at regular intervals using `cron` or other task schedulers. For example, to run the script every 6 hours, you can add it to your crontab:

```bash
crontab -e
```

Then add the following line to run the script every 6 hours:

```bash
0 */6 * * * /path/to/backup.sh
```

---

## How It Works

1. **Backup Process**: The script creates a backup directory (`$HOME/config-files`) and copies the files and directories listed in `CONFIG_ITEMS` to that directory.
2. **Git Initialization**: If a Git repository doesn't already exist in the backup directory, the script will initialize it, set the remote repository, and pull the latest changes from the specified branch.
3. **Commit and Push**: The script stages the changes, commits them with a message, and pushes them to the specified GitHub repository.

---

## Customization

- **Add/Remove Files**: You can customize the list of files and directories to back up by modifying the `CONFIG_ITEMS` array in the script.
- **Commit Message**: The commit message is automatically generated with the current date, but you can customize it by modifying the `COMMIT_MESSAGE` variable.
- **Git Branch**: By default, the script uses the `main` branch for backups. You can change the `BRANCH` variable to use a different branch.

---

## Troubleshooting

- **Missing Files**: If certain files or directories are not found, the script will print a warning but will continue with the backup process. Ensure the paths to the files are correct and that they exist on your system.
- **Permissions**: Ensure that you have the necessary permissions to read the files you want to back up and write to the backup directory.

---

## License

This script is released under the [MIT License](LICENSE). Feel free to fork, modify, and use it as you like.
