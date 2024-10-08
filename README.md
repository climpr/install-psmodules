# Install PowerShell Modules

This action installs the specified PowerShell modules and caches them in the repository cache.

## How to use this action

Use this as a step in an existing workflow

```yaml
# ...
steps:
  - name: Install PS Modules
    uses: climpr/install-psmodules@v0
    with:
      modules: |
        Az.Accounts:2.17.0
        Az.Billing:2.0.3
# ...
```
