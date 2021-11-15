from setuptools import setup  # type: ignore[import]


if __name__ == "__main__":
    setup(
        name="seanb",
        zip_safe=False,
        packages=["seanb"],
        author="Sean Breckenridge",
        author_email="seanbrecke@gmail.com",
        python_requires=">=3.8",
    )
