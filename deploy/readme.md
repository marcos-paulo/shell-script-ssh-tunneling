<h1 align="center">SSH Tunneling Deploy</h1>

If you want to deploy via the [deploy.sh](./deploy.sh) script, keep in mind that you must use an ssh connection which must be protected by ssh keys.

## Usage

Step 1: Copy the `env_example` file by renaming it to `env` in the project root.

```bash
cp env_example env
```

Step 2: Fill in the variable values of the `env` file that was created.

Step 3: run the `deploy.sh` script, passing the any branch name as a parameter

```bash
$ ./deploy.sh main
```
