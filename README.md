# Install PowerShell Modules

This GitHub Action installs specified PowerShell modules and caches them to improve reliability and performance in workflows. It ensures that the modules are installed with the correct versions and leverages caching to avoid redundant installations.

## Features

- Installs PowerShell modules with specified versions.
- Caches installed modules to speed up subsequent workflow runs.
- Ensures the PowerShell Gallery repository is trusted and properly configured.
- Automatically installs the latest version of a module if no version is specified.

## Inputs

| Name      | Description                                                                 | Required | Default |
|-----------|-----------------------------------------------------------------------------|----------|---------|
| `modules` | Multiline string specifying the modules and their versions in the format `<moduleName>:<version>`. Use `:latest` for the latest version, or omit `:<version>` to install the latest version. | Yes      | N/A     |

## Outputs

This action does not produce any direct outputs but ensures the specified modules are installed and cached.

## Usage

Add this action as a step in your GitHub workflow:

```yaml
# .github/workflows/example.yml
name: Example Workflow

on:
  push:
    branches:
      - main

jobs:
  install-modules:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Install PowerShell Modules
        uses: climpr/install-psmodules@v1
        with:
          modules: |
            Az.Accounts:2.17.0
            Az.Billing:2.0.3
            Pester
```

### Example Input Format

The `modules` input should be a multiline string where each line specifies a module and its version in the format `<moduleName>:<version>`. For example:

```yaml
modules: |
  Az.Accounts:2.17.0
  Az.Billing:2.0.3
  Pester:latest
  Az.Storage
```

- Use `:latest` to explicitly install the latest version of a module.
- Omit `:<version>` to also install the latest version.

## How It Works

1. **Repository Configuration**: The action ensures the PowerShell Gallery repository is registered and trusted.
2. **Module Parsing**: The specified modules and versions are parsed and formatted.
3. **Installation and Caching**: The modules are installed and cached using the [`psmodulecache`](https://github.com/potatoqualitee/psmodulecache) action.

## Notes

- If a module version is not specified (e.g., `Pester`), the action defaults to installing the latest version.
- Caching is handled automatically to improve workflow performance.

## License

This project is licensed under the [MIT License](LICENSE).
