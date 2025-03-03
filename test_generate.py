# pylint: disable=missing-module-docstring, missing-class-docstring, missing-function-docstring

from unittest import TestCase, main

from generate import get_content


class TestGenerate(TestCase):
    def test_get_content(self):
        _, content = get_content('openjdk', '8.0')
        self.assertTrue('LABEL maintainer' not in content)


if __name__ == '__main__':
    main()
