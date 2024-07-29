# pylint: disable=missing-module-docstring, missing-class-docstring, missing-function-docstring

from unittest import TestCase, main

from make_dockerfile import get_content


class TestMakeDockerfile(TestCase):
    def test_get_dockerfile_content(self):
        _, content = get_content('openjdk', '8.0')
        self.assertTrue('LABEL maintainer' not in content)


if __name__ == '__main__':
    main()
