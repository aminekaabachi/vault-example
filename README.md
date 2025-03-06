# vault-example

Databricks Data Vault Example with Delta Live Tables and Databricks SQL

## Prerequisites

- Databricks CLI installed
- Access to a Databricks workspace

## Getting Started

1. Install the Databricks CLI from [Databricks CLI Documentation](https://docs.databricks.com/dev-tools/cli/databricks-cli.html)

2. Authenticate to your Databricks workspace, if you have not done so already:
    ```sh
    databricks configure
    ```

3. To deploy a development copy of this project, type:
    ```sh
    databricks bundle deploy --target dev
    ```
    (Note that "dev" is the default target, so the `--target` parameter is optional here.)

    This deploys everything that's defined for this project.
    For example, the default template would deploy a job called `[dev yourname] vault_job` to your workspace.
    You can find that job by opening your workspace and clicking on **Workflows**.

4. Similarly, to deploy a production copy, type:
    ```sh
    databricks bundle deploy --target prod
    ```

    Note that the default job from the template has a schedule that runs every day (defined in `resources/vault.job.yml`). The schedule is paused when deploying in development mode (see [Databricks Deployment Modes](https://docs.databricks.com/dev-tools/bundles/deployment-modes.html)).

5. To run a job or pipeline, use the "run" command:
    ```sh
    databricks bundle run
    ```

6. Optionally, install developer tools such as the Databricks extension for Visual Studio Code from [Databricks VS Code Extension](https://docs.databricks.com/dev-tools/vscode-ext.html).

7. For documentation on the Databricks asset bundles format used for this project, and for CI/CD configuration, see [Databricks Asset Bundles](https://docs.databricks.com/dev-tools/bundles/index.html).

## Project Structure

The project is organized as follows:

- `resources/`: Contains job and pipeline definitions in YAML format.
- `src/`: Contains SQL and Python scripts that define the data processing logic.
- `.env.example`: Example environment variables file.
- `databricks.yml`: Main configuration file for the Databricks asset bundle.

## Additional Resources

- [Databricks CLI Documentation](https://docs.databricks.com/dev-tools/cli/index.html)
- [Databricks Asset Bundles](https://docs.databricks.com/dev-tools/bundles/index.html)
- [Databricks VS Code Extension](https://docs.databricks.com/dev-tools/vscode-ext.html)