# Setup Python virtual environment (virtualenv)

You will run Mls in separated `virtual environment`

```bash
# create virtualenv in directory /mls/.venv
python3 -m venv .venv

# run virtualenv
source .venv/bin/activate

# deactivate virtualenv
deactivate
```

# Install python dependencies

```bash
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
python3 -m pip install -e .
```

# Usage

To create MLModel, simply run the following command:

```bash
mls train
```
