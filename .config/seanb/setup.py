from setuptools import setup, find_namespace_packages  # type: ignore[import]


if __name__ == "__main__":
    setup(
        name="seanb",
        zip_safe=False,
        packages=find_namespace_packages(".", include=("seanb.*",)),
        author="Sean Breckenridge",
        author_email="seanbrecke@gmail.com",
        python_requires=">=3.8",
    )
