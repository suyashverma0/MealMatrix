import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parents[2]
DATA_DIR = BASE_DIR / "data" / "raw"


def load_data(file_name):
    file_path = DATA_DIR / file_name
    return pd.read_csv(file_path)


def load_all_data():
    files = list(DATA_DIR.glob("*.csv"))

    data = {}

    for file in files:
        data[file.stem] = pd.read_csv(file)

    return data


if __name__ == "__main__":
    data = load_all_data()

    for name, df in data.items():
        print(f"{name}: {df.shape}")