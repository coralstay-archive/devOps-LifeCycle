# Unit test: content=docs-podman-io-en-stable | chapter=01_기본_개념 | section=01_페이지_핵심 | pages=1p
import pathlib

if __name__ == "__main__":
    main_file = pathlib.Path(__file__).with_name("main.py")
    assert main_file.is_file()
    print("PASS: 01_페이지_핵심")
