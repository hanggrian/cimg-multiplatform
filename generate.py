# pylint: disable=missing-module-docstring

from os import makedirs

from requests import get, Response

BASE_VERSION: str = '2024.02'
MAINTAINER_NAME: str = 'Hendra Anggrian'
MAINTAINER_EMAIL: str = 'hanggrian@proton.me'
TARGETS: list[dict[str, str]] = [
    {'platform1': 'openjdk', 'version1': '8.0', 'platform2': 'python', 'version2': '3.12'},
    {'platform1': 'openjdk', 'version1': '11.0', 'platform2': 'python', 'version2': '3.12'},
    {'platform1': 'openjdk', 'version1': '17.0', 'platform2': 'python', 'version2': '3.12'},
    {'platform1': 'openjdk', 'version1': '21.0', 'platform2': 'python', 'version2': '3.12'},
    {'platform1': 'openjdk', 'version1': '8.0', 'platform2': 'python', 'version2': '3.13'},
    {'platform1': 'openjdk', 'version1': '11.0', 'platform2': 'python', 'version2': '3.13'},
    {'platform1': 'openjdk', 'version1': '17.0', 'platform2': 'python', 'version2': '3.13'},
    {'platform1': 'openjdk', 'version1': '21.0', 'platform2': 'python', 'version2': '3.13'},
    {'platform1': 'android', 'version1': '2024.11', 'platform2': 'python', 'version2': '3.12'},
    {'platform1': 'android', 'version1': '2025.02', 'platform2': 'python', 'version2': '3.12'},
    {'platform1': 'android', 'version1': '2024.11', 'platform2': 'python', 'version2': '3.13'},
    {'platform1': 'android', 'version1': '2025.02', 'platform2': 'python', 'version2': '3.13'},
]


def get_content(
    platform: str,
    version: str,
    dockerfile: str = 'Dockerfile',
):
    """Retrieve content from GitHub raw file."""
    url: str = f'https://github.com/CircleCI-Public/cimg-{platform}/raw/main/{version}/{dockerfile}'
    response: Response = get(url, timeout=6)
    response.raise_for_status()
    text: str = response.text.replace('\t', '  ')
    return url, text.split('@circleci.com>"\n', 1)[1]


if __name__ == '__main__':
    build_images_lines: str = \
        '''#!/usr/bin/env bash

set -eo pipefail

'''
    push_images_lines: str = \
        '''#!/usr/bin/env bash

set -eo pipefail

'''

    for target in TARGETS:
        dockerfile_lines: str = \
            f'''
FROM cimg/base:{BASE_VERSION}

LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
'''
        dockerfile_comments: str = \
            '''# A combination of:
#
'''

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

        dockerfile_node_lines: str = \
            f'''
FROM hanggrian/cimg-multiplatform:{dir_name}

LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
'''
        # node images are built on standard images
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
            f'''
FROM hanggrian/cimg-multiplatform:{dir_name}-node

LABEL maintainer="{MAINTAINER_NAME} <{MAINTAINER_EMAIL}>"
'''
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
        build_images_lines += \
            f'docker build --file {dir_name}/Dockerfile' + \
            f' -t hanggrian/cimg-multiplatform:{dir_name}' + \
            ' --platform linux/amd64 .\n' + \
            f'docker build --file {dir_name}/node/Dockerfile' + \
            f' -t hanggrian/cimg-multiplatform:{dir_name}-node' + \
            ' --platform linux/amd64 .\n' + \
            f'docker build --file {dir_name}/browsers/Dockerfile' + \
            f' -t hanggrian/cimg-multiplatform:{dir_name}-browsers' + \
            ' --platform linux/amd64 .\n\n'
        push_images_lines += \
            f'''docker push hanggrian/cimg-multiplatform:{dir_name}
docker push hanggrian/cimg-multiplatform:{dir_name}-node
docker push hanggrian/cimg-multiplatform:{dir_name}-browsers

'''

    with open('build_images.sh', 'w', encoding='UTF-8') as file:
        file.write(build_images_lines)

    with open('push_images.sh', 'w', encoding='UTF-8') as file:
        file.write(push_images_lines)
