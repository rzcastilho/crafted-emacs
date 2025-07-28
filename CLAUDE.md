# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Emacs configuration built on top of Crafted Emacs, a modular Emacs distribution. The configuration is structured to provide a modern development environment with language servers, debugging capabilities, and modern UI components.

## Key Architecture

### Base Framework
- **Crafted Emacs**: The configuration loads modules from `~/crafted-emacs/modules/` which must be cloned separately
- **Module System**: Uses `crafted-emacs-load-modules` function to load paired `-packages` and `-config` modules
- **Separation of Concerns**: 
  - `early-init.el`: Package archive configuration (loads crafted early init)
  - `init.el`: Main configuration file with module loading and custom configurations
  - `custom.el`: Auto-generated customizations from Emacs customize interface

### Directory Structure
- `elpa/`: Package installations managed by package.el
- `tree-sitter/`: Tree-sitter language grammars for syntax highlighting
- `snippets/`: YASnippet templates
- `tmp/`: Auto-save files and temporary data
- `.extension/`: Extension-related files
- `transient/`: Transient command history

### Language Support
The configuration supports multiple programming languages with LSP integration:
- **Go**: go-mode, go-ts-mode, gotest, with DAP debugging via dlv
- **Elixir**: elixir-mode, elixir-ts-mode with elixir-ls language server
- **Python**: python-mode, python-ts-mode
- **TypeScript/JavaScript**: typescript-mode, javascript-mode with tree-sitter variants
- **YAML**: yaml-mode, yaml-ts-mode
- **Docker**: dockerfile-mode, docker-compose-mode

### Development Tools
- **LSP**: Eglot is the primary language server client, auto-enabled for supported modes
- **Debugging**: DAP-mode configured for Go debugging, with UI components
- **Version Control**: Magit for Git integration
- **Terminal**: Multiple terminal options (vterm, eat)
- **Project Management**: Built-in project.el with recent files support
- **AI Integration**: 
  - claude-code.el package for Claude Code integration
  - gptel configured with GitHub Models API

## Common Commands

### Emacs Management
```bash
# Start Emacs
emacs

# Start Emacs in daemon mode
emacs --daemon

# Connect to daemon
emacsclient -c
```

### Development Workflow
- **LSP**: Language servers auto-start via `eglot-ensure` hooks
- **Debugging**: DAP mode available in Go projects
- **Testing**: gotest package provides Go testing integration
- **Snippets**: YASnippet enabled globally for code templates

### Key Bindings
- `C-c c`: Claude Code command map (when claude-code-mode is active)

## Setup Requirements

### Prerequisites
1. Clone Crafted Emacs to `~/crafted-emacs`:
   ```bash
   git clone https://github.com/SystemCrafters/crafted-emacs ~/crafted-emacs
   ```

2. Language servers must be installed separately:
   - Go: Install `gopls` and `dlv` (delve debugger)
   - Elixir: Install `elixir-ls`
   - Python: Install `pylsp` or similar

3. Tree-sitter grammars will be auto-installed on first run for: elixir, go, gomod, javascript, typescript, tsx, python

### Font Configuration
- Default font: Fira Code at height 105
- Ensure Fira Code is installed on the system

### Environment Tools
- **mise**: Runtime version manager integration
- **exec-path-from-shell**: Ensures shell PATH is available in Emacs

## Security Configuration

### Environment Variables
The configuration reads secrets from environment variables:
- `GITHUB_TOKEN`: GitHub personal access token for gptel API access

### Setup
1. Set the environment variable:
   ```bash
   export GITHUB_TOKEN="your_github_token_here"
   ```

2. Or create a `.env` file (ignored by git):
   ```bash
   echo "GITHUB_TOKEN=your_token_here" > ~/.emacs.d/.env
   ```
   Then source it in your shell profile.

## Troubleshooting

### Package Signature Issues
If you encounter "Failed to verify signature archive-contents.sig":
```bash
mkdir -p ~/.config/emacs/elpa/gnupg
gpg --homedir ~/.config/emacs/elpa/gnupg --keyserver hkps://keyserver.ubuntu.com --receive-keys 066DAFCB81E42C40
```

### Missing Crafted Emacs
Ensure `~/crafted-emacs` exists and contains the modules directory.

### Language Server Issues
Verify language servers are installed and in PATH. Use `M-x eglot-stderr-buffer` to debug LSP issues.