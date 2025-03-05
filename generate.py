# pylint: disable=missing-module-docstring

from os import makedirs
from textwrap import dedent

from requests import get, Response

BASE_VERSION: str = '2024.02'
MAINTAINER_NAME: str = 'Hendra Anggrian'
MAINTAINER_EMAIL: str = 'hanggrian@proton.me'
TARGETS = (
    {
        'platform': 'openjdk',
        'versions': ['8.0', '11.0', '17.0', '21.0'],
    },
    {
        'platform': 'android',
        'versions': ['2024.11', '2025.02'],
    },
    {
        'platform': 'python',
        'versions': ['3.12', '3.13'],
    },
)

# rebuild targets
new_targets = []
python = TARGETS[-1]
for target in TARGETS[:-1]:
    for python_version in python['versions']:
        for target_version in target['versions']:
            new_targets.append({
                'platform1': target['platform'],
                'version1': target_version,
                'platform2': python['platform'],
                'version2': python_version,
            })
TARGETS = tuple(new_targets)


def get_content(
    cimg_platform: str,
    cimg_version: str,
    dockerfile: str = 'Dockerfile',
):
    """Retrieve content from GitHub raw file."""
    url: str = \
        'https://github.com/CircleCI-Public/' + \
        f'cimg-{cimg_platform}/raw/' + \
        f'main/{cimg_version}/{dockerfile}'
    response: Response = get(url, timeout=6)
    response.raise_for_status()
    text: str = response.text.replace('\t', '  ')
    return url, text.split('@circleci.com>"\n', 1)[1]


if __name__ == '__main__':
    build_images_lines: str = \
        dedent(
            '''
            #!/usr/bin/env bash

            set -eo pipefail

            ''',
        ).lstrip()
    push_images_lines: str = \
        dedent(
            '''
            #!/usr/bin/env bash

            set -eo pipefail

            ''',
        ).lstrip()

    for target in TARGETS:
        dockerfile_lines: str = \
            dedent(
                f'''
                FROM cimg/base:{BASE_VERSION}

                LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
                ''',
            )
        dockerfile_comments: str = \
            dedent(
                '''
                # A combination of:
                #
                ''',
            ).lstrip()

        # standard images
        path, content = get_content(target['platform1'], target['version1'])
        dockerfile_lines += content
        dockerfile_comments += f'# - {path}\n'
        path, content = get_content(target['platform2'], target['version2'])
        dockerfile_lines += content
        dockerfile_comments += f'# - {path}\n'

        dir_name: str = \
            target['platform1'] + \
            target['version1'] + \
            '-' + \
            target['platform2'] + \
            target['version2']
        makedirs(dir_name, exist_ok=True)
        with open(f'{dir_name}/Dockerfile', 'w', encoding='UTF-8') as file:
            file.write(dockerfile_comments + dockerfile_lines)

        # node images are built on standard images
        dockerfile_node_lines: str = \
            dedent(
                f'''
                FROM hanggrian/cimg-multiplatform:{dir_name}

                LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
                ''',
            )
        _, content = \
            get_content(
                target['platform1'],
                target['version1'],
                'node/Dockerfile',
            )
        dockerfile_node_lines += content
        makedirs(f'{dir_name}/node', exist_ok=True)
        with open(f'{dir_name}/node/Dockerfile', 'w', encoding='UTF-8') as file:
            file.write(dockerfile_comments + dockerfile_node_lines)

        # browser images are built on standard images
        dockerfile_browsers_lines: str = \
            dedent(
                f'''
                FROM hanggrian/cimg-multiplatform:{dir_name}-node

                LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
                ''',
            )
        _, content = \
            get_content(
                target['platform1'],
                target['version1'],
                'browsers/Dockerfile',
            )
        dockerfile_browsers_lines += content
        makedirs(f'{dir_name}/browsers', exist_ok=True)
        with open(f'{dir_name}/browsers/Dockerfile', 'w', encoding='UTF-8') as file:
            file.write(dockerfile_comments + dockerfile_browsers_lines)

        # create shell scripts
        # pylint: disable=line-too-long
        build_images_lines += \
            dedent(
                f'''
                docker build --file {dir_name}/Dockerfile -t hanggrian/cimg-multiplatform:{dir_name} --platform linux/amd64 .
                docker build --file {dir_name}/node/Dockerfile -t hanggrian/cimg-multiplatform:{dir_name}-node --platform linux/amd64 .
                docker build --file {dir_name}/browsers/Dockerfile -t hanggrian/cimg-multiplatform:{dir_name}-browsers --platform linux/amd64 .

                ''',
            ).lstrip()
        push_images_lines += \
            dedent(
                f'''
                docker push hanggrian/cimg-multiplatform:{dir_name}
                docker push hanggrian/cimg-multiplatform:{dir_name}-node
                docker push hanggrian/cimg-multiplatform:{dir_name}-browsers

                ''',
            ).lstrip()

    with open('build_images.sh', 'w', encoding='UTF-8') as file:
        file.write(build_images_lines)

    with open('push_images.sh', 'w', encoding='UTF-8') as file:
        file.write(push_images_lines)
