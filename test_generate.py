from unittest import TestCase, main

from generate import get_content


class TestGenerate(TestCase):
    def test_main_cimg(self):
        url, content = get_content('openjdk', '17.0')
        self.assertEqual(
            'https://github.com/CircleCI-Public/cimg-openjdk/raw/main/17.0/Dockerfile',
            url,
        )
        self.assertTrue('LABEL maintainer' not in content)

    def test_contains_modern_package_managers(self):
        _, content = get_content('python', '3.13', 'Dockerfile')
        self.assertTrue('poetry' in content and 'uv' in content)

        _, content = get_content('python', '3.13', 'node/Dockerfile')
        self.assertTrue('yarn' in content and 'pnpm' in content)


if __name__ == '__main__':
    main()
