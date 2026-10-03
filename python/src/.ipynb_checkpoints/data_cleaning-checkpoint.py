import pandas as pd


def remove_duplicates(df):
    return df.drop_duplicates().copy()


def handle_missing_values(df):
    df = df.copy()

    numeric_columns = df.select_dtypes(include="number").columns
    categorical_columns = df.select_dtypes(include="object").columns

    df[numeric_columns] = df[numeric_columns].fillna(0)
    df[categorical_columns] = df[categorical_columns].fillna("Unknown")

    return df


def convert_datetime(df, columns):
    df = df.copy()

    for column in columns:
        if column in df.columns:
            df[column] = pd.to_datetime(df[column], errors="coerce")

    return df


def clean_data(df, datetime_columns=None):
    df = remove_duplicates(df)
    df = handle_missing_values(df)

    if datetime_columns:
        df = convert_datetime(df, datetime_columns)

    return df


def get_data_quality_report(df):
    report = pd.DataFrame({
        "column": df.columns,
        "missing_values": df.isnull().sum().values,
        "unique_values": df.nunique().values,
        "data_type": df.dtypes.astype(str).values
    })

    return report


if __name__ == "__main__":
    print("Data cleaning module loaded successfully.")