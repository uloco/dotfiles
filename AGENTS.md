# Agent Guidelines for Dotfiles Repository

## Build/Lint/Test Commands
- No build system is present in this dotfiles repository
- No linting configuration is present
- No test framework is configured

## Code Style Guidelines
- **File Organization**: Folder structure mirrors the original locations of configuration files (e.g., `.config/bat/`, `.ssh/`, `.zsh/`) to work with GNU Stow. This ensures that when stow is used, files are symlinked to their correct locations.
- **Naming**: Use descriptive names for configuration files (e.g., `config-dark.conf`, `config-light.conf`)
- **Formatting**: Maintain consistent indentation and spacing in configuration files
- **Imports/Includes**: When applicable, keep include statements at the top of configuration files
- **Error Handling**: No specific error handling patterns as this is primarily a configuration repository
- **Documentation**: Include comments in configuration files to explain non-obvious settings

## Repository Structure
- Folder structure mirrors the original locations of configuration files to work with GNU Stow
- Each top-level directory (e.g., `.config/`, `.ssh/`, `.zsh/`, etc.) matches the target location in the home directory, so stow can symlink files as if they were in their original locations.
- Application-specific directories contain their respective configuration files, preserving the original directory hierarchy for compatibility with stow.
- Global configuration files (not belonging to a specific application) are placed in the root directory
- The `setup.sh` script handles initial environment setup, software installation, and configuration symlinking

## Special Notes
- This repository uses GNU Stow for managing dotfiles
- Use `stow *` to symlink all configuration files to their appropriate locations in the home directory, preserving the intended structure.